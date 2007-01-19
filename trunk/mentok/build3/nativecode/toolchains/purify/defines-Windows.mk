#
# Purify & Gnu tool chain
#
# 
# Note: the trailing space on the outflags is INTENTIONAL.
# the core rules leave no space between the output file
# and the outflag to accommodate some platforms. If you want
# space, add it here.
ifeq ($(BIN_PURIFY_CC),)
BIN_PURIFY_CC=$(BIN_FALSE) --purify-toolchain-not-supported-on-windows--
BIN_PURIFY_CC_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_PURIFY_CXX),)
BIN_PURIFY_CXX=$(BIN_FALSE) --purify-toolchain-not-supported-on-windows--
BIN_PURIFY_CXX_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_PURIFY_AS),)
BIN_PURIFY_AS=$(BIN_FALSE) --purify-toolchain-not-supported-on-windows--
BIN_PURIFY_AS_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_PURIFY_CPP),)
BIN_PURIFY_CPP=$(BIN_FALSE) --purify-toolchain-not-supported-on-windows--
BIN_PURIFY_CPP_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_PURIFY_LD),)
BIN_PURIFY_LD=$(BIN_FALSE) --purify-toolchain-not-supported-on-windows--
BIN_PURIFY_LD_OUTPUTFLAG_EXE=-o 
BIN_PURIFY_LD_OUTPUTFLAG_SHLIB=-o 
BIN_PURIFY_LD_OUTPUTFLAG_INCOBJ=-o 
endif
ifeq ($(BIN_PURIFY_AR),)
BIN_PURIFY_AR=$(BIN_FALSE) --purify-toolchain-not-supported-on-windows--
BIN_PURIFY_AR_OUTPUTFLAG=
endif
# Don't strip purify builds
ifeq ($(BIN_PURIFY_STRIP),)
BIN_PURIFY_STRIP=$(BIN_TRUE)
endif


# don't bother to define flag macros.

