module oj;

/// Getting values.
// retrieving, nameed like my dog, OJ.

import ky;
import kobj;
import ke;
import sov;
import ni;

kyle_object kyle_get(kyle_state s, string name) {
    if (kyle_objects_has(name, s)) {
        return s.storageO[name];
    }

    return new kyle_null();
}