ifeq ($(BIN_CP),)
BIN_CP=C:/cygwin/bin/cp.exe
endif

ifeq ($(BIN_MV),)
BIN_MV=C:/cygwin/bin/mv.exe
endif

ifeq ($(BIN_TAR),)
BIN_TAR=C:/cygwin/bin/tar.exe
endif

ifeq ($(BIN_LN),)
BIN_LN=C:/cygwin/bin/ln.exe
endif

ifeq ($(BIN_RM),)
BIN_RM=C:/cygwin/bin/rm.exe
endif

ifeq ($(BIN_TOUCH),)
BIN_TOUCH=C:/cygwin/bin/touch.exe
endif

ifeq ($(BIN_MKDIR),)
BIN_MKDIR=C:/cygwin/bin/mkdir.exe
endif

ifeq ($(BIN_CAT),)
BIN_CAT=C:/cygwin/bin/cat.exe
endif

ifeq ($(BIN_SED),)
BIN_SED=C:/cygwin/bin/sed.exe
endif

ifeq ($(BIN_AWK),)
BIN_AWK=C:/cygwin/bin/awk.exe
endif

ifeq ($(BIN_GREP),)
BIN_GREP=C:/cygwin/bin/egrep.exe
endif

ifeq ($(BIN_GZIP),)
BIN_GZIP=C:/cygwin/bin/gzip.exe
endif

ifeq ($(BIN_ZIP),)
BIN_ZIP=C:/cygwin/bin/zip.exe
endif

ifeq ($(BIN_CHOWN),)
BIN_CHOWN=C:/cygwin/bin/chown.exe
endif

ifeq ($(BIN_CHMOD),)
BIN_CHMOD=C:/cygwin/bin/chmod.exe
endif

ifeq ($(BIN_DATE),)
BIN_DATE=C:/cygwin/bin/date.exe
endif

ifeq ($(BIN_SLEEP),)
BIN_SLEEP=C:/cygwin/bin/sleep.exe
endif

ifeq ($(BIN_TRUE),)
BIN_TRUE=C:/cygwin/bin/true.exe
endif

ifeq ($(BIN_FALSE),)
BIN_FALSE=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_LYNX),)
BIN_LYNX=C:/cygwin/bin/lynx.exe
endif

ifeq ($(BIN_LINKS),)
BIN_LINKS=C:/cygwin/bin/links.exe
endif

ifeq ($(BIN_CD),)
BIN_CD=cd
endif

ifeq ($(BIN_PWD),)
BIN_PWD=C:/cygwin/bin/pwd.exe
endif

ifeq ($(BIN_FIND),)
BIN_FIND=C:/cygwin/bin/find.exe
endif

ifeq ($(BIN_PERL),)
# if you have active perl installed along side cygwin perl
BIN_PERL=C:/Perl/bin/perl.exe
# BIN_PERL=C:/cygwin/bin/perl.exe
endif

ifeq ($(BIN_BSCATMAN),)
BIN_BSCATMAN=$(BIN_LYNX) -dump
endif

ifeq ($(BIN_SH),)
BIN_SH=C:/cygwin/bin/bash.exe
endif

ifeq ($(BIN_PRINTF),)
BIN_PRINTF=C:/cygwin/bin/printf.exe
endif

ifeq ($(BIN_ECHO),)
BIN_ECHO=C:/cygwin/bin/echo.exe
endif

ifeq ($(BIN_WHOAMI),)
BIN_WHOAMI=C:/cygwin/bin/whoami.exe
endif

ifeq ($(BIN_TEST),)
BIN_TEST=C:/cygwin/bin/test.exe
endif

