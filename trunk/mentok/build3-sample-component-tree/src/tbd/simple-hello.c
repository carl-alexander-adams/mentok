#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>



int main(int argc, char ** argv, char ** env) 
{
    /* hush compiler warnings */
    (void) argc;
    (void) argv;
    (void) env;
    
    printf("Just a simple \"hello\".\nCheers!\n");
    return 0;
}

