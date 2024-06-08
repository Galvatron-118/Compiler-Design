%option noyywrap

%{
	#define INT_TYPE 1
	#define REAL_TYPE 2
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "parser.tab.h"
	
	int lineno = 1; // initialize to 1
	void yyerror();
%}

alpha     [a-zA-Z]
digit     [0-9]
alnum     {alpha}|{digit}
print     [ -~]

ID        {alpha}{alnum}*
ICONST    [0-9]{digit}*
FCONST {digit}+"."{digit}+
%%

"//".*        { } 

"int"       {yylval.int_val=INT_TYPE; return INT; }
"float"       {yylval.float_val=REAL_TYPE; return FLOAT; }

"if"	   {return IF;}
"else"	   {return ELSE;}
"while"    { return WHILE; }

"+"       { return ADDOP; }
"-"       { return SUBOP; }
"*"       { return MULOP; }
"/"       { return DIVOP; }
"=="      { return EQUOP; }
">"       { return GT; }
"<"       { return LT; }

"("       { return LPAREN; }
")"       { return RPAREN; }
"{"       { return LBRACE; }
"}"       { return RBRACE; }
";"       { return SEMI; }
"="       { return ASSIGN; }


{ID}        {strcpy(yylval.str_val, yytext); return ID;}
{ICONST}    {yylval.int_val=atoi(yytext); return ICONST;}
{FCONST}    {yylval.float_val=atof(yytext); return FCONST;}

