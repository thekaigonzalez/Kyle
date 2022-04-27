module unit;

import kyle;
import std.stdio;

void hello(kyle_arguments Args, kyle_state S) {
    writeln("Testing!");
    writeln(kyle_vararg!(int).kyle_convert_argument(0, Args) + kyle_vararg!(int).kyle_convert_argument(1, Args));
}

void main() {
    auto env = kyle_new();

    kyle_allow_module(env);

    kyle_add_delegate(
        env, 
        &hello, 
        "hello"
    );

    kyle_set_code(env, "#mod main;\n? Test Command\n#hello 1 1;");

    kyle_execute(env);

    writeln("mod name: " ~ kyle_toplevel_module(env));
}