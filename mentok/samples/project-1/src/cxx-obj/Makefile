# macros and includes to make the build system go. (generally this
# will be one of the first things in your Makefile)
COMPONENT_ROOT=../..
BS_ROOT=$(COMPONENT_ROOT)/build3
include $(BS_ROOT)/defines.mk


#
# Set up global C++ flags
#

FLAGS_CXX+=-I../include

# Specify bare C object pattern targets
OBJ_CXX_TARGETS=hello-plusplus.o hello-pp.o



#
# C++ targets have pretty much identical options
# as C objects, so see theC object exampls for detauils.
# the only major difference is flag macros are specified
# with "CXXFLAGS" rather than "CFLAGS"
#

#
# Options for hello-plusplus.o
#
# No options. use defaults and globals.


#
# Options for hello-pp.o
#
# hello-pp.o_TOOLCHAIN=GNU
hello-pp.o_CFLAGS=$(FLAGS_CXX) -DTEST_PER_OBJECT_CFLAGS


# include the rules to make the build system go. (generally this
# will be one of the last things in your Makefile)
include $(BS_ROOT)/rules.mk
