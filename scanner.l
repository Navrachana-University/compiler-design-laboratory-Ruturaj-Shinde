%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
%}

%%

"dikhana"       { return PRINT; }
"yeh"           { return IF; }
"yato"          { return ELSE; }
"woh"           { return ELSEIF; }

"=="            { return EQ; }
"!="            { return NE; }
"<="            { return LE; }
">="            { return GE; }

[0-9]+          { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.id = strdup(yytext); return IDENTIFIER; }

"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"="             { return '='; }
"("             { return '('; }
")"             { return ')'; }
"{"             { return '{'; }
"}"             { return '}'; }
";"             { return ';'; }

[\t\r\n ]+      { /* skip whitespace */ }
.               { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
