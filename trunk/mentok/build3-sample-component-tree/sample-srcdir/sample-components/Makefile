COMPONENT_ROOT=../..
BS_ROOT=$(COMPONENT_ROOT)/../build3

include $(BS_ROOT)/defines.mk

# This is an old convention. There is no real reason import targets
# cannot be directly included in any individual makefile if desired.
# Note: this is not to say that putting import targets into a seperate
# make file that is included by other Makefiles is a bad thing, on the
# contrary this can be quite usefle depeind on your tree structure since
# the import rules always import things into the COMPONENT_ROOT/
include imports.mk

SUBDIR_TARGETS=

EXPORT_DESC_TARGETS=test_descriptor

DIST_TARGETS=foo

# DISTROOT/<target>/<target_REV>COMPONENT_DISTTAG/<target_PLATFORM>/

foo_FROM=/home/myhome/scratch/src/my-project-trunk/src/export_code
foo_TO=
#foo_DISTROOT=
#foo_PLATFORM=noarch
foo_PLATFORMLINKS=
#foo_REV=3.1
#foo_COMMENT=build system 3.0 test component

#COMPONENT_DISTTAG=test_dist_tag



include $(BS_ROOT)/rules.mk
