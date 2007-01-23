# Some things are the same for the toolchain, regardless of platform or version.
# These are the things we define in this file.


ifeq ($(EXTENSION_KERNMOD_OBJ),)
EXTENSION_KERNMOD_OBJ=.o
endif
ifeq ($(EXTENSION_KERNMOD_EXE),)
EXTENSION_KERNMOD_EXE=
endif
ifeq ($(EXTENSION_KERNMOD_LIB),)
EXTENSION_KERNMOD_LIB=.a
endif
ifeq ($(EXTENSION_KERNMOD_SHLIB),)
EXTENSION_KERNMOD_SHLIB=.so
endif

