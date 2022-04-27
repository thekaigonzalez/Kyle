module vl;

// Validity checking.

import kobj;

bool kyle_has_value(kyle_state S, string VN) {
    return ((VN in S.storage) !is null);
}