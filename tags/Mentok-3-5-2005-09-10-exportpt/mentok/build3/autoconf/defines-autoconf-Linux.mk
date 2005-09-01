ifeq ($(BIN_AUTOCONF),)
BIN_AUTOCONF=/usr/bin/autoconf
endif

ifeq ($(BIN_AUTOHEADER),)
BIN_AUTOHEADER=/usr/bin/autoheader
endif

ifeq ($(BIN_CONFIGGUESS),)
BIN_CONFIGGUESS=/usr/share/libtool/config.guess
endif

ifeq ($(BIN_CONFIGSUB),)
BIN_CONFIGSUB=/usr/share/libtool/config.sub
endif
