# Fern-lang
**Note: This is an initial documentation and is therefore unfinished and subject to change in the future**

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

### data types
- `str` String
- `int` Integer
- `db` Double precision floating point
- `bool` Boolean
- `ul` Unsigned long interger

### namespaces
The standard namespace is `frn::`. Any standard libraries included with `Fern` can be called with either `frn::` or  the library's own namespace.

### `Fern` comments
- `//` Normal comment
- `/*...*/` Multiline comment

### Control flow
- `if`, `elif`, `else`
- Switch statement:
```Fern
sw ({condition}){
	case 1 {
		//case 1 code here
	}
	case 2 {
		//case 2 code here
	} 
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
};
```
