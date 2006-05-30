COMPONENT_ROOT=..
BS_ROOT=$(COMPONENT_ROOT)/../build3

include $(BS_ROOT)/defines.mk

BUILDSTAMP_TARGETS=buildnum_test

SUBDIR_TARGETS=sample-components sample-nativecode

OBJ_CC_TARGETS=buildnum_test.o
buildnum_test.o_SRC=$(BS_ARCH_TARGET_DIR)/buildnum_test.c


include $(BS_ROOT)/rules.mk

# Force non-default behaviro of building the buildnumber before you
# decend into the SUBDIR_TARGETS

