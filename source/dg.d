module dg;

// Delegate handling

import kobj;
import va;

void kyle_add_delegate(kyle_state k, void function(kyle_arguments, kyle_state) fn, string name) {
    k.deles[name] = fn;
}