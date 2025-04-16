# Fern Parser Demo

This directory contains a prebuilt binary and source file for the `Fern` parser demo. The purpose of this demo is to showcase the functionality of the lexer and parser generated from the `Fern.g4` grammar using ANTLR.

## Features Demonstrated
The demo includes:
- **Configuration Flags**: Parsing `#config` directives.
- **Variable Declarations**: Handling different data types (`int`, `db32`, `str`, etc.).
- **Arithmetic Expressions**: Parsing and evaluating mathematical operations.
- **Template Literals**: Interpolating variables into strings.
- **Output Operations**: Using `frn::out` to display results.

## File Structure
- [`FernParserDemo.exe`](https://github.com/TheSkyler-Dev/Fern-lang/blob/main/parser/FernParserDemo.exe) (or `FernLang` on Linux/Mac): The prebuilt binary for the parser demo.
- `src/FernParserDemo.cpp`: The source file for the demo, showing how the parser is used.
- `test.fern`: A sample `Fern` source file demonstrating various language features.

## Running the Demo
To run the parser demo, follow these steps:

1. **Run the Prebuilt Binary**:
   Use the following command to parse the `test.fern` file:
   ```bash
   ./FernLang test.fern
   ```

2. **Expected Output**:
   The demo will parse the `test.fern` file and output the parse tree or evaluation results. For example:
   ```
   Variable declared: x = 42
   Expression result: 52
   Variable declared: y = 32.8
   Variable declared: myExpr = Expression is 328
   Output: Expression is 328
   ```

## Building the Demo (Optional)
If you want to rebuild the demo from source, you will need:
- ANTLR runtime for C++.
- A C++17-compatible compiler.
- CMake for building the project.

Steps to build:
1. Clone the repository and navigate to the directory containing `main.cpp`.
2. Run the following commands:
   ```bash
   mkdir build
   cd build
   cmake ..
   cmake --build .
   ```

3. Run the newly built binary:
   ```bash
   ./FernLang ../test.fern
   ```

## Modifying the Demo
You can modify the `test.fern` file to test additional features of the `Fern` language. For example:
```fern
int z = x * 2;
frn::out("The value of z is ${z}");
```

## Notes
- The ANTLR4-generated files and runtime are **not included** in this repository. If you want to regenerate the parser or lexer, you will need to set up ANTLR4 separately and use the `Fern.g4` grammar file.

## Contributing
If you encounter any issues or have suggestions for improving the demo, feel free to open an issue or submit a pull request.

## License
This project is licensed under the GNU GPL 3.0 License. See the [LICENSE](https://github.com/TheSkyler-Dev/Fern-lang/blob/main/LICENSE) file for details.
