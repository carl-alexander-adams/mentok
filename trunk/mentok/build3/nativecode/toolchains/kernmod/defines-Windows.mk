#
# Kernen Module Tool Chain
#

#
# Gnu tool chain
# 
# Note: the trailing space on the outflags is INTENTIONAL.
# the core rules leave no space between the output file
# and the outflag to accommodate some platforms. If you want
# space, add it here.
ifeq ($(BIN_KERNMOD_CC),)
BIN_KERNMOD_CC=$(BIN_FALSE) --kernel-module-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_KERNMOD_CXX),)
BIN_KERNMOD_CXX=$(BIN_FALSE) --kernel-module-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_KERNMOD_AS),)
BIN_KERNMOD_AS=$(BIN_FALSE) --kernel-module-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_KERNMOD_CPP),)
BIN_KERNMOD_CPP=$(BIN_FALSE) --kernel-module-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_KERNMOD_LD),)
BIN_KERNMOD_LD=$(BIN_FALSE) --kernel-module-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_KERNMOD_AR),)
BIN_KERNMOD_AR=$(BIN_FALSE) --kernel-module-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_KERNMOD_STRIP),)
BIN_KERNMOD_STRIP=$(BIN_FALSE) --kernel-module-toolchain-not-supported-on-windows--
endif

# don't bother with flag settings.
