#include "hello-plusplus.h"


int main(int argc,
	 char ** argv,
	 char ** envv) {

  hello_plusplus *hpp;

  hpp = new hello_plusplus();
  hpp->say_it();
  delete hpp;

  return 0;

}
