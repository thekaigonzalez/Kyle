module ku;

import kobj;
public import exec;
import kc;

/* Kyle utilities */

void kyle_allow_module(kyle_state s)
{
    s.use_mod = true;
}

kyle_state kyle_new() { 
    return new kyle_state();
}

string kyle_toplevel_module(kyle_state l) {
    return l.toplevel_header;
}

