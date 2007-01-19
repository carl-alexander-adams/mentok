

#include "say-hi.h"
#include "print-runtime-version.h"
int main(int argc, char **argv, char **env) {
    /* hush compiler warnings */
    (void) argc;
    (void) argv;
    (void) env;

    say_hi();
    print_runtime_version();
    return 0;
}

