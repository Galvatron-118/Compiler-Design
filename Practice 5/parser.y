%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
    #include "symtab.c"
    #include "codeGen.c"
	void yyerror();
	extern int lineno;
	extern int yylex();
%}

%union
{
    char str_val[100];
    int int_val;
    float float_val;
}

%token ASSIGN1 ASSIGN TO TO1 VAR PERFORM SHOW COMMA ELSE MAIN SUB_F INT 
%token PRINT SCAN
%token ADDOP SUBOP MULOP DIVOP EQUOP LT GT
%token LPAREN RPAREN LBRACE RBRACE SEMI
%token<str_val> ID
%token<int_val> INT
%token<int_val> ICONST
%token<float_val> FCONST
%token<float_val> FLOAT
%token<int_val> NUM
%token<int_val> IF
%token<int_val> WHILE
%token<int_val> FOR

%left LT GT /*LT GT has lowest precedence*/
%left ADDOP SUBOP 
%left MULOP /*MULOP has lowest precedence*/

%type<int_val> exp 


%start program

%%
program: {gen_code(START, -1);} code {gen_code(HALT, -1);};

code: statements;

statements: statements statement | ;

statement:
        declaration 
        |assign
        |scan
        |print
        |if_statement 
        |while_statement
        |for_statement
        ;

declaration: INT ID SEMI
                 {
                        insert($2, $1);
                 }
                 ;

assign: ASSIGN1 ICONST TO VAR NUM ID SEMI
                {
                        insert($6, INT_TYPE);

                        gen_code(LD_INT, $2);
                        

                        int address = idcheck($6);
                        if(address !=-1)
                        {
                            gen_code(STORE, address);
                        }
                         else 
                            yyerror();                    
                }
            |PERFORM ADDOP ID COMMA ID TO ID SEMI
            {
                int address_a = idcheck($3);

                if(address_a !=-1)
                {
                    gen_code(LD_VAR, address_a);
                }
                else 
                    yyerror();

                int address_b = idcheck($5);

                if(address_b !=-1)
                {
                    gen_code(LD_VAR, address_b);
                }
                else 
                    yyerror();

                gen_code(ADD, -1);

                int address_c = idcheck($7);
                if(address_c !=-1)
                {
                    gen_code(STORE, address_c);
                }
                else 
                    yyerror();

            }
            |ID ASSIGN exp SEMI
                {
                    int address = idcheck($1);

                    if(address != -1)
                    {
                        gen_code(STORE, address);
                    }
                }
            |PERFORM ADDOP ID COMMA ICONST TO ID SEMI
            {
                int address_a = idcheck($3);

                if(address_a !=-1)
                {
                    gen_code(LD_VAR, address_a);
                }
                else 
                    yyerror();

                gen_code(LD_INT, $5);

                gen_code(ADD, -1);

                int address_c = idcheck($7);
                if(address_c !=-1)
                {
                    gen_code(STORE, address_c);
                }
                else 
                    yyerror();

            }
            ;

scan: SCAN LPAREN ID RPAREN SEMI
                    {
                        int address = idcheck($3);

                        if(address !=-1)
                        {
                            gen_code(SCAN_INT_VALUE, address);
                        }
                    }
                    ;



print:          SHOW LPAREN ID RPAREN SEMI
                    {
                        int address_b = idcheck($3);

                        if(address_b !=-1)
                        {
                            gen_code(PRINT_INT_VALUE, address_b);
                        }
                        else 
                            yyerror();
                    }                    
                    
                    ;

exp: ICONST
    {
        gen_code(LD_INT, $1);
    }
    | ID 
      {
            int address = idcheck($1);

            if(address != -1)
            {
                gen_code(LD_VAR, address);
            }
            else
                yyerror();

      }
    | exp ADDOP exp { gen_code(ADD, -1); }
    | exp SUBOP exp { gen_code(SUB,-1); }
    | exp MULOP exp
    | exp GT exp { gen_code(GT_OP, gen_label()); }
    | exp LT exp { gen_code(LT_OP, gen_label()); }
    ;

if_statement:
	IF {$1 = gen_label();} LPAREN exp RPAREN { gen_code(IF_START, $1); } tail ELSE { gen_code(ELSE_START, $1); } tail { gen_code(ELSE_END, $1); }
    ;

tail: LBRACE statements RBRACE 
    ;

while_statement: WHILE {$1 = gen_label(); gen_code(WHILE_LABEL, $1); } LPAREN exp RPAREN { gen_code(WHILE_START, $1); } tail { gen_code(WHILE_END, $1); }
    ;

for_statement: FOR {$1 = gen_label(); gen_code(WHILE_LABEL, $1);} cond {gen_code(WHILE_START, $1);} tail { gen_code(WHILE_END, $1);};
    ;
cond: ID ASSIGN ICONST TO1 ICONST{

	
	int address = idcheck($1);
	gen_code(LD_VAR, address);
	gen_code(LD_INT, $5);
	gen_code(LTE_OP, gen_label());
};

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

    printf("============= INTERMEDIATE CODE===============\n");
    print_code();

    printf("============= ASM CODE===============\n");
    print_assembly();

	return 0;
}