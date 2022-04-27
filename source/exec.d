module exec;

import std.stdio;
import std.conv;
import std.string;
import std.algorithm;

// contains the stuff for like the language..

import kobj;
import cv;
import xp;
import st;
import kt;
import kc;
import so;
import cp;
import ku;
import ps;
import vl;
import ct;
import xps;
import va;

void kyle_execute(kyle_state s)
{
    state st = state.idle;
    kyle_context ctx = kyle_context.none;

    string blc;
    string fname;
    kyle_arguments arg = new kyle_arguments();
    foreach (char l; s.supplied_code)
    {
        if (s.err)
            break;
        if (l == '#' && st == state.idle)
        {
            st = state.collecting;
            blc = "";
        }
        else if (l == '@' && st == state.idle)
        {
            st = state.collectetc;
            ctx = kyle_context.ifstatement;

            blc = "";
        }
        else if (l == '{' && ctx == kyle_context.ifstatement)
        {
            kyle_expr_type t = kyle_each_side(blc)[1];

            string[] sides = kyle_each_side(blc)[0];

            string side1 = "";
            string side2 = "";

            if (t == kyle_expr_type.compareTo)
            {
                side1 = sides[0];
                if (kyle_has_value(s, sides[0]))
                {
                    side1 = kyle_getvalue(s, sides[0]);
                }

                side2 = sides[1];
                if (kyle_has_value(s, sides[1]))
                {
                    side2 = kyle_getvalue(s, sides[1]);
                }
                if (side1 == side2)
                {
                    ctx = kyle_context.gathering;
                }
            }
            else if (t == kyle_expr_type.review)
            {
                if (kyle_has_value(s, sides[0]))
                {
                    string val = kyle_getvalue(s, sides[0]);

                    if (to!bool(val))
                    {
                        ctx = kyle_context.gathering;
                    }
                } else {
                    if (kyle_parsebool(sides[0])) ctx = kyle_context.gathering;
                }
            }

            st = state.rely;

            blc = "";
        }
        else if (l == '}' && ctx == kyle_context.gathering)
        {
            // COPY ALL DELEGATES OVER TO SCOPE 2

            auto if_block = kyle_new();

            kyle_transfer_delegates(s, if_block);

            kyle_set_code(if_block, strip(blc));

            kyle_execute(if_block); // execute the if block

            st = state.idle;
            blc = "";
            ctx = kyle_context.none;
        }
        else if (l == ' ' && st == state.collecting)
        {
            st = state.blocking;
            ctx = kyle_context.running;
            fname = strip(blc);
            blc = "";
        }
        else if (l == ' ' && st == state.blocking && ctx == kyle_context.running)
        {
            if (blc.length > 0)
            {
                arg.outType = arg.outType ~ blc;
                blc = "";
            }
        }

        else if (l == '"' && st == state.blocking)
        {
            st = state.stoned;
        }
        else if (l == '"' && st == state.stoned)
        {
            st = state.blocking;
        }

        else if (l == s.line_ending && st == state.blocking)
        {
            if (blc.length > 0)
                arg.outType = arg.outType ~ blc;

            st = state.idle;
            ctx = kyle_context.none;
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
        else if (l == s.comment_op && st != state.blocking)
        {
            st = state.ignorant;
        }
        else if (l == s.comment_break && st == state.ignorant)
        {
            blc = "";
            st = state.idle;
            continue;
        }
        else if (l == '\n' && st == state.idle)
            continue;

        else if (l == s.line_ending && st == state.blocking)
        {
            s.err = true;
            s.errmsg = ("unexpected token '#' where `blocking' was expected, maybe `;' was needed?");
        }
        else
        {
            blc = blc ~ l;
        }
    }
}
