module cv;

// Conversion

import std.conv;
import std.stdio;
import va;

template kyle_vararg(T) {
    // Converting the argument to the type T.
    T kyle_convert_argument(int pos, kyle_arguments s) {
        return to!T(s.outType[pos]);
    }
}