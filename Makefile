# Tool definitions
CC = gcc
LEX = flex
YACC = bison -d

# Default target
all: config

# Generate parser source files using Bison
config.tab.c config.tab.h: config.y
	$(YACC) config.y

# Generate lexer source file using Flex
lex.yy.c: config.l config.tab.h
	$(LEX) config.l

# Compile the generated parser code
config.tab.o: config.tab.c
	$(CC) -g -O0 -c config.tab.c

# Compile the generated lexer code
lex.yy.o: lex.yy.c
	$(CC) -g -O0 -c lex.yy.c

# Compile the main program file
main.o: main.c
	$(CC) -g -O0 -c main.c

# Link all object files into the final executable
config: config.tab.o lex.yy.o main.o
	$(CC) -g -O0 -o config config.tab.o lex.yy.o main.o

# Clean-up target
clean:
	rm -f config *.o config.tab.* lex.yy.c

# Yes, the order of these rules in the Makefile does not determine the execution order.
# But why do you want to increase the entropy?
# Butts are already burning.