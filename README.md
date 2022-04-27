# Kyle

A simple C-Style macro-based Programming language written in D. (Excla 2022)

A sample File would be:

```kyle
? Mod is an instruction to give the file a name.

#mod main

#test_function 1 2 3 4 "fifth argument"

```

with a basic API.

```d
import kyle;

void test_function(kyle_arguments ArgList) {
 string l = kyle_vararg!(string).kyle_convert_argument(0, ArgList);
}

void main(string[] args) {
 auto s = kyle_new(); // create a new Kyle Scope
 
 kyle_allow_module(s); // Allow the module header.

 kyle_add_delegate(s, 
  &test_function,
  "test_function");
 
 kyle_set_code(s, "#print \"hello!\";");

 kyle_execute(s); // Execute.

 // After execution, you can gather information afterward.

 string module_name = kyle_toplevel_module(s);

 writeln("The module name: " ~ module_name);
}
```

## Speed

The speed of Kyle is very fast.

Upon multiple tests on the unit, it took around `18` miliseconds to execute. To put that in perspective,
the original Exclamation language took around `34` miliseconds, with the D version taking `26`.

Which means, out of all of the other implementations, Kyle is the **fastest**, and most **reliable** implementation of Excla/Kyle.

## Basics

### The IF Statement

The if statement works in a very usual way, it checks if the given statement is true, using it's syntax `@ <expr> { <code> }`, then it will
run \<code> if \<expr> is true.

Future versions will allow \<expr> to be boolean values (convertable)

The implementation works like this:

```d
auto if_block = kyle_new();

kyle_transfer_delegates(s, if_block);

kyle_set_code(if_block, strip(blc));

kyle_execute(if_block); // execute the if block
```

It will transfer it's functions, but not the variables. So be careful!
