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

    /* hush compiler warnings */
    (void) i;
    (void) j;
    
    (void) intiger;
    (void) dbl;
    (void) chr;
    (void) point;
    (void) msg;
    (void) unused1;
    (void) unused2;
    (void) unused3;
    (void) unused4;

    return NULL;
}


