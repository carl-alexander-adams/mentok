# The source root of this component
COMPONENT_ROOT=../..

# The root of the build system
BS_ROOT=$(COMPONENT_ROOT)/../build3

# Boostrap Build system definitions.
include $(BS_ROOT)/defines.mk


#
# Set up global C flags for Lex/Yacc
#

FLAGS_CC+=-I$(BS_ARCH_TARGET_DIR)

# Generate src code from lex code.
LEX_TARGETS=foo.yy.c

# Generate src code from yacc code.
YACC_TARGETS=bar.tab.c


# Specify executable pattern targets
EXE_TARGETS=hello hello-pp hi hello2 simple-hello


# Specify shared lib pattern targets
SHLIB_TARGETS=libhello.so libhello-vendorlinker.so

# Specify static lib pattern targets
LIB_TARGETS=libhello.a


# Specify bare C object pattern targets
OBJ_CC_TARGETS=say-hello.o empty.o foo.o foo.yy.o bar.tab.o


foo.yy.o_SRC=$(BS_ARCH_TARGET_DIR)/foo.yy.c
bar.tab.o_SRC=$(BS_ARCH_TARGET_DIR)/bar.tab.c

# Specify bare C++ object pattern targets
OBJ_CXX_TARGETS=hello-plusplus.o

# Specify bare assembly object pattern targets
OBJ_AS_TARGETS=say-hi-IA32.o

# Specify incrementally linked object targets
OBJ_INC_TARGETS=incobj.o



# ... and control the details of how the targets 
# specified above get produced. Some go full defaults,
# others we tweak.
say-hello.o_TOOLCHAIN=VENDOR
#say-hello.o_CFLAGS=-DTEST_PER_OBJECT_CFLAGS
say-hello.o_CFLAGS_OPT=-DTEST_PER_OBJECT_CFLAGS_OPT
say-hello.o_CFLAGS_DBG=-DTEST_PER_OBJECT_CFLAGS_DEBUG
say-hello.o_CFLAGS_PROFILE=-DTEST_PER_OBJECT_CFLAGS_PROFILE
say-hello.o_CFLAGS_COV=-DTEST_PER_OBJECT_CFLAGS_COV

foo.o_SRC=empty.c
foo.o_TOOLCHAIN=VENDOR
foo.o_CFLAGS=-DTEST_PER_OBJECT_CFLAGS
foo.o_CFLAGS_OPT=-DTEST_PER_OBJECT_CFLAGS_OPT
foo.o_CFLAGS_DBG=-DTEST_PER_OBJECT_CFLAGS_DEBUG
foo.o_CFLAGS_PROFILE=-DTEST_PER_OBJECT_CFLAGS_PROFILE
foo.o_CFLAGS_COV=-DTEST_PER_OBJECT_CFLAGS_COV


hello_OBJS=hello.o empty.o exercise-memory-debug.o say-hello.o

hello2_OBJS=hello.o empty.o exercise-memory-debug.o
#hello2_LDFLAGS=-L$(BS_ARCH_TARGET_DIR) -lhello
hello2_LDFLAGS_LOADLIBS=-L$(BS_ARCH_TARGET_DIR) -lhello

hello-pp_OBJS=hello-pp.o hello-plusplus.o
hello-pp.o_TOOLCHAIN=GNU
hello-plusplus.o_TOOLCHAIN=GNU
hello-pp_LD=$(BIN_GNU_CXX)

print-runtime-version.o_FCFLAGS=-D_GNU_SOURCE

hi_OBJS=hi.o  say-hi-IA32.o print-runtime-version.o

incobj.o_OBJS=foo.o say-hello.o
incobj.o_TOOLCHAIN=VENDOR

libhello.so_OBJS=say-hi-IA32.o say-hello.o
libhello.a_OBJS=say-hi-IA32.o say-hello.o

libhello-vendorlinker.so_OBJS=$(libhello.so_OBJS)
libhello-vendorlinker.so_TOOLCHAIN=VENDOR


# Finally, include the rules to make the build system go.
include $(BS_ROOT)/rules.mk
