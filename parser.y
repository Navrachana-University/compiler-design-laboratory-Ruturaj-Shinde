%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 0;

typedef struct {
    char* code;
    char* result;
} Expression;

char* newTemp() {
    char* temp = malloc(10);
    sprintf(temp, "t%d", tempCount++);
    return temp;
}

void yyerror(const char* s);
int yylex(void);
%}

%union {
    int num;
    char* id;
    Expression expr;
}

%token <num> NUMBER
%token <id> IDENTIFIER
%token PRINT IF ELSE ELSEIF
%token EQ NE LE GE

%type <expr> expression condition

%%

program:
    program statement
    | /* empty */
    ;

statement:
    IDENTIFIER '=' expression ';' {
        printf("TAC: %s", $3.code);
        printf("TAC: %s = %s\n", $1, $3.result);
        printf("ASM: MOV %s, %s\n", $1, $3.result);
        printf("OUTPUT: %s = %s\n\n", $1, $3.result);
    }
    | PRINT expression ';' {
        printf("TAC: print %s\n", $2.result);
        printf("ASM: OUT %s\n", $2.result);
        printf("OUTPUT: %s\n\n", $2.result);
    }
    | IF '(' condition ')' '{' statement '}' {
        printf("TAC: %s", $3.code);
        printf("IF condition true:\n\n");
    }
    | IF '(' condition ')' '{' statement '}' ELSE '{' statement '}' {
        printf("TAC: %s", $3.code);
        printf("TAC: if %s goto Ltrue\n", $3.result);
        printf("TAC: goto Lfalse\n");
        printf("LABEL Ltrue:\n... true block ...\n");
        printf("TAC: goto Lend\n");
        printf("LABEL Lfalse:\n... false block ...\n");
        printf("LABEL Lend:\n");
    }
    | IF '(' condition ')' '{' statement '}' ELSEIF '{' statement '}' {
        printf("TAC: %s", $3.code);
        printf("TAC: elseif block (simplified)\n");
    }
    ;

expression:
    NUMBER {
        char buf[20]; sprintf(buf, "%d", $1);
        $$.code = strdup("");
        $$.result = strdup(buf);
    }
    | IDENTIFIER {
        $$.code = strdup("");
        $$.result = strdup($1);
    }
    | expression '+' expression {
        char* t = newTemp();
        char* code = malloc(1024);
        sprintf(code, "%s%sTAC: %s = %s + %s\n", $1.code, $3.code, t, $1.result, $3.result);
        $$.code = code;
        $$.result = t;
    }
    | expression '*' expression {
        char* t = newTemp();
        char* code = malloc(1024);
        sprintf(code, "%s%sTAC: %s = %s * %s\n", $1.code, $3.code, t, $1.result, $3.result);
        $$.code = code;
        $$.result = t;
    }
    ;

condition:
    expression EQ expression {
        char* t = newTemp();
        char* code = malloc(1024);
        sprintf(code, "%s%sTAC: %s = %s == %s\n", $1.code, $3.code, t, $1.result, $3.result);
        $$.code = code;
        $$.result = t;
    }
    ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter your code (end each line with semicolon):\n");
    yyparse();
    return 0;
}
