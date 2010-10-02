#
# Gnu tool chain
#
# Note: the trailing space on the outflags is INTENTIONAL.
# the core rules leave no space between the output file
# and the outflag to accommodate some platforms. If you want
# space, add it here.

# On CentOS, set the "GNU" toolchain to be the same as the Vendor.
# 
ifeq ($(BIN_GNU_CC),)
BIN_GNU_CC=$(BIN_VENDOR_CC)
BIN_GNU_CC_OUTPUTFLAG=$(BIN_VENDOR_CC_OUTPUTFLAG)
endif
ifeq ($(BIN_GNU_CXX),)
BIN_GNU_CXX=$(BIN_VENDOR_CXX)
BIN_GNU_CXX_OUTPUTFLAG=$(BIN_VENDOR_CXX_OUTPUTFLAG)
endif
ifeq ($(BIN_GNU_AS),)
BIN_GNU_AS=$(BIN_VENDOR_AS)
BIN_GNU_AS_OUTPUTFLAG=$(BIN_VENDOR_AS_OUTPUTFLAG)
endif
ifeq ($(BIN_GNU_CPP),)
BIN_GNU_CPP=$(BIN_VENDOR_CPP)
BIN_GNU_CPP_OUTPUTFLAG=$(BIN_VENDOR_CPP_OUTPUTFLAG)
endif
ifeq ($(BIN_GNU_LD),)
BIN_GNU_LD=$(BIN_VENDOR_LD)
BIN_GNU_LD_OUTPUTFLAG_EXE=$(BIN_VENDOR_LD_OUTPUTFLAG_EXE)
BIN_GNU_LD_OUTPUTFLAG_SHLIB=$(BIN_VENDOR_LD_OUTPUTFLAG_SHLIB)
BIN_GNU_LD_OUTPUTFLAG_INCOBJ=$(BIN_VENDOR_LD_OUTPUTFLAG_INCOBJ)
endif
ifeq ($(BIN_GNU_AR),)
BIN_GNU_AR=$(BIN_VENDOR_AR)
BIN_GNU_AR_OUTPUTFLAG=$(BIN_VENDOR_AR_OUTPUTFLAG)
endif
ifeq ($(BIN_GNU_STRIP),)
BIN_GNU_STRIP=$(BIN_VENDOR_STRIP)
endif


# take everything else from the broader Linux defaults.