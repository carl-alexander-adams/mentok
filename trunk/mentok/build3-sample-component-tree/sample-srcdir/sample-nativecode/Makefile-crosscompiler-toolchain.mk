#
# XXX - simple executive linking does not yet work. we have not componentized the runtime lib
# XXX - c++ cross compiling doesn't work yet, we have not fixed incude paths.

# The source root of this component
COMPONENT_ROOT=../..

# The root of the build system
BS_ROOT=$(COMPONENT_ROOT)/../build3

# Boostrap Build system definitions.
include $(BS_ROOT)/defines.mk
include imports.mk

# override default toolchain
NC_CONTROL_TOOLCHAIN=XC_CAVIUMMIPS64_LINUX
#NC_CONTROL_TOOLCHAIN=XC_CAVIUMMIPS64_SIMPLEEXECUTIVE

#
# Set up global C flags for Lex/Yacc
#

FLAGS_CC+=-I$(BS_ARCH_TARGET_DIR)

# Generate src code from lex code.
LEX_TARGETS=foo.yy.c

# Generate src code from yacc code.
YACC_TARGETS=bar.tab.c


# Specify executable pattern targets
EXE_TARGETS=simple-hello hello hi # simple-hello-simpleexec hi-simpleexec hello2 hello-pp 


# Specify shared lib pattern targets
SHLIB_TARGETS=libhello.so

# Specify static lib pattern targets
LIB_TARGETS=libhello.a


# Specify bare C object pattern targets
OBJ_CC_TARGETS=say-hello.o empty.o foo.o foo.yy.o bar.tab.o


foo.yy.o_SRC=$(BS_ARCH_TARGET_DIR)/foo.yy.c
bar.tab.o_SRC=$(BS_ARCH_TARGET_DIR)/bar.tab.c

# Specify bare C++ object pattern targets
# OBJ_CXX_TARGETS=hello-plusplus.o

# Specify bare assembly object pattern targets
OBJ_AS_TARGETS=say-hi-MIPS64.o

# Specify incrementally linked object targets
OBJ_INC_TARGETS=incobj.o



# ... and control the details of how the targets 
# specified above get produced. Some go full defaults,
# others we tweak.
say-hello.o_CFLAGS=-DTEST_PER_OBJECT_CFLAGS
say-hello.o_CFLAGS_OPT=-DTEST_PER_OBJECT_CFLAGS_OPT
say-hello.o_CFLAGS_DBG=-DTEST_PER_OBJECT_CFLAGS_DEBUG
say-hello.o_CFLAGS_PROFILE=-DTEST_PER_OBJECT_CFLAGS_PROFILE
say-hello.o_CFLAGS_COV=-DTEST_PER_OBJECT_CFLAGS_COV

foo.o_SRC=empty.c
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
hello-pp_LD=$(BIN_CX_CAVIUMMIPS64_LINUX_CXX)

print-runtime-version.o_CFLAGS=-DHELLO_USE_GLIBC
#print-runtime-version-simpleexec.o_CFLAGS=

hi_OBJS=hi.o  say-hi-MIPS64.o print-runtime-version.o


say-hi-MIPS64-simpleexec.o_TOOLCHAIN=XC_CAVIUMMIPS64_SIMPLEEXECUTIVE

hi-simpleexec.o_TOOLCHAIN=XC_CAVIUMMIPS64_SIMPLEEXECUTIVE
hi-simpleexec.o_SRC=hi.c

print-runtime-version-simpleexec.o_TOOLCHAIN=XC_CAVIUMMIPS64_SIMPLEEXECUTIVE
print-runtime-version-simpleexec.o_SRC=print-runtime-version.c

hi-simpleexec_TOOLCHAIN=XC_CAVIUMMIPS64_SIMPLEEXECUTIVE
hi-simpleexec_OBJS=hi-simpleexec.o  say-hi-MIPS64-simpleexec.o print-runtime-version-simpleexec.o

simple-hello-simpleexec_TOOLCHAIN=XC_CAVIUMMIPS64_SIMPLEEXECUTIVE
simple-hello-simpleexec_OBJS=simple-hello-simpleexec.o
simple-hello-simpleexec.o_TOOLCHAIN=XC_CAVIUMMIPS64_SIMPLEEXECUTIVE
simple-hello-simpleexec.o_SRC=simple-hello.c

incobj.o_OBJS=foo.o say-hello.o
#incobj.o_TOOLCHAIN=VENDOR

libhello.so_OBJS=say-hi-MIPS64.o say-hello.o
libhello.a_OBJS=say-hi-MIPS64.o say-hello.o



# Finally, include the rules to make the build system go.
include $(BS_ROOT)/rules.mk
