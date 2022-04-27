# Kyle

A simple C-Style macro-based Programming language written in D.

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
 
 kyle_set_code("#print \"hello!\";");

 kyle_execute(s); // Execute.

 // After execution, you can gather information afterward.

 string module_name = kyle_toplevel_module(s);

 writeln("The module name: " ~ module_name);
}
```
