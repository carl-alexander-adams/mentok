TREEROOT        = ../../..
DONT_INCLUDE_PLATFORM_DEFINES=1 
include $(TREEROOT)/build/common/defines.mk

all: config.h defines.mk rules.mk config.h

config.h.in: configure.in
	autoheader;

configure: configure.in config.h.in defines.mk.in rules.mk.in
	autoconf

defines.mk rules.mk config.h: configure
	./configure;

