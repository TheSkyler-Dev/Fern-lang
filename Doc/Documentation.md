## Table of Contents
- [What is Fern?](#what-is-fern)
- [The Fern Philosophy](#the-fern-philosophy)
- [Principles of Fern](#principles-of-fern)
- [Syntax at a Glance](#syntax-at-a-glance)
- [Variables](#variables)
- [Data Structures](#data-structures)
- [Basic I/O](#basic-io)
- [Template Literals](#template-literals)
- [Namespaces](#namespaces)
- [Comments](#comments)
- [Control Flow](#control-flow)
- [Functions and Classes](#functions-and-classes)
- [Asynchronous Code](#asynchronous-code)
- [Error Handling](#error-handling)
- [Syntax Highlighting](#syntax-highlighting)

# What is `Fern`?
`Fern` is a general purpose programming language with its main strengths in systems programming, AI, CLI tools and scripting, among others.

## The `Fern` philosophy
`Fern` is designed to be concise, easy to read, lightweight and flexible. Its syntax is inspired by Rust, C++ and, to some extent, Swift. `Fern`'s support for Ahead-of-time (AOT), Just-in-time (JIT) compilation, as well as interpretation is intended to provide usage-dependent flexibulity, such as using interpretation for rapid prototyping or scripting. `Fern` emohasizes memory and type safety with multiple  kinds of memory managements, such as manual, reference counting and garbage collection, specifiable by the developer. That way, `Fern` is versatile for many applications! An intuitive, yet robust programming language.

## The principles of `Fern` at a glance
- `Fern` uses a flag-based configuration at the top of your source code.
- variable types **must** be declared with explicit data types and be initialized with, at the very least, a default value.
- `Fern`'s syntax is concise
- `Fern` code runs syncronously by default and allows for explicit asynchoniety
- `Fern` is interoperable with C++ and Rust and their libraries
- `Fern` discards unused components when compiled, reducing overhead

## `Fern` syntax at a glance
### configuration flags
- `#incl` Used to include libraries
- `#use {component1, component2...} from {library}` specify library components to be used (only works on `Fern`-native libraries)
- `#RUNMODE` specify how the code is to be run
	- `aot` Ahead-Of-Time compilation
	- `jit` Just-In-Time compilation
	- `interpret` run in an interpreter
- `#MEM` specify memory management mode
	- `man` manual memory management (this is the default mode. the `#MEM` flag can be omitted in this case)
	- `ref` reference counting
	- `auto` garbage collection
- `#MULTIDISP` specify wether multiple dispatch should be allowed (disabled by default). `allow` enables multiple dispatch

### Syntax and style conventions
`Fern` follows common code conventions seen in languages like C++ and Rust. While not strictly enforced (you generally can use `tab` for indentation), It is generally recommended to use four spaces per indentation rather than `tab`, as per [Google's style guidelines](https://tinyurl.com/42h9tfy8). Each statement must end with a semicolon (`;`). variable, function and calss names are strictly case sensitive. For Class names, `PascalCase` should be used, while function and variable names should either adhere to `camelCase`. The use of `kebab-case` or `snake_case` in function or variable names can be done when necessary, depending on the context.
## Variables
### Data Types
- `str` String
- `int` Integer
- `db` Double precision floating point
- `bool` Boolean
- `ul` Unsigned long interger

Note that variables of type `db` support double precision floating points with up to 16 decimal positions, as well as subnormal floating points.

### More on variables
Variables in `Fern` aren't directly nullable for memory safety. It is generally good practice to initialize variables as they're declared. Recommended default values for varables, including one that kinda works like assigning null to a numeric variable are:

`int` or `db`:
- `NaN` (only when a truly empty value is needed)
- `0`
- `0.0`

`str`:
- `"def"`
- `"default"`

Variables of types `bool` or `ul` should be assigned the value `false` or `0l` respectively as defaults, unless required otherwise by your project.

**Syntax example: declaring a variable**
```Fern
str myString = "def";
int myInt = 0;
db myDouble = 0.0;
bool myBool = false;
ul myUlong = 0l;
```

## Data structures
`Fern` supports various data structures such as Arrays `array`, Dictionaries `dict` and Object collections `col`. Object collections let you organize objects in a collection like a list, from which each object and its properties can externally be accessed. Each object within an object collection requires the keyword `obj` before the object name.

**An example of a `Fern` object collection:**
```Fern
col people = {
    obj person1:
        "Name": "Jane Doe",
        "Age": 25,
        "Occupation": "Software engineer"
    
    obj person2:
        "Name": "John Doe",
        "Age": 27,
        "Occupation": "Police Lieutenant"
};
```
## Basic I/O
Input and Output is generally handled like any other language. However, the syntax is different to other programming languages. Fern uses `out` for output and `in` for input. The `in` function supports input prompts, written within the parentheses, enclosed in double or single quotes.
### `Fern` I/O example:
```Fern
frn::out("Hello");

str input = frn::in("Some input prompt (optional)");
```

## Template literals
`Fern` supports template literals. here, it doesn't matter wether the string is enclosed in single or double quotes. Template literals allow you to insert values from variables or perform (mathematical) expressions within a string.
```Fern
int x = 9;
int y = 10;
str name = "Jane Doe";
str example = "$name says that $x + $y equals ${x + y}.";
frn::out(example);
```
Note that expressions like, in this example, `x + y` must be enclosed in curly braces.

### Namespaces
The standard namespace is `frn::`. Any standard libraries included with `Fern` can be called with either `frn::` or  the library's own namespace.

### `Fern` comments
- `//` Normal comment
- `/*...*/` Multiline comment

## Loops
`Fern` supports your usual types of loops: `while`-loops, `do ... while` loops, `for` loops. In `Fern`, these essentially work the same as in C++

### Control flow
- `if`, `elif`, `else`
- Switch statement:
```Fern
sw ({condition}){
    case 1 {
	    //case 1 code here
    }
	...
    def {
	    //default case
	}
}
```

### Functions and Classes
- Functions are declared with the `fn` keyword
- Classes are declared with the `cl` keyword and can be external.

#### `Fern` function example
```Fern
fn myFunc(){
	//function contents
};
```

#### `Fern` class example
```Fern
cl myClass(){
	constr:{
		//constructor
	};
	
	pub:{
		//public methods
	};
	
	prot:{
		//protected methods
	};
	
	priv:{
		//private methods
	};
}
```

## Asynchronous code in `Fern`

`Fern` code is executed synchronously by default. However, sometimes, for example when you need to continuiously read sensor data, you need to make parts of the code asynchronous. For this, the keywords `desync`, `resync` and `expect` are used. Here#s an example:
```Fern
desync fn myAsyncFunc(){
	//some code
	db sensorData = {sensordata};
	return sensorData;
} resync;
expect db data = myAsyncFunc();
```
Note that the asynchronous block has to start with `desync` and end with `resync`. These keywords are located before any declaration, on the same line.

## Error handling
`Fern`, by default, already handles errors fairly well with concice error messages, however, you may want to handle possible errors in your programs more gracefully. that's where the `try` `catch` statement comes in. it works no different than in other programming languages, however providing an error code and error meassage works slightly differently:
```Fern
try {
    //some code here
} 
catch {
    throw(frn::err(int err = ecode(); msg("Error message", pref(err)));
}
```
Note that the `frn::` namespace is only called on `err`. `Fern` has the unique feature where the namespace is inferred for every element within a standard funtion, in this case the `err()` function. This reduces verbosity, but you can optionally call the namespace on every element within the function. If you call a function from a different namespace, for example for 3rd party libraries, you have to explicitly call its functions by the namespace of the 3rd party library within a standard function.

## Syntax highlighting

`Fern` can use any widely known syntax highlighting scheme, but the standard syntax highlighting for `Fern` takes inspiration from the syntax highlighting used for Swift in the XCode modern Dark theme for VSCode:

- Keywords (`fn`, `cl`, etc.): Persian pink (#F77FBE)
- Variables and constants : white #FFFFFF(dark mode), black #000000 (light mode)
- Strings: Salmon red (#FA8072)
- Template literals (`$`, `${}`) Dark magenta (#8B008B)
- Function names: steel blue (#4682B4)
- Class names: light steel blue (#B0C4DE)
- Data types: Lavender (#E6E6FA)
- Unused variables and functions: Navy Gray (#656B83)

`Fern` also resolves invisible characters:
- Zero-Width Space: `<ZWSP>` (red (#FF0000) translucentbackground)
- Whitespace: `<WSPACE>` (orange (#FFA500) translucent background and underline)
- EM Space: `<EM>` (fluorescent yellow (#CCFF00) translucent background and underline)
- Exessive indentation (`tab`or `spce`): unresolved (translucent yellow (#FFFF00) background)
