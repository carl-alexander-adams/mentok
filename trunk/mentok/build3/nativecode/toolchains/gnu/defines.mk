# Some things are the same for the toolchain, regardless of platform or version.
# These are the things we define in this file.


ifeq ($(EXTENSION_GNU_OBJ),)
EXTENSION_GNU_OBJ=.o
endif
ifeq ($(EXTENSION_GNU_EXE),)
EXTENSION_GNU_EXE=
endif
ifeq ($(EXTENSION_GNU_LIB),)
EXTENSION_GNU_LIB=.a
endif
ifeq ($(EXTENSION_GNU_SHLIB),)
EXTENSION_GNU_SHLIB=.so
endif

