#include <stdlib.h>

#include "hello.h"

#include "empty.h"

void empty(void) {
    return;
}

int iempty(int i) {
    return i;
}

void *pempty(int i, int j) {
    /* put some data on the stack to play with in the assembler */
    int intiger = 1;
    double dbl = 2;
    char chr = 'c';
    void *point = NULL;
    char *msg = TESTSTRING_HELLO;
    double unused1;
    double unused2;
    double unused3;
    double unused4;

    return NULL;
}


