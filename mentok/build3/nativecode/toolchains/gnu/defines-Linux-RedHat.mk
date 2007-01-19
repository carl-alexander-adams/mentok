#
# Gnu tool chain
#
# Note: the trailing space on the outflags is INTENTIONAL.
# the core rules leave no space between the output file
# and the outflag to accommodate some platforms. If you want
# space, add it here.
ifeq ($(BIN_GNU_CC),)
BIN_GNU_CC=/tools/gcc-3.0.4/bin/gcc
BIN_GNU_CC_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_GNU_CXX),)
BIN_GNU_CXX=/tools/gcc-3.0.4/bin/g++
BIN_GNU_CXX_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_GNU_AS),)
BIN_GNU_AS=/tools/gcc-3.0.4/bin/gcc
BIN_GNU_AS_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_GNU_CPP),)
BIN_GNU_CPP=/tools/gcc-3.0.4/bin/gcc -E
BIN_GNU_CPP_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_GNU_LD),)
BIN_GNU_LD=/tools/gcc-3.0.4/bin/gcc
BIN_GNU_LD_OUTPUTFLAG_EXE=-o 
BIN_GNU_LD_OUTPUTFLAG_SHLIB=-o 
BIN_GNU_LD_OUTPUTFLAG_INCOBJ=-o 
endif
ifeq ($(BIN_GNU_AR),)
BIN_GNU_AR=/usr/bin/ar
BIN_GNU_AR_OUTPUTFLAG=
endif
ifeq ($(BIN_GNU_STRIP),)
BIN_GNU_STRIP=/usr/bin/strip
endif



# take everything else from the broader Linux defaults.
