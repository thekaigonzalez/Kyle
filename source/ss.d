module ss;

// Setting variables

import kobj;
import ky;

void kyle_set(kyle_state s, string n, string v) {
    s.storage[n] = v;
}

void kyle_set(kyle_state s, kyle_object v, string n) {
    s.storageO[n] = v;
}