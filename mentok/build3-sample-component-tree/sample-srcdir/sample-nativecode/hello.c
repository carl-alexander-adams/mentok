#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


#include "hello.h"
#include "exercise-memory-debug.h"
#include "empty.h"
#include "say-hello.h"

char *global_string = TESTSTRING_TEST1;


int main(int argc, char ** argv, char ** env) 
{
    /* hush compiler warnings */
    (void) argc;
    (void) argv;
    (void) env;
    
    say_hello();
    empty();
    iempty(42);
    pempty(3,17);
    exercise_memory_debug();
    
    printf("Argv[0] %s\n", argv[0]);

    exit(0);
}

