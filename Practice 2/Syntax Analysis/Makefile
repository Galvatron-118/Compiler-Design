main:
	flex cal.l
	gcc -o lex lex.yy.c
	lex < input.txt > output.txt

main2:
	bison -d cal.y
	flex cal.l
	gcc -o lex lex.yy.c cal.tab.c
	lex < input.txt > output.txt

	