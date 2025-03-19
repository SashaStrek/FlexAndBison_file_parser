# FlexAndBison_file_parser  
Simple Configuration File Parser with Flex and Bison  
  
## How to use On MAC  
$ git clone <put_the_link>  
$ cd FlexAndBison_file_parser  
  
$ brew install flex bison  
$ which flex  
/usr/bin/flex  
$ which bison  
/usr/bin/bison  
  
$ flex --version  
flex 2.6.4 Apple(flex-35)  
  
$ bison --version  
bison (GNU Bison) 2.3  
  
$ make clean  
$ make  
$ make clean && make  
  
$ ./config config.def  
  
## Debugging  
$ lldb ./config  
(lldb) target create "./config"  
(lldb) breakpoint set --name main  
(lldb) run  
(lldb) next  
(lldb) next  
(lldb) next  
(lldb) frame variable config  
(lldb) frame variable config.name  
  
If you want to step inside a function:  
(lldb) step  
If you want to continue running the program until the next breakpoint or completion:  
(lldb) continue  
  
## WTF?  
The project reads a configuration file (config.def), parses key-value pairs and stores the values in global variables inside a Config struct.  
  
### Step 1: Flex (Lexical Analysis)  
What Flex (config.l) Does  
	•	Reads the file character by character and tokenizes it.  
	•	Recognizes identifiers, numbers, strings, and boolean values.  
	•	Ignores whitespace and comments.  
	•	Sends recognized tokens to Bison for parsing.  
Example:  
    For this line:  
        name = "MyProgram"  
    Flex converts it into tokens:  
        IDENTIFIER("name")  EQUALS("=")  STRING("MyProgram")  
  
### Step 2: Bison (Parsing & Processing)  
What Bison (config.y) Does  
	•	Receives tokens from Flex.  
	•	Validates syntax (ensures key = value format).  
	•	Stores values into the Config struct.  
Example:  
    When Bison receives:  
        IDENTIFIER("name")  EQUALS("=")  STRING("MyProgram")  
    It executes this grammar rule:  
        statement: IDENTIFIER EQUALS value {  
            if (strcmp($1, "name") == 0) config.name = strdup($3);  
        }  
    Which assigns:  
        config.name = "MyProgram";  
  
### Step 3: Storing Values in the Config Struct  
Once all lines are parsed, the final global config struct gets the values from the .def file.  
  
### Step 4: Printing  
After parsing (yyparse();), main.c prints the stored configuration.  