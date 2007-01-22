#include <stdio.h>

#include "print-runtime-version.h"

void print_runtime_version(void) {
#ifdef HELLO_USE_GLIBC
    printf("glibc runtime version: %s\n", gnu_get_libc_version());
    printf("glibc runtime release: %s\n", gnu_get_libc_release());
#else
    printf("unknown runtime environment\n");
#endif
}

