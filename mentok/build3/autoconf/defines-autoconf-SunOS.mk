ifeq ($(BIN_AUTOCONF),)
BIN_AUTOCONF=/usr/local/bin/autoconf
endif

ifeq ($(BIN_AUTOHEADER),)
BIN_AUTOHEADER=/usr/local/bin/autoheader
endif


ifeq ($(BIN_CONFIGGUESS),)
BIN_CONFIGGUESS=/usr/local/libtool/config.guess
endif

ifeq ($(BIN_CONFIGSUB),)
BIN_CONFIGSUB=/usr/local/libtool/config.sub
endif
