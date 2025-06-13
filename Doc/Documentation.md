## Table of Contents
- [What is Stingray?](#what-is-Stingray)
- [The Stingray Philosophy](#the-Stingray-philosophy)
- [Principles of Stingray](#the-principles-of-Stingray-at-a-glance)
- [Stingray Syntax at a Glance](#Stingray-syntax-at-a-glance)
- [Variables](#variables)
- [Basic Arithmetic](#basic-arithmetic)
- [Data Structures](#data-structures)
- [Basic I/O](#basic-io)
- [Template Literals](#template-literals)
- [Namespaces](#namespaces)
- [Comments](#Stingray-comments)
- [Loops](#loops)
- [Control Flow](#control-flow)
- [Conditionals](#conditionals)
- [Functions and Classes](#functions-and-classes)
- [Pointers and References](#pointers-and-references)
- [Asynchronous Code](#asynchronous-code-in-Stingray)
- [Error Handling](#error-handling)
- [Syntax Highlighting](#syntax-highlighting)
- [Compilers/Toolchains](#compilerstoolchains)

# What is `Stingray`?
`Stingray` is a general purpose programming language with its main strengths in systems programming, CLI tools and scripting, among others.

## The `Stingray` philosophy
`Stingray` is designed to be concise, easy to read, lightweight and flexible. Its syntax is inspired by Rust, C++ and, to some extent, Swift. `Stingray`'s support for Ahead-of-time (AOT) and interpretation is intended to provide usage-dependent flexibility, such as using interpretation for rapid prototyping or scripting. `Stingray` emphasizes memory and type safety with multiple  kinds of memory managements, such as manual, reference counting and garbage collection, specifiable by the developer. That way, `Stingray` is versatile for many applications! An intuitive, yet robust programming language.

## The principles of `Stingray` at a glance
- `Stingray` uses a flag-based configuration at the top of your source code.
- variable types **must** be declared with explicit data types and be initialized with, at the very least, a default value.
- `Stingray`'s syntax is concise
- `Stingray` code runs synchronously by default and allows for explicit synchronicity
- `Stingray` is interoperable with C++ and Rust and their libraries
- `Stingray` discards unused components when compiled, reducing overhead

## ⚠️ Not Recommended for Beginners

`Stingray` is **not recommended as a first programming language** for individuals new to programming. The language is designed with experienced developers in mind who already understand fundamental programming concepts and paradigms. 

Here's why `Stingray` may be challenging for beginners:
- Multiple memory management options require understanding of different memory paradigms
- The flexibility between AOT and interpretation assumes prior knowledge of compilation methods
- Advanced features like pointers, references, and explicit asynchronous programming require solid programming foundations
- The syntax, while concise, assumes familiarity with similar languages like Rust and C++

If you're just starting your programming journey, we recommend beginning with languages specifically designed for education (like Python, JavaScript, or Go), and then exploring `Stingray` once you've gained experience with programming fundamentals.

## `Stingray` syntax at a glance
### configuration flags
- `#incl` Used to include libraries
- `#use {component1, component2...} from {library}` specify library components to be used (only works on `Stingray`-native libraries)
- `#RUNMODE` specify how the code is to be run
	- `aot` Ahead-Of-Time compilation
	- `interpret` run in an interpreter
- `#MEM` specify memory management mode
	- `man` manual memory management (this is the default mode. the `#MEM` flag can be omitted in this case)
	- `ref` reference counting
	- `auto` garbage collection
- `#MULTIDISP` specify whether multiple dispatch should be allowed (disabled by default). `allow` enables multiple dispatch. If activated, the data type of the arguments passed to a function/method has to be explicitly defined with a data type.

> **IMPORTANT**:
> Both the `#incl` and `#use ... from ...` flags assume your libraries and classes are located in an `include` directory (usually a folder called `include` in your project root directory). Should you organize your external classes in a subdirectory within `include` or have them in a separate folder located in the project root directory, you can use the `#inclconfig` flag to explicitly specify the directories for your libraries and classes:
> 
> ```Stingray
> #inclconfig libinclude="custom/include/path", clinclude="custom/class/path"
> ```
> 
> This flag should appear before the `#incl` flag.  This tells `Stingray`, where to fetch library or external class contents from during development and in interpreted mode. In compilation mode, it would use CMake, so the `#inclconfig` flag should be omitted in production code, since it is meant strictly for rapid prototyping and scripting.

### Syntax and style conventions
`Stingray` follows common code conventions seen in languages like C++ and Rust. While not strictly enforced (you generally can use `tab` for indentation), It is recommended to use four (4) spaces per indentation rather than `tab`, as per [Google's style guidelines](https://tinyurl.com/42h9tfy8). Each statement must end with a semicolon (`;`). variable, function and class names are strictly case sensitive. For Class names, `PascalCase` should be used, while function and variable names should either adhere to `camelCase`. The use of `kebab-case` or `snake_case` in function or variable names can be done when necessary, depending on the context. It is best practice to insert spaces between variable names/the value to be assigned and the assignment operator (`=`) to enhance readability.
## Variables
### Data Types
- `str` String
- `int` Integer (`int64` by default, can be explicitly defined otherwise with `int32`)
	- `int32` 32-bit integer
- `db` Double precision floating point (`db64`by default, can be set to `db32`)
	- `db32` 32-bit floating point (designated as `db32` to maintain consistency since normal floating points don't exist as their own data type)
- `bool` Boolean
- `ul` Unsigned long integer

Note that variables of type `db` support double precision floating points with up to 16 decimal positions, as well as subnormal floating points. Constants can be declared by using the `const` keyword before the data type.

### More on variables
Variables in `Stingray` aren't directly nullable for memory safety. It is generally good practice to initialize variables as they're declared. Recommended default values for variables, including one that kinda works like assigning null to a numeric variable are:

`int` or `db`:
- `NaN` (only when a truly empty value is needed)
- `0`
- `0.0`

`str`:
- `"def"`
- `"default"`
- `nil` 

Variables of types `bool` or `ul` should be assigned the value `false` or `0l` respectively as defaults, unless required otherwise by your project. The value `nil` for variables of type `string` are supported, but should only be used when a truly empty string variable is required, for example when the variable should not be usable unless assigned a valid value through user input.

**Syntax example: declaring a variable**

```Stingray
str myString = "def";
str myString2 = nil;
int myInt = 0;
int myInt2  = NaN;
db myDouble = 0.0;
db myDouble2 = NaN;
bool myBool = false;
ul myUlong = 0l;
```

## Basic Arithmetic
Mathematical operations in `Stingray` are very straight forward and includes the following operators:
- **`+`**: Addition
- **`-`**: Subtraction
- **`/`**: Division
- **`*`**: Multiplication
- **`%`**: Modulo
- **`!`**: Factorial

Here are some example of their usage:

```Stingray
ray::out(16 + 16);
ray::out(16 - 8);
ray::out(32 / 2);
ray::out(10 * 10);
ray::out(1024 % 8);
ray::out(5!);
```
Note that  it is recommended to put spaces between the operands and operators for better readability. In the case of a factorial, there should never be a space between the number and the factorial (`!`) operator. More advanced operators like Exponentation, (square) roots and constants are included in the standard `math` library.

### The `math` library
The standard `math` includes useful constant and advanced operators like:

**constants**:
- **`pi`**: represents π constant
- **`eul`**: represents Euler's constant
- **`inum`**: represents the imaginary unit
- **`tau`**: represents the τ constant representing a full rotation around a circle in radians

**Operators/Functions**:
- **`**`**: Exponentation (alias for the `exp()` function)
- **`sqrt()`**: Used to calculate square roots of numbers or expressions
- **`nrt()`**: Non square root. The factor n has to be defined as the first number within the parentheses, followed by the expression, separated by a comma
- **`sin()`**: Calculates sine of the value passed to it
- **`cos()`**: Calculates cosine of the value passed to it

## Data structures
`Stingray` supports various data structures such as Arrays `array`, Dictionaries `dict` and Object collections `col`. Object collections let you organize objects in a collection like a list, from which each object and its properties can externally be accessed. Each object within an object collection requires the keyword `obj` before the object name.

**An example of a `Stingray` object collection:**

```Stingray
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
Input and Output is generally handled like any other language. However, the syntax is different to other programming languages. Stingray uses `out` for output and `in` for input. The `in` function supports input prompts, written within the parentheses, enclosed in double or single quotes.
### `Stingray` I/O example:

```Stingray
ray::out("Hello");

str input = ray::in("Some input prompt (optional)");
```

input can require user input with the `.req` marker:

```Stingray
str input = ray::in("some input prompt").req;
int numIn = ray::in("some input prompt").req; //required input
```
## Template literals
`Stingray` supports template literals. Here, it doesn't matter whether the string is enclosed in single or double quotes. Template literals allow you to insert values from variables or perform (mathematical) expressions within a string.

```Stingray
int x = 9;
int y = 10;
str name = "Jane Doe";
str example = "$name says that $x + $y equals ${x + y}.";
ray::out(example);
```

Note that expressions like, in this example, `x + y` must be enclosed in curly braces.

### Namespaces
The standard namespace is `ray::`. Any standard libraries included with `Stingray` can be called with either `ray::` or  the library's own namespace.

### `Stingray` comments
- `//` Normal comment
- `/*...*/` Multi-line comment

## Loops
`Stingray` supports your usual types of loops: `while`-loops, `do ... while` loops, `for` loops. In `Stingray`, these essentially work the same as in C++. Variables in `Stingray` support modifiers like `++` for incrementing by one or `--` for decrementing the value of a variable by one. 

`while` loop:

```Stingray
while(true){
    //some code
};
```

`do-while` loop example:

```Stingray
do {
    //some code
} while(<condition>);
```

`for` loop example:

```Stingray
for(int i = 0; <condition>; i++){
    //some code (e.g. a list iterator)
};
```

### Control flow
- `if`, `elif`, `else`
- Switch statement:

```Stingray
sw ({condition}){
    case 1 {
	    //case 1 code here
    };
	...
    def {
	    //default case
	};
};
```

## Conditionals
`Stingray` generally supports all logic operators like AND (`&&`), OR (`||`) etc. and use the generally recognized symbols for doing so. These can also be used in bitwise operations. Additionally, Elvis operators (`:?`) are also supported by `Stingray`. operators like `&&` and `||` can also be used in control flow when you need to cover a condition with a single code block or need two conditions to be true for a certain block of code to execute.

Logical operators in control flow:

```Stingray
int num1 = 0;
int num2 = 0;
num1 = ray::in("Enter num 1: ");
num2 = ray::in("Enter num 2: ");
if(num1 == 1 && num2 == 0){
    //some code here
}
```

Elvis operator example:

```Stingray
str username = nil;
str displayName = !username.empty() ? username : "Guest";
```

### Functions and Classes
- Functions are declared with the `fn` keyword
- Classes are declared with the `cl` keyword and can be external.

#### `Stingray` function example

```Stingray
fn myFunc(){
	//function contents
};
```

#### `Stingray` class example

```Stingray
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
};
```

External classes are called by the main source file through the `#incl` flag. Once included, you can call the public methods of the class, while protected and private methods may be accessed when needed, through pointers and references. (explained later in this documentation)

## Pointers and references
Like in C++, you can point to or reference variables in `Stingray`. However, `Stingray` also lets you do that with protected and private methods of classes, if no getter methods are present.
Here are some examples:

```Stingray
&myVar; //references the address of 'myVar'
db refSize = sizeof(&myVar); //assign the memory size of 'myVar' to 'refSize'
db myVal = 86;
myVal -> myClass.myPrivFunc(); //passes the value of 'myVal' to a private function of the class 'myClass'
```

## Asynchronous code in `Stingray`

`Stingray` code is executed synchronously by default. However, sometimes, for example when you need to continuously read sensor data, you need to make parts of the code asynchronous. For this, the keywords `desync`, `resync` and `expect` are used. Here#s an example:

```Stingray
desync fn myAsyncFunc(){
	//some code
	db sensorData = {sensordata};
	return sensorData;
} resync;
expect db data = myAsyncFunc();
```

Note that the asynchronous block has to start with `desync` and end with `resync`. These keywords are located before any declaration, on the same line.

## Error handling
`Stingray`, by default, already handles errors fairly well with concise error messages, however, you may want to handle possible errors in your programs more gracefully. that's where the `try` `catch` statement comes in. it works no different than in other programming languages, however providing an error code and error message works slightly differently:

```Stingray
try {
    //some code here
}
catch {
    throw(ray::err(int err = ecode(); msg("Error message", pref(err))));
};
```

Here, the standard function `pref()` lets you add a prefix, like in this case, the prefix would be the error code that has been retrieved by the `ecode()` function.
Note that the `ray::` namespace is only called on the `err()`. `Stingray` has the unique feature where the namespace is inferred for every element within a standard function, in this case the `err()` function. This reduces verbosity, but you can optionally call the namespace on every element within the function. If you call a function from a different namespace, for example for 3rd party libraries, you have to explicitly call its functions by the namespace of the 3rd party library within a standard function. For handling variables with the values `nil` or `NaN`, the checking methods `isNaN()` and `isNil()` are used. These methods can also be used within `if-else` statements. Alternatively, `isEmpty()` can be used:

```Stingray
str myStr = nil;
if(myStr.isNil()){
    throw(ray::err(int err = ecode(); msg("Error message", pref(err))));
}

//or

if(myStr.isEmpty()){
    throw(ray::err(int err = ecode(); msg("Error message", pref(err))));
}
```

## Syntax highlighting

`Stingray` can use any widely known syntax highlighting scheme, but the standard syntax highlighting for `Stingray` takes inspiration from the syntax highlighting used for Swift in the XCode modern Dark theme for VSCode:

- Keywords (`fn`, `cl`, etc.): Persian Pink (#F77FBE)
- Variables and constants : White #FFFFFF(dark mode), Black #000000 (light mode)
- Strings: Salmon Red (#FA8072)
- Template literals (`$`, `${}`) Yellow (#FFFF00)
- Function names: Steel Blue (#4682B4)
- Class names: Light Steel Blue (#B0C4DE)
- Data types: Lavender (#E6E6FA)
- Unused variables and functions: Navy Gray (#656B83)

**`Stingray` also resolves invisible characters:**
- Zero-Width Space: Resolved to`<ZWSP>` (Red (#FF0000) translucent background and underline)
- Whitespace: Resolved to `<WSPACE>` (Orange (#FFA500) translucent background and underline)
- EM Space: Resolved to `<EM>` (Fluorescent Yellow (#CCFF00) translucent background and underline)

## Alternative Syntax Highlighting Schemes
`Stingray` offers alternative syntax highlighting color schemes that are color corrected for colorblindness (primarily protanopia, deuteranopia and tritanopia). These can be set and adjusted as needed in the settings of the official `Stingray` plugin in your IDE. Here are those themes:

### Protanopia

- Keywords (`fn`, `cl`, etc.): Bright Blue (#0088FF)
- Variables and constants : White #FFFFFF(dark mode), Black #000000 (light mode)
- Strings: Yellow (#FFDD00)
- Template literals (`$`, `${}`) Cyan (#00FFFF)
- Function names: Deep Blue (#0044AA)
- Class names: Light Blue (#88CCFF)
- Data types: Pale Yellow (#FFFFCC)
- Unused variables and functions: Gray (#888888)

**invisible characters:**
- Zero-Width Space: Resolved to `<ZWSP>` with contrast underline, Bold text
- Whitespace: Resolved to `<WSPACE>` with contrast underline, Bold text
- EM Space: Resolved to `<EM>` with contrast underline, Bold text
### Deuteranopia

- Keywords (`fn`, `cl`, etc.): Purple (#8800FF)
- Variables and constants : White #FFFFFF(dark mode), Black #000000 (light mode)
- Strings: Sky Blue (#00CCFF)
- Template literals (`$`, `${}`) Bright Yellow (#FFEE00)
- Function names: Navy (#000088)
- Class names: Light Purple (#BB88FF)
- Data types: Light Gray (#DDDDDD)
- Unused variables and functions: Dark Gray (#666666)

**invisible characters:**
- Zero-Width Space: Resolved to `<ZWSP>` with contrast underline, Bold text
- Whitespace: Resolved to `<WSPACE>` with contrast underline, Bold text
- EM Space: Resolved to `<EM>` with contrast underline, Bold text
### Tritanopia

- Keywords (`fn`, `cl`, etc.): Magenta (#FF00FF)
- Variables and constants : White #FFFFFF(dark mode), Black #000000 (light mode)
- Strings: Red (#FF0000)
- Template literals (`$`, `${}`) Bright Green (#00FF00)
- Function names: Dark Red (#990000)
- Class names: Pink (#FF88FF)
- Data types: Very Light Green (#DDFFDD)
- Unused variables and functions: Olive (#888800)

**invisible characters:**
- Zero-Width Space: Resolved to `<ZWSP>` with contrast underline, Bold text
- Whitespace: Resolved to `<WSPACE>` with contrast underline, Bold text
- EM Space: Resolved to `<EM>` with contrast underline, Bold text

## Compilers/Toolchains
`Stingray` has two native Toolchains that each serve a different purpose. The `rayTools` toolchain is the default for `Stingray` and is intended for systems programming, AI, CLI tools and scripting. Here's what **`rayTools`** includes:

- CStingray/Mollie -> C-compiler for Stingray (AOT compilation)
- Quickfin/Aagnes -> Interpreter for Stingray
- Stingray Core -> Stingray language core made up of a Lexer/Parser and Linter
- StingrayPKG (`raypkg`) -> default Stingray package manager

Stingray also has the `webStingray` toolchain, which is specifically designed for use in web development and consists of:
- rayFlutter/Bittern -> Native Stingray-to-Dart + Flutter transpiler for cross platform web apps
- StingrayJS -> Native Stingray-to-JavaScript transpiler for highly secure and resilient JavaScript code for web logic
- rayWASM -> Native Stingray-to-WASM (Web Assembly) transpiler
- Stingray Core + `raypkg`
- webkit+ -> A web library for web-oriented development These are designed to be resolved into Dart/JavaScript/WASM code upon compilation.

## Additional standard libraries
Here's a list of some of the most notable standard Stingray libraries, some of which may need to be installed separately through `raypkg`:

- `math` (included): Provides more advanced math functions
- `bitset` (included): Work with binary integers, including bitwise operations
- `palette` (included): allows printing colored and formatted output to console
- `webkit` (install via `raypkg`): adds web capabilities to native programs, including both client- and server-side networking. Unlike `webkit+`, this library does not resolve to Dart/JavaScript or WASM.
- `utest` (included): a simple unit testing framework
... and many more.

---

:copyright: **TheSkyler-Dev, Documentation licensed under CC BY-SA 4.0 International**
