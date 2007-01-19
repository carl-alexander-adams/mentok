#
# Cross compiler tool chain for Cavium MIPS64 linux 
#
# Only cross compiling tool chains provide these. These
# allow end point make files to construct platform strings
# approiate to the cross compiler's target platform.
# Really, these have to be specified, since we do not
# have a programatic way of determining what the target
# platform is. (and in the generally cross compiling problem,
# you could be compiling for N platforms on the build host.)
XC_CAVIUMMIPS64_LINUX_SDK_REVMAJOR=1
XC_CAVIUMMIPS64_LINUX_SDK_REVMINOR=0
XC_CAVIUMMIPS64_LINUX_SDK_REVPATCH=0
XC_CAVIUMMIPS64_LINUX_SDK_HOME=/usr/local/Cavium_Networks-$(XC_CAVIUMMIPS64_LINUX_SDK_REVMAJOR).$(XC_CAVIUMMIPS64_LINUX_SDK_REVMINOR).$(XC_CAVIUMMIPS64_LINUX_SDK_REVPATCH)/CN3XXX-SDK

XC_CAVIUMMIPS64_LINUX_TOOLCHAIN_REVMAJOR=$(XC_CAVIUMMIPS64_LINUX_SDK_REVMAJOR)
XC_CAVIUMMIPS64_LINUX_TOOLCHAIN_REVMINOR=$(XC_CAVIUMMIPS64_LINUX_SDK_REVMINOR)
XC_CAVIUMMIPS64_LINUX_TOOLCHAIN_REVPATCH=$(XC_CAVIUMMIPS64_LINUX_SDK_REVPATCH)

XC_CAVIUMMIPS64_LINUX_OS_NAME=Linux
XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR=2
XC_CAVIUMMIPS64_LINUX_OS_REVMINOR=6
XC_CAVIUMMIPS64_LINUX_OS_REVPATCH=10-Cavium-Octeon
XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME=glibc
XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR=2
XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR=3
XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH=3
XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE=mips64
XC_CAVIUMMIPS64_LINUX_OS_MACHINEPROC=octeon
XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET=mips64

XC_CAVIUMMIPS64_LINUX_PLATFORM_FULL=$(call BS_FUNC_GEN_PLATFORM_FULL,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_1=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_1,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_2=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_2,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_3=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_3,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_4=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_4,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_5=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_5,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_6=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_6,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_7=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_7,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_8=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_8,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_9=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_9,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_10=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_10,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_11=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_11,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))
XC_CAVIUMMIPS64_LINUX_PLATFORM_FALLBACK_12=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_12,\
	$(XC_CAVIUMMIPS64_LINUX_OS_NAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_REVPATCH),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINEINSTSET),\
	$(XC_CAVIUMMIPS64_LINUX_OS_MACHINETYPE),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMENAME),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMAJOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVMINOR),\
	$(XC_CAVIUMMIPS64_LINUX_OS_RUNTIMEREVPATCH))



# Note: the trailing space on the outflags is INTENTIONAL.
# the core rules leave no space between the output file
# and the outflag to accommodate some platforms. If you want
# space, add it here.
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_CC),)
BIN_XC_CAVIUMMIPS64_LINUX_CC=$(XC_CAVIUMMIPS64_LINUX_SDK_HOME)/tools/bin/mips64-octeon-linux-gnu-gcc
BIN_XC_CAVIUMMIPS64_LINUX_CC_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_CXX),)
BIN_XC_CAVIUMMIPS64_LINUX_CXX=$(XC_CAVIUMMIPS64_LINUX_SDK_HOME)/tools/bin/mips64-octeon-linux-gnu-g++ \
    -I$(XC_CAVIUMMIPS64_LINUX_SDK_HOME)/tools/lib/gcc/mips64-octeon-linux/3.4.3/include \
    -I$(XC_CAVIUMMIPS64_LINUX_SDK_HOME)/tools/lib/gcc/mips64-octeon-linux/3.4.3/install-tools/include \
    -I$(XC_CAVIUMMIPS64_LINUX_SDK_HOME)/tools/include/c++/3.4.3/mipsisa64-octeon-elf
BIN_XC_CAVIUMMIPS64_LINUX_CXX_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_AS),)
BIN_XC_CAVIUMMIPS64_LINUX_AS=$(XC_CAVIUMMIPS64_LINUX_SDK_HOME)/tools/bin/mips64-octeon-linux-gnu-gcc
BIN_XC_CAVIUMMIPS64_LINUX_AS_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_CPP),)
BIN_XC_CAVIUMMIPS64_LINUX_CPP=$(XC_CAVIUMMIPS64_LINUX_SDK_HOME)/tools/bin/mips64-octeon-linux-gnu-gcc -E
BIN_XC_CAVIUMMIPS64_LINUX_CPP_OUTPUTFLAG=-o 
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_LD),)
BIN_XC_CAVIUMMIPS64_LINUX_LD=$(XC_CAVIUMMIPS64_LINUX_SDK_HOME)/tools/bin/mips64-octeon-linux-gnu-gcc
BIN_XC_CAVIUMMIPS64_LINUX_LD_OUTPUTFLAG_EXE=-o 
BIN_XC_CAVIUMMIPS64_LINUX_LD_OUTPUTFLAG_SHLIB=-o 
BIN_XC_CAVIUMMIPS64_LINUX_LD_OUTPUTFLAG_INCOBJ=-o 
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_AR),)
BIN_XC_CAVIUMMIPS64_LINUX_AR=$(XC_CAVIUMMIPS64_LINUX_SDK_HOME)/tools/bin/mips64-octeon-linux-gnu-ar
BIN_XC_CAVIUMMIPS64_LINUX_AR_OUTPUTFLAG=
endif
ifeq ($(BIN_XC_CAVIUMMIPS64_LINUX_STRIP),)
BIN_XC_CAVIUMMIPS64_LINUX_STRIP=$(XC_CAVIUMMIPS64_LINUX_SDK_HOME)/tools/bin/mips64-octeon-linux-gnu-strip
endif


ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CC),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CC=-W \
	-Wall \
	-Wcast-qual \
	-Wcast-align \
	-Wpointer-arith \
	-Wsign-compare \
	-Winline \
	-Waggregate-return \
	-Wmissing-prototypes \
	-Wmissing-declarations \
	-Wunused \
	-march=octeon \
	-mabi=n32

#	-v \
#	-ftime-report \
#	-fmem-report

endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CC_DEP),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CC_DEP=-MM -w
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CC_DBG),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CC_DBG=-g3 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CC_OPT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CC_OPT=-O3 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CC_PROFILE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CC_PROFILE=-pg  
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CC_COV),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CC_COV=-fprofile-arcs -ftest-coverage 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CC_NOASSERT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CC_NOASSERT=-DNDEBUG 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CC_REENT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CC_REENT=-D_REENTRANT 
endif

ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CXX),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CXX=-W \
	-Wall \
	-Wcast-qual \
	-Wcast-align \
	-Wpointer-arith \
	-Wsign-compare \
	-Winline \
	-Wunused \
  -march=octeon \
  -mabi=n32
#	-v \
#	-ftime-report \
#	-fmem-report

endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_DEP),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_DEP=-MM -w
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_DBG),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_DBG=-g3 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_OPT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_OPT=-O3  
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_PROFILE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_PROFILE=-pg 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_COV),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_COV=-fprofile-arcs -ftest-coverage 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_NOASSERT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_NOASSERT=-DNDEBUG 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_REENT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_CXX_REENT=-D_REENTRANT 
endif

ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AS),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AS= 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AS_DEP),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AS_DEP=-MM -w
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AS_DBG),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AS_DBG=-g3 -Wa,--gstabs 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AS_OPT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AS_OPT=-O3  
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AS_PROFILE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AS_PROFILE= 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AS_COV),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AS_COV= 
endif


ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE= -mabi=n32
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_OPT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_OPT= 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_DBG),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_DBG= 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_PROFILE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_PROFILE=-pg -ldl 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_COV),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_COV= 
endif

ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_LOADLIBS),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_LOADLIBS= 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_LOADLIBS_OPT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_LOADLIBS_OPT= 
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_LOADLIBS_DBG),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_LOADLIBS_PROFILE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_LOADLIBS_COV),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_EXE_LOADLIBS_LOADLIBS_COV=
endif

ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB=-shared -mabi=n32
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_OPT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_OPT=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_DBG),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_DBG=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_PROFILE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_PROFILE=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_COV),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_COV=
endif

ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_LOADLIBS),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_LOADLIBS=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_LOADLIBS_OPT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_LOADLIBS_DBG),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_LOADLIBS_PROFILE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_LOADLIBS_COV),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_SHLIB_LOADLIBS_COV=
endif


ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ=-Wl,-r
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_OPT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_OPT=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_DBG),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_DBG=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_PROFILE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_PROFILE=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_COV),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_COV=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_LOADLIBS),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_LOADLIBS=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_LOADLIBS_OPT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_LOADLIBS_DBG),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_LOADLIBS_PROFILE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_LOADLIBS_COV),)
FLAGS_XC_CAVIUMMIPS64_LINUX_LD_INCOBJ_LOADLIBS_COV=
endif

ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB=rc
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_OPT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_OPT=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_DBG),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_DBG=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_PROFILE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_PROFILE=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_COV),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_COV=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_LOADLIBS),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_LOADLIBS=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_LOADLIBS_OPT),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_LOADLIBS_OPT=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_LOADLIBS_DBG),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_LOADLIBS_DBG=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_LOADLIBS_PROFILE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_LOADLIBS_PROFILE=
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_LOADLIBS_COV),)
FLAGS_XC_CAVIUMMIPS64_LINUX_AR_LIB_LOADLIBS_COV=
endif


ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_STRIP_EXE),)
FLAGS_XC_CAVIUMMIPS64_LINUX_STRIP_EXE= --strip-unneeded
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_STRIP_SHLIB),)
FLAGS_XC_CAVIUMMIPS64_LINUX_STRIP_SHLIB= --discard-all
endif
ifeq ($(FLAGS_XC_CAVIUMMIPS64_LINUX_STRIP_LIB),)
FLAGS_XC_CAVIUMMIPS64_LINUX_STRIP_LIB= --discard-all
endif




