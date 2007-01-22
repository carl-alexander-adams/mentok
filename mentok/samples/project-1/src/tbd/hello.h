#ifndef _hello_h_
#define _hello_h_

#define TESTSTRING_HELLO  "Hi Mom\n"
#define TESTSTRING_TEST1 "This is test string 1"
#define TESTSTRING_TEST2 "This is test string 2"
#define TESTSTRING_TEST3 "This is test string 3"

#define TESTSTRUCT_ARRAY_SIZE 10
struct teststruct_s {
    char array[TESTSTRUCT_ARRAY_SIZE];
    int intdata1;
    int intdata2;
    char *pointer1;
};


#endif /* _hello_h_ */

