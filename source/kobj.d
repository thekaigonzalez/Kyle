module kobj;

import std.stdio;
import va;
import ke;
import ky;

class kyle_state
{
    public:
    string toplevel_header = ""; /* the top level module name */
    void function(kyle_arguments, kyle_state)[string] deles; /* a list of builtin functions for this scope. */
    bool use_mod = false; /* should top level modname be allowed? */
    char line_ending = ';'; /* the default line ending, ';' by default. */
    char comment_break = '\n'; /* the comment break - applies to one line comments. */
    char comment_op = '?'; /* the comment operator. */
    string supplied_code = "";
    string[string] storage; /* store string values k=v */
    kyle_object[string] storageO;
    int err = 0;
    string errmsg;
}
