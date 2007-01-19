#
# Cavium MIPS 64 Linux cross compiler toolchain
#
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_CC),)
BIN_XC_CAVIUMMIPS64_LINUX_CC=$(BIN_FALSE) --cavium-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_CXX),)
BIN_XC_CAVIUMMIPS64_LINUX_CXX=$(BIN_FALSE) --cavium-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_AS),)
BIN_XC_CAVIUMMIPS64_LINUX_AS=$(BIN_FALSE) --cavium-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_CPP),)
BIN_XC_CAVIUMMIPS64_LINUX_CPP=$(BIN_FALSE) --cavium-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_LD),)
BIN_XC_CAVIUMMIPS64_LINUX_LD=$(BIN_FALSE) --cavium-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_AR),)
BIN_XC_CAVIUMMIPS64_LINUX_AR=$(BIN_FALSE) --cavium-toolchain-not-supported-on-windows--
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_STRIP),)
BIN_XC_CAVIUMMIPS64_LINUX_STRIP=$(BIN_FALSE)
endif


# don't bother to define flag macros.

