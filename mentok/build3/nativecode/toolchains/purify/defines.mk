# Some things are the same for the toolchain, regardless of platform or version.
# These are the things we define in this file.


ifeq ($(EXTENSION_PURIFY_OBJ),)
EXTENSION_PURIFY_OBJ=.o
endif
ifeq ($(EXTENSION_PURIFY_EXE),)
EXTENSION_PURIFY_EXE=
endif
ifeq ($(EXTENSION_PURIFY_LIB),)
EXTENSION_PURIFY_LIB=.a
endif
ifeq ($(EXTENSION_PURIFY_SHLIB),)
EXTENSION_PURIFY_SHLIB=.so
endif

