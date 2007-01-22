#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "hello.h"

#include "exercise-memory-debug.h"

#define ARRAY_SIZE 16

int exercise_memory_debug(void) {
    int i;
    struct teststruct_s *foo_ptr;
    struct teststruct_s *foo1_array;
    struct teststruct_s *foo2_array;
    struct teststruct_s *foo3_array;
    struct teststruct_s *foo4_array;


    /* allocate memory from heap */
    foo1_array = (struct teststruct_s *)
	malloc(ARRAY_SIZE * sizeof(struct teststruct_s));
    memset(foo1_array, 0, ARRAY_SIZE * sizeof(struct teststruct_s));
    
    foo2_array = (struct teststruct_s *)
	malloc(ARRAY_SIZE * sizeof(struct teststruct_s));
    memset(foo2_array, 0, ARRAY_SIZE * sizeof(struct teststruct_s));

    foo3_array = (struct teststruct_s *)
	malloc(ARRAY_SIZE * sizeof(struct teststruct_s));
    memset(foo3_array, 0, ARRAY_SIZE * sizeof(struct teststruct_s));

    foo4_array = (struct teststruct_s *)
	malloc(ARRAY_SIZE * sizeof(struct teststruct_s));
    /* memset(foo4_array, 0, ARRAY_SIZE * sizeof(struct teststruct_s)); */


    
    /* ABR error.. read one past end of allocated array */
    for ( i = 0 ; i <= ARRAY_SIZE ; i++) {
	foo_ptr = &(foo1_array[i]);
	printf("Array1  Index: %d     data1: %d\n", i, foo_ptr->intdata1);
    }
    /* UMR error, we never initilized the data in this array. */
    for ( i = 0 ; i < ARRAY_SIZE ; i++) {
	foo_ptr = &(foo4_array[i]);
	printf("Array4  Index: %d     data1: %d\n", i, foo_ptr->intdata1);
    }

    /* Potential leak. move pointer up to middle of an allocated block */
    foo1_array++;
    
    /* unleak potential leak. move pointer back to start of allocated block */
    foo1_array--;
	
    /* really leak. */
    foo1_array = NULL;
    foo_ptr = NULL;

    /* manage some memory correctly */
    free(foo2_array);

    /* Double free some memory */
    free(foo3_array);
    free(foo3_array);

    /* free a pointer to the middle of an allocated block */
    free(&(foo4_array[3]));
    
    /* good-bye */
    return 0;

}
