# **Stingray Grammar Specification**

This document outlines the grammar rules for the `Stingray` programming language, derived from the provided [documentation](https://github.com/TheSkyler-Dev/Stingray-lang/blob/main/Doc/Documentation.md) and [grammar file](https://github.com/TheSkyler-Dev/Stingray-lang/blob/main/Grammar/Stingray.g4).

---

## **Overview**
The `Stingray` language is a general-purpose programming language designed for systems programming, AI, CLI tools, and scripting. It emphasizes concise syntax, memory safety, and flexibility, supporting multiple memory management modes and interoperability with C++ and Rust.

---

## **Lexical Structure**

### **Tokens**
1. **Keywords**:
   - `fn`, `cl`, `constr`, `pub`, `prot`, `priv`, `if`, `elif`, `else`, `sw`, `case`, `def`, `while`, `do`, `for`, `try`, `catch`, `throw`, `desync`, `resync`, `expect`, `true`, `false`, `nil`, `NaN`

2. **Operators**:
   - Arithmetic: `+`, `-`, `*`, `/`, `%`, `!`
   - Logical: `&&`, `||`, `?:`
   - Assignment: `=`
   - Increment/Decrement: `++`, `--`
   - Pointer/Reference: `&`, `->`

3. **Delimiters**:
   - `;`, `:`, `,`, `.`, `(`, `)`, `{`, `}`, `[`, `]`

4. **Literals**:
   - Numbers: Integers (`int`, `int32`, `ul`) and floating-point numbers (`db`, `db32`)
   - Strings: Enclosed in single (`'`) or double (`"`) quotes
   - Booleans: `true`, `false`
   - Special values: `nil`, `NaN`

5. **Identifiers**:
   - Must start with a letter or underscore (`_`) and can include letters, digits, and underscores.

6. **Comments**:
   - Single-line: `//`
   - Multi-line: `/* ... */`

7. **Whitespace**:
   - Ignored except as a separator.

---

## **Grammar Rules**

### **Program Structure**
A `Stingray` program consists of configuration flags and statements.

```ebnf
program ::= (configFlag | statement)* EOF
```

### **Configuration Flags**
Configuration flags define global settings for the program.

```ebnf
configFlag ::= '#' IDENTIFIER (ASSIGN (STRING | IDENTIFIER | NUMBER | BOOLEAN))? SEMICOLON?
```

Examples:
```Stingray
#incl "math";
#RUNMODE = aot;
#MEM = auto;
```

---

### **Statements**
Statements are the building blocks of a `Stingray` program.

```ebnf
statement ::= variableDeclaration
            | functionDeclaration
            | classDeclaration
            | controlFlow
            | loop
            | ioOperation
            | arithmeticOperation
            | templateLiteral
            | errorHandling
            | pointerReference
            | asyncBlock
```

---

### **Variable Declarations**
Variables must be declared with explicit data types and initialized.

```ebnf
variableDeclaration ::= dataType IDENTIFIER ASSIGN expression SEMICOLON
dataType ::= 'str' | 'int' | 'int32' | 'db' | 'db32' | 'bool' | 'ul'
```

Examples:
```Stingray
str name = "Jane";
int age = 25;
db pi = 3.14159;
```

---

### **Expressions**
Expressions include literals, variables, and operations.

```ebnf
expression ::= primaryExpression (arithmeticOperator primaryExpression)*
primaryExpression ::= NUMBER | STRING | BOOLEAN | NIL | NAN | IDENTIFIER | templateLiteral | LPAREN expression RPAREN
arithmeticOperator ::= '+' | '-' | '*' | '/' | '%' | '!'
```

Examples:
```Stingray
x + y;
(10 * 2) / 5;
```

---

### **Template Literals**
Template literals allow embedding variables or expressions in strings.

```ebnf
templateLiteral ::= STRING ('$' IDENTIFIER | '${' expression '}')*
```

Example:
```Stingray
str message = "$name says that $x + $y equals ${x + y}.";
```

---

### **Functions**
Functions are declared with the `fn` keyword.

```ebnf
functionDeclaration ::= 'fn' IDENTIFIER LPAREN (parameter (COMMA parameter)*)? RPAREN LBRACE statement* RBRACE
parameter ::= dataType IDENTIFIER
```

Example:
```Stingray
fn greet(str name) {
    ray::out("Hello, $name!");
};
```

---

### **Classes**
Classes are declared with the `cl` keyword and can include constructors and visibility blocks.

```ebnf
classDeclaration ::= 'cl' IDENTIFIER LBRACE classBody RBRACE
classBody ::= (visibilityBlock | constructor)*
visibilityBlock ::= ('pub' | 'prot' | 'priv') COLON LBRACE statement* RBRACE
constructor ::= 'constr' COLON LBRACE statement* RBRACE
```

Example:
```Stingray
cl Person {
    constr: {
        // Constructor code
    };
    pub: {
        fn greet() {
            ray::out("Hello!");
        };
    };
};
```

---

### **Control Flow**
Control flow includes `if`, `elif`, `else`, and `switch` statements.

```ebnf
ifStatement ::= 'if' LPAREN expression RPAREN LBRACE statement* RBRACE
                ('elif' LPAREN expression RPAREN LBRACE statement* RBRACE)*
                ('else' LBRACE statement* RBRACE)?

switchStatement ::= 'sw' LPAREN expression RPAREN LBRACE caseBlock* defaultBlock? RBRACE
caseBlock ::= 'case' expression COLON LBRACE statement* RBRACE
defaultBlock ::= 'def' COLON LBRACE statement* RBRACE
```

Examples:
```Stingray
if (x > 0) {
    ray::out("Positive");
} elif (x < 0) {
    ray::out("Negative");
} else {
    ray::out("Zero");
};

sw (value) {
    case 1: {
        ray::out("One");
    };
    def: {
        ray::out("Default");
    };
};
```

---

### **Loops**
`Stingray` supports `while`, `do-while`, and `for` loops.

```ebnf
whileLoop ::= 'while' LPAREN expression RPAREN LBRACE statement* RBRACE
doWhileLoop ::= 'do' LBRACE statement* RBRACE 'while' LPAREN expression RPAREN SEMICOLON
forLoop ::= 'for' LPAREN variableDeclaration expression SEMICOLON expression RPAREN LBRACE statement* RBRACE
```

Examples:
```Stingray
while (true) {
    // Loop body
};

do {
    // Loop body
} while (condition);

for (int i = 0; i < 10; i++) {
    // Loop body
};
```

---

### **I/O Operations**
Input and output are handled using `ray::out` and `ray::in`.

```ebnf
ioOperation ::= 'ray::out' LPAREN expression RPAREN SEMICOLON
              | 'ray::in' LPAREN STRING RPAREN ('.req')? SEMICOLON
```

Examples:
```Stingray
ray::out("Hello, World!");
str input = ray::in("Enter your name:").req;
```

---

### **Error Handling**
Error handling uses `try`, `catch`, and `throw`.

```ebnf
errorHandling ::= 'try' LBRACE statement* RBRACE 'catch' LBRACE throwStatement RBRACE
throwStatement ::= 'throw' LPAREN 'ray::err' LPAREN 'int' IDENTIFIER ASSIGN 'ecode' LPAREN RPAREN SEMICOLON 'msg' LPAREN STRING (COMMA IDENTIFIER)? RPAREN RPAREN RPAREN SEMICOLON
```

Example:
```Stingray
try {
    // Code that may throw an error
} catch {
    throw(ray::err(int err = ecode(); msg("Error occurred", pref(err))));
};
```

---

### **Asynchronous Code**
Asynchronous code uses `desync`, `resync`, and `expect`.

```ebnf
asyncBlock ::= 'desync' functionDeclaration 'resync'
```

Example:
```Stingray
desync fn fetchData() {
    // Async code
} resync;
expect db data = fetchData();
```

---

This grammar specification provides a comprehensive guide to the syntax and structure of the `Stingray` language.

---

:copyright: **TheSkyler-Dev, Documentation licensed under CC BY-SA 4.0 International**
