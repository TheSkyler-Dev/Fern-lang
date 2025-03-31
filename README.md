![Static Badge](https://img.shields.io/badge/Status-early%20development-yellow?style=flat)
![Static Badge](https://img.shields.io/badge/License-GNU%20GPL_3.0-blue?style=flat)
![Static Badge](https://img.shields.io/badge/Documentation_License-CC%20BY--SA_4.0-blue?style=flat)

___
# What is `Fern`?
`Fern` is a general purpose programming language with its main strengths in systems programming, AI, CLI tools and scripting, among others.

## The `Fern` philosophy
`Fern` is designed to be concise, easy to read, lightweight and flexible. Its syntax is inspired by Rust, C++ and, to some extent, Swift. `Fern`'s support for Ahead-of-time (AOT), Just-in-time (JIT) compilation, as well as interpretation is intended to provide usage-dependent flexibility, such as using interpretation for rapid prototyping or scripting. `Fern` emphasizes memory and type safety with multiple  kinds of memory managements, such as manual, reference counting and garbage collection, specifiable by the developer. That way, `Fern` is versatile for many applications! An intuitive, yet robust programming language.

## The principles of `Fern` at a glance
- `Fern` uses a flag-based configuration at the top of your source code.
- variable types **must** be declared with explicit data types and be initialized with, at the very least, a default value.
- `Fern`'s syntax is concise
- `Fern` code runs synchronously by default and allows for explicit synchronicity
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
- `#MULTIDISP` specify whether multiple dispatch should be allowed (disabled by default). `allow` enables multiple dispatch. If activated, the data type of the arguments passed to a function/method has to be explicitly defined with a data type.

> **IMPORTANT**:
> Both the `#incl` and `#use ... from ...` flags assume your libraries and classes are located in an `include` directory (usually a folder called `include` in your project root directory). Should you organize your external classes in a subdirectory within `include` or have them in a separate folder located in the project root directory, you can use the `#inclconfig` flag to explicitly specify the directories for your libraries and classes:
> 
> ```Fern
> #inclconfig libinclude="custom/include/path", clinclude="custom/class/path"
> ```
> 
> This flag should appear before the `#incl` flag.  This tells `Fern`, where to fetch library or external class contents from during development and in interpreted mode. In compilation mode, it would use CMake, so the `#inclconfig` flag should be omitted in production code, since it is meant strictly for rapid prototyping and scripting.

### Syntax and style conventions
`Fern` follows common code conventions seen in languages like C++ and Rust. While not strictly enforced (you generally can use `tab` for indentation), It is recommended to use four (4) spaces per indentation rather than `tab`, as per [Google's style guidelines](https://tinyurl.com/42h9tfy8). Each statement must end with a semicolon (`;`). variable, function and class names are strictly case sensitive. For Class names, `PascalCase` should be used, while function and variable names should either adhere to `camelCase`. The use of `kebab-case` or `snake_case` in function or variable names can be done when necessary, depending on the context. It is best practice to insert spaces between variable names/the value to be assigned and the assignment operator (`=`) to enhance readability.
## Variables
### Data Types
- `str` String
- `int` Integer (`int64` by default, can be explicitly defined otherwise with `int32`)
- `db` Double precision floating point (`db64`by default, can be set to `db32`)
- `bool` Boolean
- `ul` Unsigned long integer

Note that variables of type `db` support double precision floating points with up to 16 decimal positions, as well as subnormal floating points. Constants can be declared by using the `const` keyword before the data type.

### More on variables
Variables in `Fern` aren't directly nullable for memory safety. It is generally good practice to initialize variables as they're declared. Recommended default values for variables, including one that kinda works like assigning null to a numeric variable are:

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

```Fern
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
Mathematical operations in `Fern` are very straight forward and includes the following operators:
- **`+`**: Addition
- **`-`**: Subtraction
- **`/`**: Division
- **`*`**: Multiplication
- **`%`**: Modulo
- **`!`**: Factorial

Here are some example of their usage:

```Fern
frn::out(16 + 16);
frn::out(16 - 8);
frn::out(32 / 2);
frn::out(10 * 10);
frn::out(1024 % 8);
frn::out(5!);
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
- **`nrt()`**: Non square root. The factorn has to be defined as the first number int the parentheses, followed by the expression, separated by a comma
- **`sin()`**: Calculates sine of the value passed to it
- **`cos()`**: Calculates cosine of the value passed to it

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

input can require user input with the `.req` marker:

```Fern
str input = frn::in("some input prompt").req;
int numIn = frn::in("some input prompt").req; //required input
```
## Template literals
`Fern` supports template literals. Here, it doesn't matter whether the string is enclosed in single or double quotes. Template literals allow you to insert values from variables or perform (mathematical) expressions within a string.

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
- `/*...*/` Multi-line comment

## Loops
`Fern` supports your usual types of loops: `while`-loops, `do ... while` loops, `for` loops. In `Fern`, these essentially work the same as in C++. Variables in `Fern` support modifiers like `++` for incrementing by one or `--` for decrementing the value of a variable by one. 

`while` loop:

```Fern
while(true){
    //some code
};
```

`do-while` loop example:

```Fern
do {
    //some code
} while(<condition>);
```

`for` loop example:

```Fern
for(int i = 0; <condition>; i++){
    //some code (e.g. a list iterator)
};
```

### Control flow
- `if`, `elif`, `else`
- Switch statement:

```Fern
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
`Fern` generally supports all logic operators like AND (`&&`), OR (`||`) etc. and use the generally recognized symbols for doing so. These can also be used in bitwise operations. Additionally, Elvis operators (`:?`) are also supported by `Fern`. operators like `&&` and `||` can also be used in control flow when you need to cover a condition with a single code block or need two conditions to be true for a certain block of code to execute.

Logical operators in control flow:

```Fern
int num1 = 0;
int num2 = 0;
num1 = frn::in("Enter num 1: ");
num2 = frn::in("Enter num 2: ");
if(num1 == 1 && num2 == 0){
    //some code here
}
```

Elvis operator example:

```Fern
str username = nil;
str displayName = !username.empty() ? username : "Guest";
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
};
```

External classes are called by the main source file through the `#incl` flag. Once included, you can call the public methods of the class, while protected and private methods may be accessed when needed, through pointers and references. (explained later in this documentation)

## Pointers and references
Like in C++, you can point to or reference variables in `Fern`. However, `Fern` also lets you do that with protected and private methods of classes, if no getter methods are present.
Here are some examples:

```Fern
&myVar; //references the address of 'myVar'
db refSize = sizeof(&myVar); //assign the memory size of 'myVar' to 'refSize'
db myVal = 86;
myVal -> myClass.myPrivFunc(); //passes the value of 'myVal' to a private function of the class 'myClass'
```

## Asynchronous code in `Fern`

`Fern` code is executed synchronously by default. However, sometimes, for example when you need to continuously read sensor data, you need to make parts of the code asynchronous. For this, the keywords `desync`, `resync` and `expect` are used. Here#s an example:

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
`Fern`, by default, already handles errors fairly well with concise error messages, however, you may want to handle possible errors in your programs more gracefully. that's where the `try` `catch` statement comes in. it works no different than in other programming languages, however providing an error code and error message works slightly differently:

```Fern
try {
    //some code here
}
catch {
    throw(frn::err(int err = ecode(); msg("Error message", pref(err))));
};
```

Here, the standard function `pref()` lets you add a prefix, like in this case, the prefix would be the error code that has been retrieved by the `ecode()` function.
Note that the `frn::` namespace is only called on the `err()`. `Fern` has the unique feature where the namespace is inferred for every element within a standard function, in this case the `err()` function. This reduces verbosity, but you can optionally call the namespace on every element within the function. If you call a function from a different namespace, for example for 3rd party libraries, you have to explicitly call its functions by the namespace of the 3rd party library within a standard function. For handling variables with the values `nil` or `NaN`, the checking methods `isNaN()` and `isNil()` are used. These methods can also be used within `if-else` statements. Alternatively, `isEmpty()` can be used:

```Fern
str myStr = nil;
if(myStr.isNil()){
    throw(frn::err(int err = ecode(); msg("Error message", pref(err))));
}

//or

if(myStr.isEmpty()){
    throw(frn::err(int err = ecode(); msg("Error message", pref(err))));
}
```

## Syntax highlighting

`Fern` can use any widely known syntax highlighting scheme, but the standard syntax highlighting for `Fern` takes inspiration from the syntax highlighting used for Swift in the XCode modern Dark theme for VSCode:

- Keywords (`fn`, `cl`, etc.): Persian Pink (#F77FBE)
- Variables and constants : White #FFFFFF(dark mode), Black #000000 (light mode)
- Strings: Salmon Red (#FA8072)
- Template literals (`$`, `${}`) Yellow (#FFFF00)
- Function names: Steel Blue (#4682B4)
- Class names: Light Steel Blue (#B0C4DE)
- Data types: Lavender (#E6E6FA)
- Unused variables and functions: Navy Gray (#656B83)

**`Fern` also resolves invisible characters:**
- Zero-Width Space: Resolved to`<ZWSP>` (Red (#FF0000) translucent background and underline)
- Whitespace: Resolved to `<WSPACE>` (Orange (#FFA500) translucent background and underline)
- EM Space: Resolved to `<EM>` (Fluorescent Yellow (#CCFF00) translucent background and underline)

## Alternative Syntax Highlighting Schemes
`Fern` offers alternative syntax highlighting color schemes that are color corrected for colorblindness (primarily protanopia, deuteranopia and tritanopia). These can be set and adjusted as needed in the settings of the official `Fern` plugin in your IDE. Here are those themes:

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
`Fern` has two native Toolchains that each serve a different purpose. The `frnTools` toolchain is the default for `Fern` and is intended for systems programming, AI, CLI tools and scripting. Here's what **`frnTools`** includes:

- CFern/Mollie -> C-compiler for Fern (AOT and JIT compilation)
- InstFrn/Aagnes -> native Fern interpreter
- Fern Core -> Fern language core made up of a Lexer/Parser and Linter
- FernPKG (`fpkg`) -> default Fern package manager

Fern also has the `webFern` toolchain, which is specifically designed for use in web development and consists of:
- frnFlutter/Bittern -> Native Fern-to-Dart + Flutter compiler/converter for cross platform web apps
- FernJS -> Native Fern-to-JavaScript compiler/converter for highgly secure and resilient JavaScript code for web logic
- frnWASM -> Native Fern-to-WASM (Web Assembly) compiler/converter
- Fern Core + `fpkg`
- webkit+ -> A web library for web-oriented development These are designed to be resolved into Dart/JavaScript/WASM code upon compilation.

## Additional standard libraries
Here's a list of some of the most notable standard Fern libraries, some of which may need to be installed seperately through `fpkg`:

- `math` (included): Provides more advanced math functions
- `bitset` (included): Work with binary integers, including bitwise operations
- `palette` (included): allows printing colored and formatted output to console
- `webkit` (install via `fpkg`): adds web capabilities to native programs, including both client- and server-side networking. Unlike `webkit+`, this library does not resolve to Dart/JavaScript or WASM.
- `utest` (included): a simple unit testing framework
... and many more.
