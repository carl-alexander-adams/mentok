# special top levelmakefile to do the config stuff first
# uses none of the defines or macros

COMPONENT_ROOT=..
BS_ROOT=$(COMPONENT_ROOT)/build3

include $(BS_ROOT)/defines.mk

BUILDSTAMP_TARGETS=buildnum
CONFIGH_TARGETS=config.h

OBJ_CC_TARGETS=buildnum.o

buildnum.o_SRC=$(BS_ARCH_TARGET_DIR)/buildnum.c

#This must go last
include $(BS_ROOT)/rules.mk

