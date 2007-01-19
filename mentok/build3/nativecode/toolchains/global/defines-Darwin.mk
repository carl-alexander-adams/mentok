#
# Tool chain neutral 
#

ifeq ($(FLAGS_CC),)
FLAGS_CC=-D_GNU_SOURCE
endif
ifeq ($(FLAGS_CC_DBG),)
FLAGS_CC_DBG=
endif
ifeq ($(FLAGS_CC_OPT),)
FLAGS_CC_OPT=
endif
ifeq ($(FLAGS_CC_PROFILE),)
FLAGS_CC_PROFILE=
endif
ifeq ($(FLAGS_CC_COV),)
FLAGS_CC_COV=
endif
ifeq ($(FLAGS_CC_NOASSERT),)
FLAGS_CC_NOASSERT=
endif
ifeq ($(FLAGS_CC_REENT),)
FLAGS_CC_REENT=
endif


ifeq ($(FLAGS_CXX),)
FLAGS_CXX=-D_GNU_SOURCE
endif
ifeq ($(FLAGS_CXX_DBG),)
FLAGS_CXX_DBG=
endif
ifeq ($(FLAGS_CXX_OPT),)
FLAGS_CXX_OPT=
endif
ifeq ($(FLAGS_CXX_PROFILE),)
FLAGS_CXX_PROFILE=
endif
ifeq ($(FLAGS_CXX_COV),)
FLAGS_CXX_COV=
endif
ifeq ($(FLAGS_CXX_NOASSERT),)
FLAGS_CXX_NOASSERT=
endif
ifeq ($(FLAGS_CXX_REENT),)
FLAGS_CXX_REENT=
endif


ifeq ($(FLAGS_AS),)
FLAGS_AS=
endif
ifeq ($(FLAGS_AS_DBG),)
FLAGS_AS_DBG=
endif
ifeq ($(FLAGS_AS_OPT),)
FLAGS_AS_OPT=
endif
ifeq ($(FLAGS_AS_PROFILE),)
FLAGS_AS_PROFILE=
endif
ifeq ($(FLAGS_AS_COV),)
FLAGS_AS_COV=
endif


ifeq ($(FLAGS_LD_EXE),)
FLAGS_LD_EXE=
endif
ifeq ($(FLAGS_LD_EXE_OPT),)
FLAGS_LD_EXE_OPT=
endif
ifeq ($(FLAGS_LD_EXE_DBG),)
FLAGS_LD_EXE_DBG=
endif
ifeq ($(FLAGS_LD_EXE_PROFILE),)
FLAGS_LD_EXE_PROFILE=
endif
ifeq ($(FLAGS_LD_EXE_COV),)
FLAGS_LD_EXE_COV=
endif
ifeq ($(FLAGS_LD_EXE_LOADLIBS),)
FLAGS_LD_EXE_LOADLIBS=
endif
ifeq ($(FLAGS_LD_EXE_LOADLIBS_OPT),)
FLAGS_LD_EXE_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_LD_EXE_LOADLIBS_DBG),)
FLAGS_LD_EXE_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_LD_EXE_LOADLIBS_PROFILE),)
FLAGS_LD_EXE_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_LD_EXE_LOADLIBS_COV),)
FLAGS_LD_EXE_LOADLIBS_COV=
endif


ifeq ($(FLAGS_LD_SHLIB),)
FLAGS_LD_SHLIB=
endif
ifeq ($(FLAGS_LD_SHLIB_OPT),)
FLAGS_LD_SHLIB_OPT=
endif
ifeq ($(FLAGS_LD_SHLIB_DBG),)
FLAGS_LD_SHLIB_DBG=
endif
ifeq ($(FLAGS_LD_SHLIB_PROFILE),)
FLAGS_LD_SHLIB_PROFILE=
endif
ifeq ($(FLAGS_LD_SHLIB_COV),)
FLAGS_LD_SHLIB_COV=
endif
ifeq ($(FLAGS_LD_SHLIB_LOADLIBS),)
FLAGS_LD_SHLIB_LOADLIBS=
endif
ifeq ($(FLAGS_LD_SHLIB_LOADLIBS_OPT),)
FLAGS_LD_SHLIB_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_LD_SHLIB_LOADLIBS_DBG),)
FLAGS_LD_SHLIB_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_LD_SHLIB_LOADLIBS_PROFILE),)
FLAGS_LD_SHLIB_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_LD_SHLIB_LOADLIBS_COV),)
FLAGS_LD_SHLIB_LOADLIBS_COV=
endif


ifeq ($(FLAGS_LD_INCOBJ),)
FLAGS_LD_INCOBJ=
endif
ifeq ($(FLAGS_LD_INCOBJ_OPT),)
FLAGS_LD_INCOBJ_OPT=
endif
ifeq ($(FLAGS_LD_INCOBJ_DBG),)
FLAGS_LD_INCOBJ_DBG=
endif
ifeq ($(FLAGS_LD_INCOBJ_PROFILE),)
FLAGS_LD_INCOBJ_PROFILE=
endif
ifeq ($(FLAGS_LD_INCOBJ_COV),)
FLAGS_LD_INCOBJ_COV=
endif
ifeq ($(FLAGS_LD_INCOBJ_LOADLIBS),)
FLAGS_LD_INCOBJ_LOADLIBS=
endif
ifeq ($(FLAGS_LD_INCOBJ_LOADLIBS_OPT),)
FLAGS_LD_INCOBJ_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_LD_INCOBJ_LOADLIBS_DBG),)
FLAGS_LD_INCOBJ_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_LD_INCOBJ_LOADLIBS_PROFILE),)
FLAGS_LD_INCOBJ_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_LD_INCOBJ_LOADLIBS_COV),)
FLAGS_LD_INCOBJ_LOADLIBS_COV=
endif


ifeq ($(FLAGS_AR_LIB),)
FLAGS_AR_LIB=
endif
ifeq ($(FLAGS_AR_LIB_OPT),)
FLAGS_AR_LIB_OPT=
endif
ifeq ($(FLAGS_AR_LIB_DBG),)
FLAGS_AR_LIB_DBG=
endif
ifeq ($(FLAGS_AR_LIB_PROFILE),)
FLAGS_AR_LIB_PROFILE=
endif
ifeq ($(FLAGS_AR_LIB_COV),)
FLAGS_AR_LIB_COV=
endif
ifeq ($(FLAGS_AR_LIB_LOADLIBS),)
FLAGS_AR_LIB_LOADLIBS=
endif
ifeq ($(FLAGS_AR_LIB_LOADLIBS_OPT),)
FLAGS_AR_LIB_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_AR_LIB_LOADLIBS_DBG),)
FLAGS_AR_LIB_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_AR_LIB_LOADLIBS_PROFILE),)
FLAGS_AR_LIB_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_AR_LIB_LOADLIBS_COV),)
FLAGS_AR_LIB_LOADLIBS_COV=
endif



ifeq ($(FLAGS_STRIP_EXE),)
FLAGS_STRIP_EXE=
endif
ifeq ($(FLAGS_STRIP_SHLIB),)
FLAGS_STRIP_SHLIB=
endif
ifeq ($(FLAGS_STRIP_LIB),)
FLAGS_STRIP_LIB=
endif


