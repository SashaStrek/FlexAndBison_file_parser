/* File: main.c
   The project reads a configuration file (config.def), 
   parses key-value pairs and stores the values in global variables inside a Config struct.
   Mar. 2025 -- Created by A.Strekalovskiy
*/

#include <stdio.h>
#include "config.h"
/* "Config config;" is already declared in config.h */

extern int yyparse();
extern FILE *yyin;

int main(int argc, char *argv[]) {
    // FILE *file = fopen("config.def", "r");
    // if (!file) {
    //     perror("Error opening config.def");
    //     return 1;
    // }
    
    // Handle the file opening
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <file.def>\n", argv[0]);
        return 1;
    }
    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    // Set `yyin` to read. Parse. Close.
    yyin = file;
    yyparse();
    fclose(file);

    // Print
    printf("Config Loaded from: %s\n", argv[1]);
    printf("Name: %s\n", config.name);
    printf("Version: %lf\n", config.version);
    printf("Max Users: %d\n", config.max_users);
    printf("Enable Logging: %s\n", config.enable_logging ? "true" : "false");

    return 0;
}