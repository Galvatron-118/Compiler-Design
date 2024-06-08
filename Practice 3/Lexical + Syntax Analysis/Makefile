main:
	bison -d cal.y
	flex cal.l
	gcc -o lex lex.yy.c cal.tab.c
	./lex <input.txt>output.txt
	