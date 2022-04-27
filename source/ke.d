module ke;

/// Kyle basic type-to-type

import ky;
import std.conv;

template kyle_convert (C) {
    C object_to(kyle_object obj) {
        return to!C(obj.it);
    }
}