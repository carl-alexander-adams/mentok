ifeq ($(BIN_AUTOCONF),)
BIN_AUTOCONF=/usr/local/bin/autoconf
endif

ifeq ($(BIN_AUTOHEADER),)
BIN_AUTOHEADER=/usr/local/bin/autoheader
endif

ifeq ($(AUTOCONF_AUXTOOLS_DIR),)
AUTOCONF_AUXTOOLS_DIR=/usr/local/share/automake-1.6
endif
