%option caseless
%option yylineno
%{
#include <stdio.h>
#define YYSTYPE char *
extern YYSTYPE yylval;
#include "y.tab.h"
// #include "token.h"
// extern FILE* yyin;
extern int yylineno;
extern int yylex(void);
extern int yyparse(void);
// extern char* yylval;

int num_line = 0, num_col = 0, num_chars = 0;

%}
letter [A-Za-z]
digit_without_0 [1-9]
digit [0-9]
underline _

break_line (\r|\n|\r\n)+
space [ \t]+

port_direction input|output|inout

number_integer {digit}+({digit}|{underline})*{digit}*
number_with_bit_length {digit}+\'(h|d|o|b){number_integer}

bit_slice \[{number_integer}:{number_integer}\]

id ({underline}|{letter})+({underline}|{letter}|{digit})*

%%
"," { return COMMA; }

{number_integer} {
    yylval = strdup(yytext);
    return NUMBER_INTEGER;
}
{number_with_bit_length} {
    yylval = strdup(yytext);
    return NUMBER_WITH_BIT_LENGTH;
}

{port_direction} {
    yylval = strdup(yytext);
    return PORT_DIRECTION;
}

{id} {
    yylval = strdup(yytext);
    return ID; 
}

{break_line} {
    // printf("break_line: %s\n", yytext);
    ++num_line; ++num_line; ++num_chars;
    // return CRLF;
}
{space} {
    // printf("break_line: %s\n", yytext);
    ++num_col;
    // ++num_line; ++num_line; ++num_chars;
    // return SPACE;
}

. {
    // printf(".: %s\n", yytext);
    ++num_col;
    // return ANY;
};

%%
