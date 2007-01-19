#
# Gnu tool chain
#
ifeq ($(BIN_GNU_CC),)
BIN_GNU_CC=/tools/bin/gcc
endif
ifeq ($(BIN_GNU_CXX),)
BIN_GNU_CXX=/tools/bin/g++
endif
ifeq ($(BIN_GNU_AS),)
BIN_GNU_AS=/tools/bin/gcc
endif
ifeq ($(BIN_GNU_CPP),)
BIN_GNU_CPP=/tools/bin/gcc -E
endif
ifeq ($(BIN_GNU_LD),)
BIN_GNU_LD=/tools/bin/gcc
endif
ifeq ($(BIN_GNU_AR),)
BIN_GNU_AR=/usr/bin/ar
endif
ifeq ($(BIN_GNU_STRIP),)
BIN_GNU_STRIP=/usr/bin/strip
endif


# take everything else from the broader Linux defaults.