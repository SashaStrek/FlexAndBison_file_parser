/* File: config.l
   Flex code to generate a parser for node description files.
   Mar. 2025 -- Created by A.Strekalovskiy
*/

%{
#undef yywrap
#include <stdio.h>
#include <stdlib.h>
#include "config.tab.h"  /* Bison header */

/* Explicitly declare yywrap */
int yywrap(void) { return 1; }

%}

%option noyywrap

%%

#.*                             { /* Ignore comments */ }
"true"                          { return TRUE; }
"false"                         { return FALSE; }
\"[^\"]*\"                      { yylval.str = strdup(yytext + 1); yylval.str[strlen(yylval.str) - 1] = '\0'; return STRING; }
[0-9]+\.[0-9]+                  { yylval.fval = atof(yytext); return FLOAT; }
[0-9]+                           { yylval.ival = atoi(yytext); return INT; }
[a-zA-Z_][a-zA-Z0-9_]*           { yylval.str = strdup(yytext); return IDENTIFIER; }
"="                              { return EQUALS; }
\n                               { /* Ignore new lines */ }
[ \t]+                           { /* Ignore whitespace */ }
.                                { printf("Unexpected character: %c\n", *yytext); }

%%