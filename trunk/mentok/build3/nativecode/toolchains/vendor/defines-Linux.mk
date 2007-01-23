#
# Vendor tool chain
#
ifeq ($(BIN_VENDOR_CC),)
BIN_VENDOR_CC=/usr/bin/gcc
BIN_VENDOR_CC_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_VENDOR_CXX),)
BIN_VENDOR_CXX=/usr/bin/g++
BIN_VENDOR_CXX_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_VENDOR_AS),)
BIN_VENDOR_AS=/usr/bin/gcc
BIN_VENDOR_AS_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_VENDOR_CPP),)
BIN_VENDOR_CPP=/usr/bin/gcc -E
BIN_VENDOR_CPP_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_VENDOR_LD),)
BIN_VENDOR_LD=/usr/bin/ld
BIN_VENDOR_LD_OUTPUTFLAG_EXE=-o 
BIN_VENDOR_LD_OUTPUTFLAG_SHLIB=-o 
BIN_VENDOR_LD_OUTPUTFLAG_INCOBJ=-o 
endif
ifeq ($(BIN_VENDOR_AR),)
BIN_VENDOR_AR=/usr/bin/ar
BIN_VENDOR_AR_OUTPUTFLAG=
endif
ifeq ($(BIN_VENDOR_STRIP),)
BIN_VENDOR_STRIP=/usr/bin/strip
endif





ifeq ($(EXTENSION_VENDOR_OBJ),)
EXTENSION_VENDOR_OBJ=.o
endif
ifeq ($(EXTENSION_VENDOR_EXE),)
EXTENSION_VENDOR_EXE=
endif
ifeq ($(EXTENSION_VENDOR_LIB),)
EXTENSION_VENDOR_LIB=.a
endif
ifeq ($(EXTENSION_VENDOR_SHLIB),)
EXTENSION_VENDOR_SHLIB=.so
endif



ifeq ($(FLAGS_VENDOR_CC),)
FLAGS_VENDOR_CC=-W \
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
ifeq ($(FLAGS_VENDOR_CC_DEP),)
FLAGS_VENDOR_CC_DEP=-MM -w
endif
ifeq ($(FLAGS_VENDOR_CC_DBG),)
FLAGS_VENDOR_CC_DBG=-g
endif
ifeq ($(FLAGS_VENDOR_CC_OPT),)
FLAGS_VENDOR_CC_OPT=-O
endif
ifeq ($(FLAGS_VENDOR_CC_PROFILE),)
FLAGS_VENDOR_CC_PROFILE=--pg
endif
ifeq ($(FLAGS_VENDOR_CC_COV),)
FLAGS_VENDOR_CC_COV=-fprofile-arcs -ftest-coverage
endif
ifeq ($(FLAGS_VENDOR_CC_NOASSERT),)
FLAGS_VENDOR_CC_NOASSERT=-DNDEBUG
endif
ifeq ($(FLAGS_VENDOR_CC_REENT),)
FLAGS_VENDOR_CC_REENT=-D_REENTRANT
endif

ifeq ($(FLAGS_VENDOR_CXX),)
FLAGS_VENDOR_CXX=-W \
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
ifeq ($(FLAGS_VENDOR_CXX_DEP),)
FLAGS_VENDOR_CXX_DEP=-MM -w
endif
ifeq ($(FLAGS_VENDOR_CXX_DBG),)
FLAGS_VENDOR_CXX_DBG=-g
endif
ifeq ($(FLAGS_VENDOR_CXX_OPT),)
FLAGS_VENDOR_CXX_OPT=-O
endif
ifeq ($(FLAGS_VENDOR_CXX_PROFILE),)
FLAGS_VENDOR_CXX_PROFILE=-pg
endif
ifeq ($(FLAGS_VENDOR_CXX_COV),)
FLAGS_VENDOR_CXX_COV=-fprofile-arcs -ftest-coverage
endif
ifeq ($(FLAGS_VENDOR_CXX_NOASSERT),)
FLAGS_VENDOR_CXX_NOASSERT=-DNDEBUG
endif
ifeq ($(FLAGS_VENDOR_CXX_REENT),)
FLAGS_VENDOR_CXX_REENT=-D_REENTRANT
endif


ifeq ($(FLAGS_VENDOR_AS),)
FLAGS_VENDOR_AS=
endif
ifeq ($(FLAGS_VENDOR_AS_DEP),)
FLAGS_VENDOR_AS_DEP=-MM -w
endif
ifeq ($(FLAGS_VENDOR_AS_DBG),)
FLAGS_VENDOR_AS_DBG=-g3 -Wa,--gstabs
endif
ifeq ($(FLAGS_VENDOR_AS_OPT),)
FLAGS_VENDOR_AS_OPT=-O3
endif
ifeq ($(FLAGS_VENDOR_AS_PROFILE),)
FLAGS_VENDOR_AS_PROFILE=
endif
ifeq ($(FLAGS_VENDOR_AS_COV),)
FLAGS_VENDOR_AS_COV=
endif


ifeq ($(FLAGS_VENDOR_LD_EXE),)
FLAGS_VENDOR_LD_EXE=
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_OPT),)
FLAGS_VENDOR_LD_EXE_OPT=
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_DBG),)
FLAGS_VENDOR_LD_EXE_DBG=
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_PROFILE),)
FLAGS_VENDOR_LD_EXE_PROFILE=-pg -ldl
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_COV),)
FLAGS_VENDOR_LD_EXE_COV=
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_LOADLIBS),)
FLAGS_VENDOR_LD_EXE_LOADLIBS=
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_LOADLIBS_OPT),)
FLAGS_VENDOR_LD_EXE_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_LOADLIBS_DBG),)
FLAGS_VENDOR_LD_EXE_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_LOADLIBS_PROFILE),)
FLAGS_VENDOR_LD_EXE_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_LOADLIBS_COV),)
FLAGS_VENDOR_LD_EXE_LOADLIBS_COV=
endif


ifeq ($(FLAGS_VENDOR_LD_SHLIB),)
FLAGS_VENDOR_LD_SHLIB=-shared
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_OPT),)
FLAGS_VENDOR_LD_SHLIB_OPT=
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_DBG),)
FLAGS_VENDOR_LD_SHLIB_DBG=
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_PROFILE),)
FLAGS_VENDOR_LD_SHLIB_PROFILE=
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_COV),)
FLAGS_VENDOR_LD_SHLIB_COV=
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_LOADLIBS),)
FLAGS_VENDOR_LD_SHLIB_LOADLIBS=
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_OPT),)
FLAGS_VENDOR_LD_SHLIB_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_DBG),)
FLAGS_VENDOR_LD_SHLIB_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_PROFILE),)
FLAGS_VENDOR_LD_SHLIB_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_COV),)
FLAGS_VENDOR_LD_SHLIB_LOADLIBS_COV=
endif


ifeq ($(FLAGS_VENDOR_LD_INCOBJ),)
FLAGS_VENDOR_LD_INCOBJ=-r
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_OPT),)
FLAGS_VENDOR_LD_INCOBJ_OPT=
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_DBG),)
FLAGS_VENDOR_LD_INCOBJ_DBG=
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_PROFILE),)
FLAGS_VENDOR_LD_INCOBJ_PROFILE=-pg -ldl
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_COV),)
FLAGS_VENDOR_LD_INCOBJ_COV=
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS),)
FLAGS_VENDOR_LD_INCOBJ_LOADLIBS=
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_OPT),)
FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_DBG),)
FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_PROFILE),)
FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_COV),)
FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_COV=
endif

ifeq ($(FLAGS_VENDOR_AR_LIB),)
FLAGS_VENDOR_AR_LIB=rc
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_OPT),)
FLAGS_VENDOR_AR_LIB_OPT=
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_DBG),)
FLAGS_VENDOR_AR_LIB_DBG=
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_PROFILE),)
FLAGS_VENDOR_AR_LIB_PROFILE=
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_COV),)
FLAGS_VENDOR_AR_LIB_COV=
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_LOADLIBS),)
FLAGS_VENDOR_AR_LIB_LOADLIBS=
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_LOADLIBS_OPT),)
FLAGS_VENDOR_AR_LIB_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_LOADLIBS_DBG),)
FLAGS_VENDOR_AR_LIB_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_LOADLIBS_PROFILE),)
FLAGS_VENDOR_AR_LIB_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_LOADLIBS_COV),)
FLAGS_VENDOR_AR_LIB_LOADLIBS_COV=
endif


ifeq ($(FLAGS_VENDOR_STRIP_EXE),)
FLAGS_VENDOR_STRIP_EXE= --strip-unneeded
endif
ifeq ($(FLAGS_VENDOR_STRIP_SHLIB),)
FLAGS_VENDOR_STRIP_SHLIB= --discard-all
endif
ifeq ($(FLAGS_VENDOR_STRIP_LIB),)
FLAGS_VENDOR_STRIP_LIB= --discard-all
endif

