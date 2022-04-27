module exec;

import std.stdio;

// contains the stuff for like the language..

import kobj;
import cv;
import std.string;
import std.algorithm;
import va;

void kyle_execute(kyle_state s)
{
    int state = 0;
    string blc;
    string fname;
    kyle_arguments arg = new kyle_arguments();
    foreach (char l; s.supplied_code)
    {
        if (s.err)
            break;
        if (l == '#' && state == 0)
        {
            state = 1;
            blc = "";
        }
        else if (l == ' ' && state == 1)
        {
            state = 2;
            fname = strip(blc);
            blc = "";
        }
        else if (l == ' ' && state == 2)
        {
            if (blc.length > 0)
            {
                arg.outType = arg.outType ~ blc;
                blc = "";
            }
        }
        else if (l == '"' && state == 2) { state = -1; }
        else if (l == '"' && state == -1) { state = 2; }
        else if (l == s.line_ending && state == 2)
        {
            if (blc.length > 0)
                arg.outType = arg.outType ~ blc;

            state = 0;
            if (fname == "mod")
            {
                if (s.use_mod)
                    s.toplevel_header = kyle_vararg!(string).kyle_convert_argument(0, arg);
            }
            else if (fname in s.deles)
            {
                s.deles[fname](arg, s);
            }

            blc = "";
            arg = new kyle_arguments();
        }
        else if (l == s.comment_op && state >= 0)
        {
            state = 6;
        }
        else if (l == s.comment_break && state == 6)
        {
            blc = "";
            state = 0;
            continue;
        }
        else if (l == '\n' && state == 0)
            continue;

        else if (l == s.line_ending && state == 1)
        {
            s.err = true;
            s.errmsg = ("unexpected token '#', maybe `;' was needed?");
        }
        else
        {
            blc = blc ~ l;
        }
    }
}
