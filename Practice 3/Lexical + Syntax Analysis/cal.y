%{
//header file add
#include<stdio.h>
void yyerror(char *s);
int yylex();
%}

%token FOR DIM AS INTEGER ID NUM TO ASSIGN FLOAT NEXT
%start s

%%
s:  DIM ID AS INTEGER FOR ID ASSIGN NUM TO FLOAT FOR ID ASSIGN NUM TO NUM NEXT ID NEXT ID;

%%

int main(){

    yyparse();
    printf("Parsing Finished\n");
    return 0;
}

void yyerror(char *s)
{
    fprintf(stderr, "Error: %s\n",s);
}