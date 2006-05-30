#include <stdio.h>

#include "hello.h"
#include "say-hello.h"


static char *object_static_global_string = TESTSTRING_TEST3;

void say_hello(void) {
    char *msg = TESTSTRING_HELLO;
    printf("%s\n", msg);
    printf("%s\n", TESTSTRING_TEST2);
    printf("%s\n", object_static_global_string);
    return;
}

