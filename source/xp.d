module xp;

// Expressions.

import xps;
import ec;
import st;

import std.typecons : tuple, Tuple;
import std.stdio;
import std.string;
import std.algorithm;

// This functions returns two values.
Tuple!(string[], kyle_expr_type) kyle_each_side(string Full)
{
    state C = state.idle;
    kyle_expr_type t = kyle_expr_type.review;
    string b;
    string s1;
    string[] g;
    string s2;

    foreach (char s; Full)
    {
        if (s == '=' && C == state.idle)
        {
            if (b.length > 0)
            {
                C = state.collecting;
                g = g ~ strip(b);
                b = "";
            }
        }
        else if (s == '=' && C == state.collecting)
        {
            if (b.length > 0)
            {

                t = kyle_expr_type.compareTo;
                g = g ~ strip(b);
                b = "";
            }
            C = state.idle;
        }
        else
        {
            b = b ~ s;
        }
    }
    if (b.length > 0 && t == kyle_expr_type.compareTo)
        g = g ~ strip(b);

    if (C == state.collecting)
    {
        throw new KyleAssignOpError("Assignments are not allowed in if blocks.");
    }

    return tuple(g, t);
}
