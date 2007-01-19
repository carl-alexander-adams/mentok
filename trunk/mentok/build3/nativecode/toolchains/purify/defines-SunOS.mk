#
# Purify & Gnu tool chain
#
ifeq ($(BIN_PURIFY_CC),)
BIN_PURIFY_CC=/usr/local/bin/gcc
endif
ifeq ($(BIN_PURIFY_CXX),)
BIN_PURIFY_CXX=/usr/local/bin/g++
endif
ifeq ($(BIN_PURIFY_AS),)
BIN_PURIFY_AS=/usr/local/bin/gcc
endif
ifeq ($(BIN_PURIFY_CPP),)
BIN_PURIFY_CPP=/usr/local/bin/gcc -E
endif
ifeq ($(BIN_PURIFY_LD),)
BIN_PURIFY_LD=/opt/rational/releases/PurifyPlusFamily.2002a.06.00/sun4_solaris2/bin/purify \
	-verbose \
	-cache-dir=./$(BS_ARCH_TARGET_DIR) \
	-exit-status=yes \
	-inuse-at-exit=yes \
	-leaks-at-exit=yes \
	-fds-inuse-at-exit=yes \
	/usr/local/bin/gcc
endif
ifeq ($(BIN_PURIFY_AR),)
BIN_PURIFY_AR=/usr/local/bin/ar
endif
# Don't strip purify builds
ifeq ($(BIN_PURIFY_STRIP),)
BIN_PURIFY_STRIP=$(BIN_TRUE)
endif




ifeq ($(FLAGS_PURIFY_CC),)
FLAGS_PURIFY_CC=-W \
	-Wall \
	-Wcast-qual \
	-Wcast-align \
	-Wpointer-arith \
	-Wsign-compare \
	-Winline \
	-Waggregate-return \
	-Wmissing-prototypes \
	-Wmissing-declarations \
	-Wunused
#	-v \
#	-ftime-report \
#	-fmem-report

endif
ifeq ($(FLAGS_PURIFY_CC_DEP),)
FLAGS_PURIFY_CC_DEP=-MM
endif
ifeq ($(FLAGS_PURIFY_CC_DBG),)
FLAGS_PURIFY_CC_DBG=-g3
endif
ifeq ($(FLAGS_PURIFY_CC_OPT),)
FLAGS_PURIFY_CC_OPT=-O3
endif
ifeq ($(FLAGS_PURIFY_CC_PROFILE),)
FLAGS_PURIFY_CC_PROFILE=-pg
endif
ifeq ($(FLAGS_PURIFY_CC_COV),)
FLAGS_PURIFY_CC_COV=-fprofile-arcs -fmem-report
endif
ifeq ($(FLAGS_PURIFY_CC_NOASSERT),)
FLAGS_PURIFY_CC_NOASSERT=-DNDEBUG
endif
ifeq ($(FLAGS_PURIFY_CC_REENT),)
FLAGS_PURIFY_CC_REENT=-D_REENTRANT
endif


ifeq ($(FLAGS_PURIFY_CXX),)
FLAGS_PURIFY_CXX=-W \
	-Wall \
	-Wcast-qual \
	-Wcast-align \
	-Wpointer-arith \
	-Wsign-compare \
	-Winline \
	-Waggregate-return \
	-Wmissing-prototypes \
	-Wunused
#	-v \
#	-ftime-report \
#	-fmem-report

endif
ifeq ($(FLAGS_PURIFY_CXX_DEP),)
FLAGS_PURIFY_CXX_DEP=-MM
endif
ifeq ($(FLAGS_PURIFY_CXX_DBG),)
FLAGS_PURIFY_CXX_DBG=-g3
endif
ifeq ($(FLAGS_PURIFY_CXX_OPT),)
FLAGS_PURIFY_CXX_OPT=-O3
endif
ifeq ($(FLAGS_PURIFY_CXX_PROFILE),)
FLAGS_PURIFY_CXX_PROFILE=-pg
endif
ifeq ($(FLAGS_PURIFY_CXX_COV),)
FLAGS_PURIFY_CXX_COV=-fprofile-arcs -fmem-report
endif
ifeq ($(FLAGS_PURIFY_CXX_NOASSERT),)
FLAGS_PURIFY_CXX_NOASSERT=-DNDEBUG
endif
ifeq ($(FLAGS_PURIFY_CXX_REENT),)
FLAGS_PURIFY_CXX_REENT=-D_REENTRANT
endif


ifeq ($(FLAGS_PURIFY_AS),)
FLAGS_PURIFY_AS=
endif
ifeq ($(FLAGS_PURIFY_AS_DEP),)
FLAGS_PURIFY_AS_DEP=-MM
endif
ifeq ($(FLAGS_PURIFY_AS_DBG),)
FLAGS_PURIFY_AS_DBG=-g3
endif
ifeq ($(FLAGS_PURIFY_AS_OPT),)
FLAGS_PURIFY_AS_OPT=-O3
endif
ifeq ($(FLAGS_PURIFY_AS_PROFILE),)
FLAGS_PURIFY_AS_PROFILE=
endif
ifeq ($(FLAGS_PURIFY_AS_COV),)
FLAGS_PURIFY_AS_COV=
endif



ifeq ($(FLAGS_PURIFY_LD_EXE),)
FLAGS_PURIFY_LD_EXE=
endif
ifeq ($(FLAGS_PURIFY_LD_EXE_OPT),)
FLAGS_PURIFY_LD_EXE_OPT=
endif
ifeq ($(FLAGS_PURIFY_LD_EXE_DBG),)
FLAGS_PURIFY_LD_EXE_DBG=
endif
ifeq ($(FLAGS_PURIFY_LD_EXE_PROFILE),)
FLAGS_PURIFY_LD_EXE_PROFILE=-pg -ldl
endif
ifeq ($(FLAGS_PURIFY_LD_EXE_COV),)
FLAGS_PURIFY_LD_EXE_COV=
endif
ifeq ($(FLAGS_PURIFY_LD_EXE_LOADLIBS),)
FLAGS_PURIFY_LD_EXE_LOADLIBS=
endif
ifeq ($(FLAGS_PURIFY_LD_EXE_LOADLIBS_OPT),)
FLAGS_PURIFY_LD_EXE_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_PURIFY_LD_EXE_LOADLIBS_DBG),)
FLAGS_PURIFY_LD_EXE_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_PURIFY_LD_EXE_LOADLIBS_PROFILE),)
FLAGS_PURIFY_LD_EXE_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_PURIFY_LD_EXE_LOADLIBS_COV),)
FLAGS_PURIFY_LD_EXE_LOADLIBS_COV=
endif


ifeq ($(FLAGS_PURIFY_LD_SHLIB),)
FLAGS_PURIFY_LD_SHLIB=-fPIC -G -dy
endif
ifeq ($(FLAGS_PURIFY_LD_SHLIB_OPT),)
FLAGS_PURIFY_LD_SHLIB_OPT=
endif
ifeq ($(FLAGS_PURIFY_LD_SHLIB_DBG),)
FLAGS_PURIFY_LD_SHLIB_DBG=
endif
ifeq ($(FLAGS_PURIFY_LD_SHLIB_PROFILE),)
FLAGS_PURIFY_LD_SHLIB_PROFILE=
endif
ifeq ($(FLAGS_PURIFY_LD_SHLIB_COV),)
FLAGS_PURIFY_LD_SHLIB_COV=
endif
ifeq ($(FLAGS_PURIFY_LD_SHLIB_LOADLIBS),)
FLAGS_PURIFY_LD_SHLIB_LOADLIBS=
endif
ifeq ($(FLAGS_PURIFY_LD_SHLIB_LOADLIBS_OPT),)
FLAGS_PURIFY_LD_SHLIB_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_PURIFY_LD_SHLIB_LOADLIBS_DBG),)
FLAGS_PURIFY_LD_SHLIB_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_PURIFY_LD_SHLIB_LOADLIBS_PROFILE),)
FLAGS_PURIFY_LD_SHLIB_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_PURIFY_LD_SHLIB_LOADLIBS_COV),)
FLAGS_PURIFY_LD_SHLIB_LOADLIBS_COV=
endif


ifeq ($(FLAGS_PURIFY_LD_INCOBJ),)
FLAGS_PURIFY_LD_INCOBJ=-Wl,-r
endif
ifeq ($(FLAGS_PURIFY_LD_INCOBJ_OPT),)
FLAGS_PURIFY_LD_INCOBJ_OPT=
endif
ifeq ($(FLAGS_PURIFY_LD_INCOBJ_DBG),)
FLAGS_PURIFY_LD_INCOBJ_DBG=
endif
ifeq ($(FLAGS_PURIFY_LD_INCOBJ_PROFILE),)
FLAGS_PURIFY_LD_INCOBJ_PROFILE=
endif
ifeq ($(FLAGS_PURIFY_LD_INCOBJ_COV),)
FLAGS_PURIFY_LD_INCOBJ_COV=
endif
ifeq ($(FLAGS_PURIFY_LD_INCOBJ_LOADLIBS),)
FLAGS_PURIFY_LD_INCOBJ_LOADLIBS=
endif
ifeq ($(FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_OPT),)
FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_DBG),)
FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_PROFILE),)
FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_COV),)
FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_COV=
endif

ifeq ($(FLAGS_PURIFY_AR_LIB),)
FLAGS_PURIFY_AR_LIB=rc
endif
ifeq ($(FLAGS_PURIFY_AR_LIB_OPT),)
FLAGS_PURIFY_AR_LIB_OPT=
endif
ifeq ($(FLAGS_PURIFY_AR_LIB_DBG),)
FLAGS_PURIFY_AR_LIB_DBG=
endif
ifeq ($(FLAGS_PURIFY_AR_LIB_PROFILE),)
FLAGS_PURIFY_AR_LIB_PROFILE=
endif
ifeq ($(FLAGS_PURIFY_AR_LIB_COV),)
FLAGS_PURIFY_AR_LIB_COV=
endif
ifeq ($(FLAGS_PURIFY_AR_LIB_LOADLIBS),)
FLAGS_PURIFY_AR_LIB_LOADLIBS=
endif
ifeq ($(FLAGS_PURIFY_AR_LIB_LOADLIBS_OPT),)
FLAGS_PURIFY_AR_LIB_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_PURIFY_AR_LIB_LOADLIBS_DBG),)
FLAGS_PURIFY_AR_LIB_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_PURIFY_AR_LIB_LOADLIBS_PROFILE),)
FLAGS_PURIFY_AR_LIB_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_PURIFY_AR_LIB_LOADLIBS_COV),)
FLAGS_PURIFY_AR_LIB_LOADLIBS_COV=
endif


# Don't strip purify builds
ifeq ($(FLAGS_PURIFY_STRIP_EXE),)
FLAGS_PURIFY_STRIP_EXE=
endif
ifeq ($(FLAGS_PURIFY_STRIP_SHLIB),)
FLAGS_PURIFY_STRIP_SHLIB=
endif
ifeq ($(FLAGS_PURIFY_STRIP_LIB),)
FLAGS_PURIFY_STRIP_LIB=
endif


