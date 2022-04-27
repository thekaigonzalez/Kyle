module unit;

import kyle;
import std.file;
import std.stdio;

void hello(kyle_arguments Args, kyle_state S) {
    writeln("Testing!");
    writeln(kyle_vararg!(int).kyle_convert_argument(0, Args) + kyle_vararg!(int).kyle_convert_argument(1, Args));
}

void world(kyle_arguments a, kyle_state l) {
    writeln(kyle_vararg!(string).kyle_convert_argument(0, a));
}

void main() {
    auto env = kyle_new();

    kyle_allow_module(env);

    kyle_add_delegate(
        env, 
        &hello, 
        "hello"
    );

    kyle_add_delegate(
        env, 
        &world, 
        "world"
    );

    kyle_set_code(env, "#mod main;\n? Test Command\n#hello 1 1;\n#world \"hello owlr\";");

    kyle_execute(env);

    auto env1 = kyle_new();
    kyle_allow_module(env1);

    kyle_add_delegate(
            env1, 
            &world, 
            "print"
        );

    kyle_set_code(env1, cast(string)read("main.kyle"));
    
    writeln("mod name: " ~ kyle_toplevel_module(env));

    kyle_execute(env1);

}