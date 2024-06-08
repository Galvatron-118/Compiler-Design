%{
#include<stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.c"

extern int lineno;

void yyerror();
extern int yylex();
%}

%union
{
    char str_val[100];
    int int_val;
    float float_val;
}

%token INT IF ELSE WHILE CONTINUE BREAK PRINT DOUBLE CHAR FLOAT
%token ADDOP SUBOP MULOP DIVOP EQUOP LT GT
%token LPAREN RPAREN LBRACE RBRACE SEMI ASSIGN
%token<str_val> ID
%token ICONST
%token FCONST
%token CCONST

%left LT GT /*LT GT has lowest precedence*/
%left ADDOP 
%left MULOP /*MULOP has lowest precedence*/

%type<float_val> type


%start s


%%


s: type ID ASSIGN FCONST SEMI
    {
        insert($2, REAL_TYPE);
    };





type: INT {$$=INT_TYPE;}
    | FLOAT {$$=REAL_TYPE;}
    | CHAR {$$=CHAR_TYPE;}
    ;




%%

void yyerror ()
{
	printf("Syntax error at line %d\n", lineno);
	exit(1);
}

int main (int argc, char *argv[])
{
	yyparse();
	printf("Parsing finished!\n");	
	return 0;
}