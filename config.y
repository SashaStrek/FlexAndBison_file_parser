/* File: config.y
   Bison code to generate a parser for node description files.
   Mar. 2025 -- Created by A.Strekalovskiy
*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

#include "config.h"

/* Define the global config instance */
Config config;

%}

/* Define types for values */
%union {
    char* str;
    int ival;
    double fval;
}

/* Declare token types */
%token <str> STRING IDENTIFIER
%token <ival> INT TRUE FALSE
%token <fval> FLOAT
%token EQUALS

/* Declare non-terminals' types */
%type <str> value

%%

config: /* empty */
      | config statement
      ;

statement: IDENTIFIER EQUALS value {
    if (strcmp($1, "name") == 0) config.name = strdup($3);
    else if (strcmp($1, "version") == 0) config.version = atof($3);
    else if (strcmp($1, "max_users") == 0) config.max_users = atoi($3);
    else if (strcmp($1, "enable_logging") == 0) config.enable_logging = strcmp($3, "true") == 0 ? 1 : 0;
    free($1);
    free($3);
  }
  ;

value: STRING   { $$ = strdup($1); }
     | INT      { asprintf(&$$, "%d", $1); }
     | FLOAT    { asprintf(&$$, "%lf", $1); }
     | TRUE     { $$ = strdup("true"); }
     | FALSE    { $$ = strdup("false"); }
     ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}