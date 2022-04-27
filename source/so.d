module so;

// Storage.

import kobj;
import vl;

string kyle_getvalue(kyle_state s, string vname) {
    if (kyle_has_value(s, vname)) 
    return s.storage[vname];
    else
    return "";
}