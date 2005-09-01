#include "hello-plusplus.h"


int main(int argc,
	 char ** argv,
	 char ** envv) {

  /* hush compiler warnings */
  (void) argc;
  (void) argv;
  (void) envv;

  hello_plusplus *hpp;

  hpp = new hello_plusplus();
  hpp->say_it();
  delete hpp;

  return 0;

}
