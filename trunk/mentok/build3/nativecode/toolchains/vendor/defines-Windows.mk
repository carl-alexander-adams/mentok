
#
# Vendor tool chain - Visual Studio 6 and updated MS platform SDK
# with the following configuration:
# 
#   MSVC install dir: C:/Program Files/Microsoft Visual Studio
#   Platform SDK installed in C:\Program Files\Microsoft SDK
#

ifeq ($(BIN_VENDOR_CC),)
BIN_VENDOR_CC="C:/Program Files/Microsoft Visual Studio/VC98/bin/cl.exe" -nologo
BIN_VENDOR_CC_OUTPUTFLAG=-Fo
endif
ifeq ($(BIN_VENDOR_CXX),)
BIN_VENDOR_CXX="C:/Program Files/Microsoft Visual Studio/VC98/bin/cl.exe" -nologo
BIN_VENDOR_CXX_OUTPUTFLAG=-Fo
endif
ifeq ($(BIN_VENDOR_AS),)
BIN_VENDOR_AS="C:/Program Files/Microsoft Visual Studio/VC98/bin/cl.exe" -nologo
BIN_VENDOR_AS_OUTPUTFLAG=-Fo
endif
ifeq ($(BIN_VENDOR_CPP),)
BIN_VENDOR_CPP="C:/Program Files/Microsoft Visual Studio/VC98/bin/cl.exe" -nologo -E
BIN_VENDOR_CPP_OUTPUTFLAG=-Fo
endif
ifeq ($(BIN_VENDOR_LD),)
BIN_VENDOR_LD="C:/Program Files/Microsoft Visual Studio/VC98/bin/cl.exe" -nologo
BIN_VENDOR_LD_OUTPUTFLAG_EXE=-Fe
BIN_VENDOR_LD_OUTPUTFLAG_SHLIB=-Fe
BIN_VENDOR_LD_OUTPUTFLAG_INCOBJ=--incremental-objects-not-supported--
endif
ifeq ($(BIN_VENDOR_AR),)
BIN_VENDOR_AR="C:/Program Files/Microsoft Visual Studio/VC98/bin/lib.exe"
BIN_VENDOR_AR_OUTPUTFLAG=/OUT:
endif
ifeq ($(BIN_VENDOR_STRIP),)
# While strip is not supported, this is /bin/true to keep
# the build running.
BIN_VENDOR_STRIP=$(BIN_TRUE) --strip-not-supported--
endif



# /Fo"Debug/" /Fd"Debug/"
_FLAGS_VC6_COMPILE_COMMON= \
	-W3 \
	-GX -GZ \
	-DWIN32 \
	-DMBCS \
	-D_MBCS \
	-D_R_LARGEFILE \
	-D_WIN32_DCOM \
	-D_CONSOLE \
	-D_NO_DLOPEN_ \
	-I"C:/Program Files/Microsoft SDK/include"

#_FLAGS_VC6_LOADLIBS_COMMON= \
#	-link /libpath:"C:/Program Files/Microsoft SDK/lib"

ifeq ($(FLAGS_VENDOR_CC),)
FLAGS_VENDOR_CC=$(_FLAGS_VC6_COMPILE_COMMON) -TC
endif
ifeq ($(FLAGS_VENDOR_CC_DEP),)
# MS compiler cannot generate makefile style depends lists for us.
FLAGS_VENDOR_CC_DEP=
endif
ifeq ($(FLAGS_VENDOR_CC_DBG),)
FLAGS_VENDOR_CC_DBG=-ZI -Od  -D_DEBUG -DDEBUG
endif
ifeq ($(FLAGS_VENDOR_CC_OPT),)
FLAGS_VENDOR_CC_OPT=-Od
# FLAGS_VENDOR_CC_OPT=-O2
endif
ifeq ($(FLAGS_VENDOR_CC_PROFILE),)
FLAGS_VENDOR_CC_PROFILE=--profile-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_CC_COV),)
FLAGS_VENDOR_CC_COV=--coverage-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_CC_NOASSERT),)
FLAGS_VENDOR_CC_NOASSERT=-DNDEBUG
endif
ifeq ($(FLAGS_VENDOR_CC_REENT),)
FLAGS_VENDOR_CC_REENT=-D_REENTRANT
endif

ifeq ($(FLAGS_VENDOR_CXX),)
FLAGS_VENDOR_CXX=$(_FLAGS_VC6_COMPILE_COMMON) -TP
endif
ifeq ($(FLAGS_VENDOR_CXX_DEP),)
# MS compiler cannot generate makefile style depends lists for us.
FLAGS_VENDOR_CXX_DEP=
endif
ifeq ($(FLAGS_VENDOR_CXX_DBG),)
FLAGS_VENDOR_CXX_DBG=-ZI -Od  -D_DEBUG -DDEBUG
endif
ifeq ($(FLAGS_VENDOR_CXX_OPT),)
FLAGS_VENDOR_CXX_OPT=-Od
# FLAGS_VENDOR_CXX_OPT=-O2
endif
ifeq ($(FLAGS_VENDOR_CXX_PROFILE),)
FLAGS_VENDOR_CXX_PROFILE=--profile-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_CXX_COV),)
FLAGS_VENDOR_CXX_COV=--coverage-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_CXX_NOASSERT),)
FLAGS_VENDOR_CXX_NOASSERT=-DNDEBUG
endif
ifeq ($(FLAGS_VENDOR_CXX_REENT),)
FLAGS_VENDOR_CXX_REENT=-D_REENTRANT
endif


ifeq ($(FLAGS_VENDOR_AS),)
FLAGS_VENDOR_AS=$(_FLAGS_VC6_COMPILE_COMMON)
endif
ifeq ($(FLAGS_VENDOR_AS_DEP),)
# MS compiler cannot generate makefile style depends lists for us.
FLAGS_VENDOR_AS_DEP=
endif
ifeq ($(FLAGS_VENDOR_AS_DBG),)
FLAGS_VENDOR_AS_DBG=-ZI -Od  -D_DEBUG -DDEBUG
endif
ifeq ($(FLAGS_VENDOR_AS_OPT),)
FLAGS_VENDOR_AS_OPT=-Od
# FLAGS_VENDOR_AS_OPT=-O2
endif
ifeq ($(FLAGS_VENDOR_AS_PROFILE),)
FLAGS_VENDOR_AS_PROFILE=--profile-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_AS_COV),)
FLAGS_VENDOR_AS_COV=--coverage-build-not-supported--
endif


ifeq ($(FLAGS_VENDOR_LD_EXE),)
FLAGS_VENDOR_LD_EXE=
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_OPT),)
FLAGS_VENDOR_LD_EXE_OPT=-MD
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_DBG),)
FLAGS_VENDOR_LD_EXE_DBG=-MDd
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_PROFILE),)
FLAGS_VENDOR_LD_EXE_PROFILE=--profile-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_COV),)
FLAGS_VENDOR_LD_EXE_COV=--coverage-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_LOADLIBS),)
FLAGS_VENDOR_LD_EXE_LOADLIBS=$(_FLAGS_VC6_LOADLIBS_COMMON)
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_LOADLIBS_OPT),)
FLAGS_VENDOR_LD_EXE_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_LOADLIBS_DBG),)
FLAGS_VENDOR_LD_EXE_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_LOADLIBS_PROFILE),)
FLAGS_VENDOR_LD_EXE_LOADLIBS_PROFILE=--profile-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_EXE_LOADLIBS_COV),)
FLAGS_VENDOR_LD_EXE_LOADLIBS_COV=--coverage-build-not-supported--
endif


ifeq ($(FLAGS_VENDOR_LD_SHLIB),)
FLAGS_VENDOR_LD_SHLIB=
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_OPT),)
FLAGS_VENDOR_LD_SHLIB_OPT=-LD
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_DBG),)
FLAGS_VENDOR_LD_SHLIB_DBG=-LDd
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_PROFILE),)
FLAGS_VENDOR_LD_SHLIB_PROFILE=--profile-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_COV),)
FLAGS_VENDOR_LD_SHLIB_COV=--coverage-build-not-supported--
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
FLAGS_VENDOR_LD_SHLIB_LOADLIBS_PROFILE=--profile-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_COV),)
FLAGS_VENDOR_LD_SHLIB_LOADLIBS_COV=--coverage-build-not-supported--
endif


ifeq ($(FLAGS_VENDOR_LD_INCOBJ),)
FLAGS_VENDOR_LD_INCOBJ=--incremental-objects-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_OPT),)
FLAGS_VENDOR_LD_INCOBJ_OPT=--incremental-objects-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_DBG),)
FLAGS_VENDOR_LD_INCOBJ_DBG=--incremental-objects-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_PROFILE),)
FLAGS_VENDOR_LD_INCOBJ_PROFILE=--incremental-objects-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_COV),)
FLAGS_VENDOR_LD_INCOBJ_COV=--incremental-objects-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS),)
FLAGS_VENDOR_LD_INCOBJ_LOADLIBS=--incremental-objects-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_OPT),)
FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_OPT=--incremental-objects-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_DBG),)
FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_DBG=--incremental-objects-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_PROFILE),)
FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_PROFILE=--incremental-objects-not-supported--
endif
ifeq ($(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_COV),)
FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_COV=--incremental-objects-not-supported--
endif

ifeq ($(FLAGS_VENDOR_AR_LIB),)
FLAGS_VENDOR_AR_LIB=
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_OPT),)
FLAGS_VENDOR_AR_LIB_OPT=
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_DBG),)
FLAGS_VENDOR_AR_LIB_DBG=
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_PROFILE),)
FLAGS_VENDOR_AR_LIB_PROFILE=--profile-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_COV),)
FLAGS_VENDOR_AR_LIB_COV=--coverage-build-not-supported--
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
FLAGS_VENDOR_AR_LIB_LOADLIBS_PROFILE=--profile-build-not-supported--
endif
ifeq ($(FLAGS_VENDOR_AR_LIB_LOADLIBS_COV),)
FLAGS_VENDOR_AR_LIB_LOADLIBS_COV=--coverage-build-not-supported--
endif


ifeq ($(FLAGS_VENDOR_STRIP_EXE),)
FLAGS_VENDOR_STRIP_EXE= -x 
endif
ifeq ($(FLAGS_VENDOR_STRIP_SHLIB),)
FLAGS_VENDOR_STRIP_SHLIB= -x 
endif
ifeq ($(FLAGS_VENDOR_STRIP_LIB),)
FLAGS_VENDOR_STRIP_LIB= -x 
endif


