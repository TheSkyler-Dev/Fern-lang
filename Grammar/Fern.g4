grammar Fern;

// Lexer rules
CONFIG_FLAG: '#' [a-zA-Z]+;
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
NUMBER: [0-9]+ ('.' [0-9]+)?;
STRING: '"' .*? '"' | '\'' .*? '\'';
BOOLEAN: 'true' | 'false';
NIL: 'nil';
NAN: 'NaN';
SEMICOLON: ';';
COLON: ':';
COMMA: ',';
DOT: '.';
ARROW: '->';
ASSIGN: '=';
PLUS: '+';
MINUS: '-';
MULT: '*';
DIV: '/';
MOD: '%';
FACTORIAL: '!';
LPAREN: '(';
RPAREN: ')';
LBRACE: '{';
RBRACE: '}';
LBRACKET: '[';
RBRACKET: ']';
WS: [ \t\r\n]+ -> skip;
COMMENT: '//' ~[\r\n]* -> skip;
MULTILINE_COMMENT: '/*' .*? '*/' -> skip;

// Parser rules
program: (configFlag | statement)* EOF;

configFlag: CONFIG_FLAG IDENTIFIER (ASSIGN STRING | ASSIGN IDENTIFIER | ASSIGN NUMBER | ASSIGN BOOLEAN)? SEMICOLON?;

statement: variableDeclaration
         | functionDeclaration
         | classDeclaration
         | controlFlow
         | loop
         | ioOperation
         | arithmeticOperation
         | templateLiteral
         | errorHandling
         | pointerReference
         | asyncBlock;

variableDeclaration: dataType IDENTIFIER ASSIGN expression SEMICOLON;

dataType: 'str' | 'int' | 'db' | 'bool' | 'ul';

expression: primaryExpression (arithmeticOperator primaryExpression)*;

primaryExpression: NUMBER
                 | STRING
                 | BOOLEAN
                 | NIL
                 | NAN
                 | IDENTIFIER
                 | templateLiteral;

arithmeticOperator: PLUS | MINUS | MULT | DIV | MOD | FACTORIAL;

arithmeticOperation: expression (arithmeticOperator expression)+ SEMICOLON;

templateLiteral: STRING ('$' IDENTIFIER | '${' expression '}')*;

functionDeclaration: 'fn' IDENTIFIER LPAREN (parameter (COMMA parameter)*)? RPAREN LBRACE statement* RBRACE;

parameter: dataType IDENTIFIER;

classDeclaration: 'cl' IDENTIFIER LBRACE classBody RBRACE;

classBody: (visibilityBlock | constructor)*;

visibilityBlock: ('pub' | 'prot' | 'priv') COLON LBRACE statement* RBRACE;

constructor: 'constr' COLON LBRACE statement* RBRACE;

controlFlow: ifStatement | switchStatement;

ifStatement: 'if' LPAREN expression RPAREN LBRACE statement* RBRACE ('elif' LPAREN expression RPAREN LBRACE statement* RBRACE)* ('else' LBRACE statement* RBRACE)?;

switchStatement: 'sw' LPAREN expression RPAREN LBRACE caseBlock* defaultBlock? RBRACE;

caseBlock: 'case' expression COLON LBRACE statement* RBRACE;

defaultBlock: 'def' COLON LBRACE statement* RBRACE;

loop: whileLoop | doWhileLoop | forLoop;

whileLoop: 'while' LPAREN expression RPAREN LBRACE statement* RBRACE;

doWhileLoop: 'do' LBRACE statement* RBRACE 'while' LPAREN expression RPAREN SEMICOLON;

forLoop: 'for' LPAREN variableDeclaration expression SEMICOLON expression RPAREN LBRACE statement* RBRACE;

ioOperation: 'frn::out' LPAREN expression RPAREN SEMICOLON
           | 'frn::in' LPAREN STRING RPAREN ('.req')? SEMICOLON;

pointerReference: '&' IDENTIFIER
                | IDENTIFIER ARROW IDENTIFIER DOT IDENTIFIER LPAREN (expression (COMMA expression)*)? RPAREN;

asyncBlock: 'desync' functionDeclaration 'resync';

errorHandling: 'try' LBRACE statement* RBRACE 'catch' LBRACE throwStatement RBRACE;

throwStatement: 'throw' LPAREN 'frn::err' LPAREN 'int' IDENTIFIER ASSIGN 'ecode' LPAREN RPAREN SEMICOLON 'msg' LPAREN STRING (COMMA IDENTIFIER)? RPAREN RPAREN RPAREN SEMICOLON;