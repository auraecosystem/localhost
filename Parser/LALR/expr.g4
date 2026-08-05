grammar Expr;

// Parser Rules (start with lowercase)
prog : expr EOF ;

expr : expr ('*'|'/') expr
     | expr ('+'|'-') expr
     | INT
     | '(' expr ')'
     ;

// Lexer Rules (start with uppercase)
INT     : [0-9]+ ;
WS      : [ \t\r\n]+ -> skip ;
