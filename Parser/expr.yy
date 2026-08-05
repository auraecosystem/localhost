%{
#include <stdio.h>
int yylex(void);
void yyerror(const char *s);
%}

%token INT
%left '+' '-'
%left '*' '/'

%%

prog:
    expr { printf("Result evaluated\n"); }
    ;

expr:
    expr '+' expr
  | expr '-' expr
  | expr '*' expr
  | expr '/' expr
  | '(' expr ')'
  | INT
  ;

%%
