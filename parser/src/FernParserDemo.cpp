#include <iostream>
#include <fstream>
#include <string>
#include "antlr4-runtime.h"
#include "FernLexer.h"
#include "FernParser.h"
#include "FernBaseListener.h"

class ErrorListener : public antlr4::BaseErrorListener {
public:
    void syntaxError(antlr4::Recognizer *recognizer, antlr4::Token *offendingSymbol,
                     size_t line, size_t charPositionInLine,
                     const std::string &msg, std::exception_ptr e) override {
        std::cerr << "Line " << line << ":" << charPositionInLine << " " << msg << std::endl;
    }
};

int main(int argc, char* argv[]) {
    try {
        // Initialize input variables
        std::string inputText;
        antlr4::ANTLRInputStream input;
        
        if (argc > 1) {
            // Read from file if provided
            std::ifstream inputFile(argv[1]);
            if (!inputFile.good()) {
                std::cerr << "Error: Could not open input file '" << argv[1] << "'" << std::endl;
                return 1;
            }
            input = antlr4::ANTLRInputStream(inputFile);
        } else {
            // Use a test string if no file is provided
            inputText = "// Test input for Fern language\n// Replace with valid Fern syntax";
            input = antlr4::ANTLRInputStream(inputText);
        }

        // Create lexer and parser
        FernLexer lexer(&input);
        antlr4::CommonTokenStream tokens(&lexer);
        FernParser parser(&tokens);

        // Add our custom error listener
        ErrorListener errorListener;
        parser.removeErrorListeners();
        parser.addErrorListener(&errorListener);

        // Parse the input using the grammar's starting rule
        antlr4::tree::ParseTree* tree = parser.program();

        // Print the parse tree for demonstration
        std::cout << "Parse tree: " << tree->toStringTree(&parser) << std::endl;

        return 0;
    } catch (const std::exception& e) {
        std::cerr << "Exception: " << e.what() << std::endl;
        return 1;
    }
}

