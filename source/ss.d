module ss;

// Setting variables

import kobj;

void kyle_set(kyle_state s, string n, string v) {
    s.storage[n] = v;
}