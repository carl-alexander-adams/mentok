#
# Gnu tool chain
#
ifeq ($(BIN_GNU_CC),)
BIN_GNU_CC=/usr/bin/gcc
endif
ifeq ($(BIN_GNU_CXX),)
BIN_GNU_CXX=/usr/bin/g++
endif
ifeq ($(BIN_GNU_AS),)
BIN_GNU_AS=/usr/bin/gcc
endif
ifeq ($(BIN_GNU_CPP),)
BIN_GNU_CPP=/usr/bin/gcc -E
endif
ifeq ($(BIN_GNU_LD),)
BIN_GNU_LD=/usr/bin/gcc
endif
ifeq ($(BIN_GNU_AR),)
BIN_GNU_AR=/usr/bin/ar
endif
ifeq ($(BIN_GNU_STRIP),)
BIN_GNU_STRIP=/usr/bin/strip
endif


ifeq ($(FLAGS_GNU_CC),)
FLAGS_GNU_CC=-W \
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
ifeq ($(FLAGS_GNU_CC_DEP),)
FLAGS_GNU_CC_DEP=-MM
endif
ifeq ($(FLAGS_GNU_CC_DBG),)
FLAGS_GNU_CC_DBG=-g3
endif
ifeq ($(FLAGS_GNU_CC_OPT),)
FLAGS_GNU_CC_OPT=-O3
endif
ifeq ($(FLAGS_GNU_CC_PROFILE),)
FLAGS_GNU_CC_PROFILE=-pg
endif
ifeq ($(FLAGS_GNU_CC_COV),)
FLAGS_GNU_CC_COV=-fprofile-arcs -ftest-coverage
endif
ifeq ($(FLAGS_GNU_CC_NOASSERT),)
FLAGS_GNU_CC_NOASSERT=-DNDEBUG
endif
ifeq ($(FLAGS_GNU_CC_REENT),)
FLAGS_GNU_CC_REENT=-D_REENTRANT
endif

ifeq ($(FLAGS_GNU_CXX),)
FLAGS_GNU_CXX=-W \
	-Wall \
	-Wcast-qual \
	-Wcast-align \
	-Wpointer-arith \
	-Wsign-compare \
	-Winline \
	-Wmissing-prototypes \
	-Wunused
#	-v \
#	-ftime-report \
#	-fmem-report

endif
ifeq ($(FLAGS_GNU_CXX_DEP),)
FLAGS_GNU_CXX_DEP=-MM
endif
ifeq ($(FLAGS_GNU_CXX_DBG),)
FLAGS_GNU_CXX_DBG=-g3
endif
ifeq ($(FLAGS_GNU_CXX_OPT),)
FLAGS_GNU_CXX_OPT=-O3
endif
ifeq ($(FLAGS_GNU_CXX_PROFILE),)
FLAGS_GNU_CXX_PROFILE=-pg
endif
ifeq ($(FLAGS_GNU_CXX_COV),)
FLAGS_GNU_CXX_COV=-fprofile-arcs -ftest-coverage
endif
ifeq ($(FLAGS_GNU_CXX_NOASSERT),)
FLAGS_GNU_CXX_NOASSERT=-DNDEBUG
endif
ifeq ($(FLAGS_GNU_CXX_REENT),)
FLAGS_GNU_CXX_REENT=-D_REENTRANT
endif

ifeq ($(FLAGS_GNU_AS),)
FLAGS_GNU_AS=
endif
ifeq ($(FLAGS_GNU_AS_DEP),)
FLAGS_GNU_AS_DEP=-MM
endif
ifeq ($(FLAGS_GNU_AS_DBG),)
FLAGS_GNU_AS_DBG=-g3 -Wa,--gstabs
endif
ifeq ($(FLAGS_GNU_AS_OPT),)
FLAGS_GNU_AS_OPT=-O3
endif
ifeq ($(FLAGS_GNU_AS_PROFILE),)
FLAGS_GNU_AS_PROFILE=
endif
ifeq ($(FLAGS_GNU_AS_COV),)
FLAGS_GNU_AS_COV=
endif


ifeq ($(FLAGS_GNU_LD_EXE),)
FLAGS_GNU_LD_EXE=
endif
ifeq ($(FLAGS_GNU_LD_EXE_OPT),)
FLAGS_GNU_LD_EXE_OPT=
endif
ifeq ($(FLAGS_GNU_LD_EXE_DBG),)
FLAGS_GNU_LD_EXE_DBG=
endif
ifeq ($(FLAGS_GNU_LD_EXE_PROFILE),)
FLAGS_GNU_LD_EXE_PROFILE=-pg -ldl
endif
ifeq ($(FLAGS_GNU_LD_EXE_COV),)
FLAGS_GNU_LD_EXE_COV=
endif

ifeq ($(FLAGS_GNU_LD_EXE_LOADLIBS),)
FLAGS_GNU_LD_EXE_LOADLIBS=
endif
ifeq ($(FLAGS_GNU_LD_EXE_LOADLIBS_OPT),)
FLAGS_GNU_LD_EXE_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_GNU_LD_EXE_LOADLIBS_DBG),)
FLAGS_GNU_LD_EXE_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_GNU_LD_EXE_LOADLIBS_PROFILE),)
FLAGS_GNU_LD_EXE_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_GNU_LD_EXE_LOADLIBS_COV),)
FLAGS_GNU_LD_EXE_LOADLIBS_PROFILE=
endif

ifeq ($(FLAGS_GNU_LD_SHLIB),)
FLAGS_GNU_LD_SHLIB=-shared
endif
ifeq ($(FLAGS_GNU_LD_SHLIB_OPT),)
FLAGS_GNU_LD_SHLIB_OPT=
endif
ifeq ($(FLAGS_GNU_LD_SHLIB_DBG),)
FLAGS_GNU_LD_SHLIB_DBG=
endif
ifeq ($(FLAGS_GNU_LD_SHLIB_PROFILE),)
FLAGS_GNU_LD_SHLIB_PROFILE=
endif
ifeq ($(FLAGS_GNU_LD_SHLIB_COV),)
FLAGS_GNU_LD_SHLIB_COV=
endif

ifeq ($(FLAGS_GNU_LD_SHLIB_LOADLIBS),)
FLAGS_GNU_LD_SHLIB_LOADLIBS=
endif
ifeq ($(FLAGS_GNU_LD_SHLIB_LOADLIBS_OPT),)
FLAGS_GNU_LD_SHLIB_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_GNU_LD_SHLIB_LOADLIBS_DBG),)
FLAGS_GNU_LD_SHLIB_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_GNU_LD_SHLIB_LOADLIBS_PROFILE),)
FLAGS_GNU_LD_SHLIB_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_GNU_LD_SHLIB_LOADLIBS_COV),)
FLAGS_GNU_LD_SHLIB_LOADLIBS_COV=
endif


ifeq ($(FLAGS_GNU_LD_INCOBJ),)
FLAGS_GNU_LD_INCOBJ=-Wl,-r
endif
ifeq ($(FLAGS_GNU_LD_INCOBJ_OPT),)
FLAGS_GNU_LD_INCOBJ_OPT=
endif
ifeq ($(FLAGS_GNU_LD_INCOBJ_DBG),)
FLAGS_GNU_LD_INCOBJ_DBG=
endif
ifeq ($(FLAGS_GNU_LD_INCOBJ_PROFILE),)
FLAGS_GNU_LD_INCOBJ_PROFILE=
endif
ifeq ($(FLAGS_GNU_LD_INCOBJ_COV),)
FLAGS_GNU_LD_INCOBJ_COV=
endif
ifeq ($(FLAGS_GNU_LD_INCOBJ_LOADLIBS),)
FLAGS_GNU_LD_INCOBJ_LOADLIBS=
endif
ifeq ($(FLAGS_GNU_LD_INCOBJ_LOADLIBS_OPT),)
FLAGS_GNU_LD_INCOBJ_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_GNU_LD_INCOBJ_LOADLIBS_DBG),)
FLAGS_GNU_LD_INCOBJ_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_GNU_LD_INCOBJ_LOADLIBS_PROFILE),)
FLAGS_GNU_LD_INCOBJ_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_GNU_LD_INCOBJ_LOADLIBS_COV),)
FLAGS_GNU_LD_INCOBJ_LOADLIBS_COV=
endif

ifeq ($(FLAGS_GNU_AR_LIB),)
FLAGS_GNU_AR_LIB=rc
endif
ifeq ($(FLAGS_GNU_AR_LIB_OPT),)
FLAGS_GNU_AR_LIB_OPT=
endif
ifeq ($(FLAGS_GNU_AR_LIB_DBG),)
FLAGS_GNU_AR_LIB_DBG=
endif
ifeq ($(FLAGS_GNU_AR_LIB_PROFILE),)
FLAGS_GNU_AR_LIB_PROFILE=
endif
ifeq ($(FLAGS_GNU_AR_LIB_COV),)
FLAGS_GNU_AR_LIB_COV=
endif
ifeq ($(FLAGS_GNU_AR_LIB_LOADLIBS),)
FLAGS_GNU_AR_LIB_LOADLIBS=
endif
ifeq ($(FLAGS_GNU_AR_LIB_LOADLIBS_OPT),)
FLAGS_GNU_AR_LIB_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_GNU_AR_LIB_LOADLIBS_DBG),)
FLAGS_GNU_AR_LIB_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_GNU_AR_LIB_LOADLIBS_PROFILE),)
FLAGS_GNU_AR_LIB_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_GNU_AR_LIB_LOADLIBS_COV),)
FLAGS_GNU_AR_LIB_LOADLIBS_COV=
endif

# Since we couldn't get the GNU version of strip to compile correctly
# on the mac we're using the vendor version.
ifeq ($(FLAGS_GNU_STRIP_EXE),)
FLAGS_GNU_STRIP_EXE= $(FLAGS_VENDOR_STRIP_EXE)
endif
ifeq ($(FLAGS_GNU_STRIP_SHLIB),)
FLAGS_GNU_STRIP_SHLIB= $(FLAGS_VENDOR_STRIP_SHLIB)
endif
ifeq ($(FLAGS_GNU_STRIP_LIB),)
FLAGS_GNU_STRIP_LIB= $(FLAGS_VENDOR_STRIP_SHLIB)
endif



