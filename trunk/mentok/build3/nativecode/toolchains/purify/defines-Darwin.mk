#
# Purify & Gnu tool chain
#
ifeq ($(BIN_PURIFY_CC),)
BIN_PURIFY_CC=$(BIN_FALSE) --purify-not-supported-on-this-platform--
endif
ifeq ($(BIN_PURIFY_CXX),)
BIN_PURIFY_CXX=$(BIN_FALSE) --purify-not-supported-on-this-platform--
endif
ifeq ($(BIN_PURIFY_AS),)
BIN_PURIFY_AS=$(BIN_FALSE) --purify-not-supported-on-this-platform--
endif
ifeq ($(BIN_PURIFY_CPP),)
BIN_PURIFY_CPP=$(BIN_FALSE) --purify-not-supported-on-this-platform--
endif
ifeq ($(BIN_PURIFY_LD),)
BIN_PURIFY_LD=$(BIN_FALSE) --purify-not-supported-on-this-platform--
endif
ifeq ($(BIN_PURIFY_AR),)
BIN_PURIFY_AR=$(BIN_FALSE) --purify-not-supported-on-this-platform--
endif
# Don't strip purify builds
ifeq ($(BIN_PURIFY_STRIP),)
BIN_PURIFY_STRIP=$(BIN_TRUE)
endif

