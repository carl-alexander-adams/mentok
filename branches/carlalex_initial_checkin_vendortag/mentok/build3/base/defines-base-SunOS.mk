ifeq ($(BIN_CP),)
BIN_CP=/usr/bin/cp
endif

ifeq ($(BIN_TAR),)
BIN_TAR=/usr/bin/tar
endif

ifeq ($(BIN_LN),)
BIN_LN=/usr/bin/ln
endif

ifeq ($(BIN_RM),)
BIN_RM=/usr/bin/rm
endif

ifeq ($(BIN_TOUCH),)
BIN_TOUCH=/usr/bin/touch
endif

ifeq ($(BIN_MKDIR),)
BIN_MKDIR=/usr/bin/mkdir
endif

ifeq ($(BIN_CAT),)
BIN_CAT=/usr/bin/cat
endif

ifeq ($(BIN_SED),)
BIN_SED=/usr/bin/sed
endif

ifeq ($(BIN_AWK),)
BIN_AWK=/usr/bin/awk
endif

ifeq ($(BIN_GREP),)
BIN_GREP=/usr/bin/egrep
endif

ifeq ($(BIN_GZIP),)
BIN_GZIP=/usr/bin/gzip
endif

ifeq ($(BIN_ZIP),)
BIN_ZIP=/usr/bin/zip
endif

ifeq ($(BIN_CHOWN),)
BIN_CHOWN=/usr/bin/chown
endif

ifeq ($(BIN_CHMOD),)
BIN_CHMOD=/usr/bin/chmod
endif

ifeq ($(BIN_DATE),)
BIN_DATE=/usr/bin/date
endif

ifeq ($(BIN_SLEEP),)
BIN_SLEEP=/usr/bin/sleep
endif

ifeq ($(BIN_TRUE),)
BIN_TRUE=/bin/true
endif

ifeq ($(BIN_FALSE),)
BIN_FALSE=/bin/false
endif

ifeq ($(BIN_LYNX),)
BIN_LYNX=/usr/local/bin/lynx
endif

ifeq ($(BIN_LINKS),)
BIN_LINKS=/usr/bin/links
endif

ifeq ($(BIN_CD),)
BIN_CD=cd
endif

ifeq ($(BIN_PWD),)
BIN_PWD=/bin/pwd
endif

ifeq ($(BIN_FIND),)
BIN_FIND=/usr/bin/find
endif

ifeq ($(BIN_PERL),)
BIN_PERL=/usr/local/bin/perl
endif

ifeq ($(BIN_BSCATMAN),)
BIN_BSCATMAN=$(BIN_LYNX) -dump
endif
