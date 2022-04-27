module sov;

// Storage object validating

import kobj;

bool kyle_objects_has(string objnam, kyle_state l) {
    return ((objnam in l.storageO) !is null);
}