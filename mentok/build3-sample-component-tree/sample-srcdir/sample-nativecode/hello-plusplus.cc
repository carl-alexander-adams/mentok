#include "hello-plusplus.h"

#include <iostream>

extern "C" {

#include <stdio.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <strings.h>

}


hello_plusplus::hello_plusplus(){
  printf("\t *** hello_plusplus::hello_plusplus\n");
}

hello_plusplus::~hello_plusplus(){
  
  printf("\t *** hello_plusplus::~hello_plusplus\n");
}

int hello_plusplus::say_it(){
  printf("\t *** hello_plusplus::say_it\n");
  printf("\t *** Hi Mom.\n");

  return 0;
}

hello_plusplus hello_plusplus::copy(){
  printf("\t *** hello_plusplus::copy \n");

  return *((hello_plusplus *)NULL);
}



