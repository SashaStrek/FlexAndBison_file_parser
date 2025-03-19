#ifndef CONFIG_H
#define CONFIG_H

typedef struct {
    char* name;
    double version;
    int max_users;
    int enable_logging;
} Config;

/* Declare the global config struct */
extern Config config;

#endif /* CONFIG_H */