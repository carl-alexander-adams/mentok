# The source root of this component
COMPONENT_ROOT=../../..

# The root of the build system
BS_ROOT=$(COMPONENT_ROOT)/../build3

SUBDIR_TARGETS=

# Boostrap Build system definitions.
include $(BS_ROOT)/defines.mk


#
# Set up global C flags
#

FLAGS_CC+=-I../include

# Specify bare C object pattern targets
OBJ_CC_TARGETS=say-hello.o empty.o foo.o


#
# Options for say-hello.o
#
# use full defaults for say-hello.o. This is probably the normal
# thing do do, and it's the easiest, since we don't
# have to specify any say-hello.o_XXX macros.



#
# Options for empty.o
#
# ... and control the details of how the targets 
# specified above get produced. Some go full defaults,
# others we tweak.  Note that per-object FLAGS macros
# replace their global counterparts. because of this,
# you need to chain them if you do not wish to do
# a full override.
empty.o_TOOLCHAIN=VENDOR
#empty.o_CFLAGS=-DTEST_PER_OBJECT_CFLAGS
empty.o_CFLAGS_OPT=-DTEST_PER_OBJECT_CFLAGS_OPT
empty.o_CFLAGS_DBG=-DTEST_PER_OBJECT_CFLAGS_DEBUG
empty.o_CFLAGS_PROFILE=-DTEST_PER_OBJECT_CFLAGS_PROFILE
empty.o_CFLAGS_COV=-DTEST_PER_OBJECT_CFLAGS_COV

#
# Options for foo.o
#
foo.o_SRC=empty.c
foo.o_TOOLCHAIN=GNU
foo.o_CFLAGS=$(FLAGS_CC) -DTEST_PER_OBJECT_CFLAGS
foo.o_CFLAGS_OPT=-DTEST_PER_OBJECT_CFLAGS_OPT
foo.o_CFLAGS_DBG=-DTEST_PER_OBJECT_CFLAGS_DEBUG
foo.o_CFLAGS_PROFILE=-DTEST_PER_OBJECT_CFLAGS_PROFILE
foo.o_CFLAGS_COV=-DTEST_PER_OBJECT_CFLAGS_COV


# Finally, include the rules to make the build system go.
include $(BS_ROOT)/rules.mk
