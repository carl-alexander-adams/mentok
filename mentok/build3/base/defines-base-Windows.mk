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

ifeq ($(BIN_LS),)
BIN_LS=c:/cygwin/bin/ls.exe
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

ifeq ($(BIN_BZIP2),)
BIN_BZIP2=C:/cygwin/bin/bzip2.exe
endif

ifeq ($(BIN_ZIP),)
BIN_ZIP=C:/cygwin/bin/zip.exe
endif

ifeq ($(BIN_UNZIP),)
BIN_UNZIP=C:/cygwin/bin/unzip.exe
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

ifeq ($(BIN_PYTHON),)
BIN_PYTHON=C:/cygwin/bin/false.exe
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

ifeq ($(BIN_EPM),)
BIN_EPM=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_MKEPMLIST),)
BIN_MKEPMLIST=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_RPM),)
BIN_RPM=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_RPM2CPIO),)
BIN_RPM2CPIO=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_CPIO),)
BIN_PIO=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_CURL),)
BIN_CURL=c:/cygwwin/bin/curl.exe
endif

ifeq ($(BIN_PHP),)
BIN_PHP=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_PHP_CONFIG),)
BIN_PHP_CONFIG=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_GPG),)
BIN_GPG=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_OPENSSL),)
BIN_OPENSSL=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_SSH),)
BIN_SSH=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_SSHKEYGEN),)
BIN_SSHKEYGEN=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_PATCH),)
BIN_PATCH=C:/cygwin/bin/false.exe
endif

ifeq ($(BIN_TEE),)
BIN_TEE=C:/cygwin/bin/tee.exe
endif

ifeq ($(BIN_BASENAME),)
BIN_BASENAME=C:/cygwin/bin/basename.exe
endif

ifeq ($(BIN_DIRNAME),)
BIN_DIRNAME=C:/cygwin/bin/dirname.exe
endif

ifeq ($(BIN_ICON),)
BIN_ICON=/usr/local/icon-9.4.3/bin/icon
endif

ifeq ($(BIN_ICONT),)
BIN_ICONT=/usr/local/icon-9.4.3/bin/icont
endif

ifeq ($(BIN_ICONX),)
BIN_ICONX=/usr/local/icon-9.4.3/bin/iconx
endif

ifeq ($(LIBDIR_ICON),)
LIBDIR_ICON=/usr/local/icon-9.4.3/lib
endif

ifeq ($(BIN_CPIF),)
BIN_CPIF=/usr/local/noweb-2.11b/cpif
endif

ifeq ($(BIN_NOWEB),)
BIN_NOWEB=/usr/local/noweb-2.11b/noweb
endif

ifeq ($(BIN_NOTANGLE),)
BIN_NOTANGLE=/usr/local/noweb-2.11b/notangle
endif

ifeq ($(BIN_XML2_CONFIG),)
BIN_XML2_CONFIG=/usr/bin/xml2-config
endif

ifeq ($(BIN_MKISOFS),)
BIN_MKISOFS=/usr/bin/mkisofs
endif

ifeq ($(BIN_IMPLANTISOMD5),)
BIN_IMPLANTISOMD5=/usr/lib/anaconda-runtime/implantisomd5
endif

ifeq ($(BIN_RSYNC),)
BIN_RSYNC=/usr/bin/rsync
endif

ifeq ($(BIN_CREATEREPO),)
BIN_CREATEREPO=/usr/bin/createrepo
endif

ifeq ($(BIN_HEAD),)
BIN_HEAD=/usr/bin/head
endif

ifeq ($(BIN_QEMU),)
BIN_QEMU=/usr/bin/qemu
endif

ifeq ($(BIN_QEMU_IMG),)
BIN_QEMU_IMG=/usr/bin/qemu-img
endif

ifeq ($(BIN_QEMU_SYSTEMX8664),)
BIN_QEMU_SYSTEMX8664=/usr/bin/qemu-system-x86_64
endif
