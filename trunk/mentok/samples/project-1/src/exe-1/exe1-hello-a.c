#include <stdio.h>

#include "hello.h"


static char *object_static_global_string = TESTSTRING_TEST3;

void main(void) {
    char *msg = TESTSTRING_HELLO;
    printf("%s\n", msg);
    printf("%s\n", TESTSTRING_TEST2);
    printf("%s\n", object_static_global_string);
    return;
}

