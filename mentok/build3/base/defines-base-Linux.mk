ifeq ($(BIN_CP),)
BIN_CP=/bin/cp
endif

ifeq ($(BIN_MV),)
BIN_MV=/bin/mv
endif

ifeq ($(BIN_TAR),)
BIN_TAR=/bin/tar
endif

ifeq ($(BIN_LN),)
BIN_LN=/bin/ln
endif

ifeq ($(BIN_RM),)
BIN_RM=/bin/rm
endif

ifeq ($(BIN_LS),)
BIN_LS=/bin/ls
endif

ifeq ($(BIN_TOUCH),)
BIN_TOUCH=/bin/touch
endif

ifeq ($(BIN_MKDIR),)
BIN_MKDIR=/bin/mkdir
endif

ifeq ($(BIN_CAT),)
BIN_CAT=/bin/cat
endif

ifeq ($(BIN_SED),)
BIN_SED=/bin/sed
endif

ifeq ($(BIN_AWK),)
BIN_AWK=/usr/bin/awk
endif

ifeq ($(BIN_GREP),)
BIN_GREP=/bin/egrep
endif

ifeq ($(BIN_GZIP),)
BIN_GZIP=/usr/bin/gzip
endif

ifeq ($(BIN_BZIP2),)
BIN_BZIP2=/usr/bin/bzip2
endif

ifeq ($(BIN_ZIP),)
BIN_ZIP=/usr/bin/zip
endif

ifeq ($(BIN_UNZIP),)
BIN_UNZIP=/usr/bin/unzip
endif

ifeq ($(BIN_CHOWN),)
BIN_CHOWN=/bin/chown
endif

ifeq ($(BIN_CHMOD),)
BIN_CHMOD=/bin/chmod
endif

ifeq ($(BIN_DATE),)
BIN_DATE=/bin/date
endif

ifeq ($(BIN_SLEEP),)
BIN_SLEEP=/bin/sleep
endif

ifeq ($(BIN_TRUE),)
BIN_TRUE=/bin/true
endif

ifeq ($(BIN_FALSE),)
BIN_FALSE=/bin/false
endif

ifeq ($(BIN_LYNX),)
BIN_LYNX=/usr/bin/lynx
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
BIN_PERL=/usr/bin/perl
endif

ifeq ($(BIN_PYTHON),)
BIN_PYTHON=/usr/bin/python
endif

ifeq ($(BIN_BSCATMAN),)
BIN_BSCATMAN=$(BIN_LINKS) -dump
endif

ifeq ($(BIN_SH),)
BIN_SH=/bin/sh
endif

ifeq ($(BIN_PRINTF),)
BIN_PRINTF=/usr/bin/printf
endif

ifeq ($(BIN_ECHO),)
BIN_ECHO=echo
endif

ifeq ($(BIN_WHOAMI),)
BIN_WHOAMI=/usr/bin/whoami
endif

ifeq ($(BIN_TEST),)
BIN_TEST=/usr/bin/test
endif

ifeq ($(BIN_EXPR),)
BIN_EXPR=/bin/expr
endif

ifeq ($(BIN_DU),)
BIN_DU=/usr/bin/du
endif

ifeq ($(BIN_TR),)
BIN_TR=/usr/bin/tr
endif

ifeq ($(BIN_TAIL),)
BIN_TAIL=/usr/bin/tail
endif

ifeq ($(BIN_SYSCTL),)
BIN_SYSCTL=/bin/false
endif

ifeq ($(BIN_EPM),)
BIN_EPM=/usr/local/epm-4.1/bin/epm
endif

ifeq ($(BIN_MKEPMLIST),)
BIN_MKEPMLIST=/usr/local/epm-4.1/bin/mkepmlist
endif

ifeq ($(BIN_RPM),)
BIN_RPM=/bin/rpm
endif

ifeq ($(BIN_RPM2CPIO),)
BIN_RPM2CPIO=/usr/bin/rpm2cpio
endif

ifeq ($(BIN_CPIO),)
BIN_PIO=/bin/cpio
endif

ifeq ($(BIN_CURL),)
BIN_CURL=/usr/bin/curl
endif

ifeq ($(BIN_PHP),)
BIN_PHP=/usr/bin/php
endif

ifeq ($(BIN_PHP_CONFIG),)
BIN_PHP_CONFIG=/usr/bin/php-config
endif

ifeq ($(BIN_GPG),)
BIN_GPG=/usr/bin/gpg
endif

ifeq ($(BIN_OPENSSL),)
BIN_OPENSSL=/usr/bin/openssl
endif

ifeq ($(BIN_SSH),)
BIN_SSH=/usr/bin/ssh
endif

ifeq ($(BIN_SSHKEYGEN),)
BIN_SSHKEYGEN=/usr/bin/ssh-keygen
endif

ifeq ($(BIN_PATCH),)
BIN_PATCH=/usr/bin/patch
endif

ifeq ($(BIN_TEE),)
BIN_TEE=/usr/bin/tee
endif

ifeq ($(BIN_BASENAME),)
BIN_BASENAME=/bin/basename
endif

ifeq ($(BIN_DIRNAME),)
BIN_DIRNAME=/usr/bin/dirname
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
