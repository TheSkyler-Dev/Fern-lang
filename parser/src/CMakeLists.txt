cmake_minimum_required(VERSION 3.14)
project(FernGrammar CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Specify build in a separate build directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Configure ANTLR4 runtime
add_subdirectory(antlr4-cpp-runtime)

# Create the Fern grammar library
add_library(FernGrammar STATIC
    src/FernLexer.cpp
    src/FernParser.cpp
    src/FernBaseListener.cpp
    src/FernListener.cpp
)

# Set include directories
target_include_directories(FernGrammar
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/src
        ${CMAKE_CURRENT_SOURCE_DIR}/antlr4-cpp-runtime/runtime/src
)

# Link against ANTLR4 static library
target_link_libraries(FernGrammar
    PRIVATE
        antlr4_static
)

# Set compiler flags for MinGW
if(MINGW)
    target_compile_definitions(FernGrammar
        PRIVATE
            ANTLR4CPP_STATIC
    )
    
    target_compile_options(FernGrammar
        PRIVATE
            -Wall
            -Wextra
            -pedantic
            -Wno-unknown-pragmas
    )
endif()

# Create a simple test executable that demonstrates usage of the parser
add_executable(FernParserDemo
    src/FernParserDemo.cpp
)

target_link_libraries(FernParserDemo
    PRIVATE
        FernGrammar
        antlr4_static
)

# Install rules if needed
install(TARGETS FernGrammar
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)

install(TARGETS FernParserDemo
    RUNTIME DESTINATION bin
)

