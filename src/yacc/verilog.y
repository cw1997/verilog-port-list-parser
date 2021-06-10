// %option yylineno
%{
#define YYSTYPE char *
#include <stdio.h>
// #include "y.tab.h"
extern FILE* yyin;
extern int yylineno;
// extern char* yylval;
extern char* yytext;
extern int yyleng;
extern int yylex(void);
extern int yyparse(void);

int main(int argc, char ** argv) {
  printf("yacc\n");

  char filepath[] = "./port.v";
  if ((yyin = fopen(filepath, "r")) == NULL){
      printf("Can't open file %s\n", filepath);
      return 1;
  }

  // int type;
  // while (type = yylex()){
  //     printf("type = %d\t, len = %d\t, line = %d\t, value = %s\t \n", type, yyleng, yylineno, yytext);
  // }

  // printf("num_line = %d, num_col = %d, num_chars = %d \n", num_line, num_col, num_chars);
  int parse_result = yyparse();
  printf("parse_result: %d\n", parse_result);
  return parse_result;
}

int yywrap(void) {
  return 1;
}

void yyerror(const char *msg) {
  extern char *yytext;
  fprintf(stderr, "len = %d\t, line = %d\t, value = %s\t \n", yyleng, yylineno, yytext);
  fprintf(stderr, "parser error: %s, near %s\n", msg, yytext);
}
%}
// %union {
// int int_value;
// double double_value;
// }
// %token ANY
%token ID 
%token PORT_DIRECTION 
// %token NUMBER_INTEGER NUMBER_WITH_BIT_LENGTH
%token COMMA //SEMICOLON//SPACE CRLF 
%%
// start: port_list { printf("[start] port_list\n"); }
// ;

// port_list      -> port_list COMMA port_item
//                 | port_item
// port_item      -> direction port_name_list
// port_name_list -> port_name_list COMMA ID
//                 | ID

port_list:
port_item COMMA port_list
{ printf("[parser] port_list -> port_item 1 : %s , port_item 2 : %s \n", $1, $3); }
| port_item 
{ printf("[accept] one port : %s\n", $1); }
| /* empty */ { printf("[empty] port_list empty\n"); }
;

port_item: PORT_DIRECTION port_name_list
{ printf("[accept] one port direction : %s , name : %s \n", $1, $2); }
;

port_name_list: ID COMMA port_name_list
{ printf("[parser] port_name_list : %s , port_name_list : %s \n", $1, $3); }
| ID 
{ printf("[accept] one port name : %s \n", $1); }
;

%%
