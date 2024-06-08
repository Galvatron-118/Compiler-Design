%option noyywrap
%{
#include "cal.tab.h"
%}

%%
"1" {printf("%s -> NUM\n", yytext); return(NUM);}
"+" {printf("%s -> ADDOP\n", yytext); return(ADDOP);}
"2" {printf("%s -> NUM\n", yytext); return(NUM);}
%%

