grammar Verilog;

//@header{package me.changwei.verilog;}

options {
}

// grammer

start: portList EOF;

portList: portItem (COMMA portItem)*;
portItem: PORT_DIRECTION portNameList;

portNameList: portName (COMMA portName)*;
portName: ID;


// lexer

SPACE: [ \t]+ -> skip;
BREAK_LINE: [\r\n]+ -> skip;
COMMENT: '//' .*? ('\r'? '\n' | EOF) -> skip;

PORT_DIRECTION: ('input'|'output'|'inout');

COMMA: ',';
SEMICOLON: ';';
COLON: ':';

fragment UNDERLINE: '_';
fragment LETTER: [a-zA-Z];
fragment DIGIT_DEC: [0-9];
fragment DIGIT_DEC_WITHOUT_ZERO: [1-9];

ID: (LETTER|UNDERLINE)(LETTER|UNDERLINE|DIGIT_DEC)*;
