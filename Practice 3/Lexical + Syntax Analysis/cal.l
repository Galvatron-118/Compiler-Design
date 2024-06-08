%option noyywrap
%{
//Header File can be added here
#include "cal.tab.h"
%}
/* RE can be added here*/

digit [0-9]
letter [a-zA-z]

%%
" " {} //to remove whitespace of output
"For" {printf("%s -> FOR\n", yytext); return(FOR);}
"To" {printf("%s -> TO\n", yytext); return(TO);}
"Next" {printf("%s -> NEXT\n", yytext); return(NEXT);}
"dim" {printf("%s -> DIM\n", yytext); return(DIM);}
"as" {printf("%s -> AS\n", yytext); return(AS);}
"integer" {printf("%s -> INTEGER\n", yytext); return(INTEGER);}
("_"|{letter})("_"|{letter}|{digit})* {printf("%s -> ID\n", yytext); return(ID);}
({digit})({digit})* {printf("%s -> NUM\n", yytext); return(NUM);}
"=" {printf("%s -> ASSIGN\n", yytext); return(ASSIGN);}
({digit}+"."{digit}+) {printf("%s -> FLOAT\n", yytext); yylval = atof(yytext);return(FLOAT);}
%%


