ifeq ($(BIN_AUTOCONF),)
BIN_AUTOCONF=/usr/bin/autoconf
endif

ifeq ($(BIN_AUTOHEADER),)
BIN_AUTOHEADER=/usr/bin/autoheader
endif

ifeq ($(AUTOCONF_AUXTOOLS_DIR),)
AUTOCONF_AUXTOOLS_DIR=/usr/share/automake-1.6
endif
