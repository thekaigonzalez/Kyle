module cp;

/// Transferring things from states.

import kobj;

void kyle_transfer_delegates(kyle_state s1, kyle_state s2) {
    s2.deles = s1.deles;
}

void kyle_transfer_storage(kyle_state s1, kyle_state s2) {
    s2.storage = s1.storage;
}