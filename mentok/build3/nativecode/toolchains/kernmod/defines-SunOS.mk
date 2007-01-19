
#
# Vendor tool chain with options for compiling Solaris kernel modules
#
ifeq ($(BIN_KERNMOD_CC),)
BIN_KERNMOD_CC = $(BIN_VENDOR_CC)
endif
ifeq ($(BIN_KERNMOD_CXX),)
# No C++ in kernel modules!
BIN_KERNMOD_CXX = $(BIN_FALSE)
endif
ifeq ($(BIN_KERNMOD_AS),)
BIN_KERNMOD_AS = $(BIN_VENDOR_AS)
endif
ifeq ($(BIN_KERNMOD_CPP),)
BIN_KERNMOD_CPP = $(BIN_VENDOR_CPP)
endif
ifeq ($(BIN_KERNMOD_LD),)
BIN_KERNMOD_LD = $(BIN_VENDOR_LD)
endif
ifeq ($(BIN_KERNMOD_AR),)
BIN_KERNMOD_AR = $(BIN_VENDOR_AR)
endif
ifeq ($(BIN_KERNMOD_STRIP),)
  # Solaris kernel modules should NOT be striped!
  BIN_KERNMOD_STRIP = $(BIN_TRUE)
endif

ifeq ($(FLAGS_KERNMOD_CC),)
  FLAGS_KERNMOD_CC = -Xa -v -D_KERNEL
  #
  # Any multi-ABI-capable OS (i.e. >= sol7) should define this
  #
  ifneq "$(BS_OS_REVMAJOR).$(BS_OS_REVMINOR)" "5.6"
    FLAGS_KERNMOD_CC += -D_SYSCALL32
  endif
  #
  # 64-bit builds get even more things defined
  #
  ifeq "$(BS_OS_MACHINEINSTSET)" "sparcv9"
    FLAGS_KERNMOD_CC += -xarch=v9 -D_SYSCALL32_IMPL -D_ELF64 -D__sparcv9cpu
  endif
  #
  # Normal Solaris distribution kernels are compied with SYSACCT and
  # C2_AUDIT.  It probably doesn't matter but C2_AUDIT can affect some
  # header files, so we match that behavior.  SYSACCT doesn't touch any
  # header files so we don't bother with it
  #
  FLAGS_KERNMOD_CC += -DC2_AUDIT
endif
ifeq ($(FLAGS_KERNMOD_CC_DEP),)
FLAGS_KERNMOD_CC_DEP = $(FLAGS_VENDOR_CC_DEP)
endif
ifeq ($(FLAGS_KERNMOD_CC_DBG),)
# Enable Solaris kernel's ASSERT() macro
FLAGS_KERNMOD_CC_DBG = -DDEBUG
endif
ifeq ($(FLAGS_KERNMOD_CC_OPT),)
  ifeq "$(BS_OS_MACHINEINSTSET)" "i386"
    # i386 just uses a plain "-O"
    FLAGS_KERNMOD_CC_OPT = -O
  else
    # SPARC has some flags that vary on 32 vs 64-bit builds...
    ifeq "$(BS_OS_MACHINEINSTSET)" "sparcv9"
      FLAGS_KERNMOD_CC_OPT = -xchip=ultra -Wc,-xcode=abs32 -Wc,-Qiselect-regsym=0
    else
      FLAGS_KERNMOD_CC_OPT = -xarch=v7
    endif
    # ...and some that are shared between the two
    FLAGS_KERNMOD_CC_OPT += -xO3 -xspace -W0,-Lt
  endif
endif
ifeq ($(FLAGS_KERNMOD_CC_PROFILE),)
FLAGS_KERNMOD_CC_PROFILE = $(FLAGS_VENDOR_CC_PROFILE)
endif
ifeq ($(FLAGS_KERNMOD_CC_COV),)
FLAGS_KERNMOD_CC_COV = $(FLAGS_VENDOR_CC_COV)
endif
ifeq ($(FLAGS_KERNMOD_CC_NOASSERT),)
# Disable Solaris kernel's ASSERT() macro
FLAGS_KERNMOD_CC_NOASSERT = -UDEBUG
endif
ifeq ($(FLAGS_KERNMOD_CC_REENT),)
FLAGS_KERNMOD_CC_REENT = $(FLAGS_VENDOR_CC_REENT)
endif

ifeq ($(FLAGS_KERNMOD_AS),)
FLAGS_KERNMOD_AS = $(FLAGS_VENDOR_AS)
endif
ifeq ($(FLAGS_KERNMOD_AS_DEP),)
FLAGS_KERNMOD_AS_DEP = $(FLAGS_VENDOR_AS_DEP)
endif
ifeq ($(FLAGS_KERNMOD_AS_DBG),)
FLAGS_KERNMOD_AS_DBG = $(FLAGS_VENDOR_AS_DBG)
endif
ifeq ($(FLAGS_KERNMOD_AS_OPT),)
FLAGS_KERNMOD_AS_OPT = $(FLAGS_VENDOR_AS_OPT)
endif
ifeq ($(FLAGS_KERNMOD_AS_PROFILE),)
FLAGS_KERNMOD_AS_PROFILE = $(FLAGS_VENDOR_AS_PROFILE)
endif
ifeq ($(FLAGS_KERNMOD_AS_COV),)
FLAGS_KERNMOD_AS_COV = $(FLAGS_VENDOR_AS_COV)
endif

ifeq ($(FLAGS_KERNMOD_LD_EXE),)
FLAGS_KERNMOD_LD_EXE = -r
endif
ifeq ($(FLAGS_KERNMOD_LD_EXE_OPT),)
FLAGS_KERNMOD_LD_EXE_OPT = $(FLAGS_VENDOR_LD_EXE_OPT)
endif
ifeq ($(FLAGS_KERNMOD_LD_EXE_DBG),)
FLAGS_KERNMOD_LD_EXE_DBG = $(FLAGS_VENDOR_LD_EXE_DBG)
endif
ifeq ($(FLAGS_KERNMOD_LD_EXE_PROFILE),)
FLAGS_KERNMOD_LD_EXE_PROFILE =
endif
ifeq ($(FLAGS_KERNMOD_LD_EXE_COV),)
FLAGS_KERNMOD_LD_EXE_COV =
endif
ifeq ($(FLAGS_KERNMOD_LD_EXE_LOADLIBS),)
FLAGS_KERNMOD_LD_EXE_LOADLIBS =
endif
ifeq ($(FLAGS_KERNMOD_LD_EXE_LOADLIBS_OPT),)
FLAGS_KERNMOD_LD_EXE_LOADLIBS_OPT = $(FLAGS_VENDOR_LD_EXE_LOADLIBS_OPT)
endif
ifeq ($(FLAGS_KERNMOD_LD_EXE_LOADLIBS_DBG),)
FLAGS_KERNMOD_LD_EXE_LOADLIBS_DBG = $(FLAGS_VENDOR_LD_EXE_LOADLIBS_DBG)
endif
ifeq ($(FLAGS_KERNMOD_LD_EXE_LOADLIBS_PROFILE),)
FLAGS_KERNMOD_LD_EXE_LOADLIBS_PROFILE =
endif
ifeq ($(FLAGS_KERNMOD_LD_EXE_LOADLIBS_COV),)
FLAGS_KERNMOD_LD_EXE_LOADLIBS_COV =
endif

ifeq ($(FLAGS_KERNMOD_LD_INCOBJ),)
FLAGS_KERNMOD_LD_INCOBJ = -r
endif
ifeq ($(FLAGS_KERNMOD_LD_INCOBJ_OPT),)
FLAGS_KERNMOD_LD_INCOBJ_OPT = $(FLAGS_VENDOR_LD_INCOBJ_OPT)
endif
ifeq ($(FLAGS_KERNMOD_LD_INCOBJ_DBG),)
FLAGS_KERNMOD_LD_INCOBJ_DBG = $(FLAGS_VENDOR_LD_INCOBJ_DBG)
endif
ifeq ($(FLAGS_KERNMOD_LD_INCOBJ_PROFILE),)
FLAGS_KERNMOD_LD_INCOBJ_PROFILE =
endif
ifeq ($(FLAGS_KERNMOD_LD_INCOBJ_COV),)
FLAGS_KERNMOD_LD_INCOBJ_COV =
endif
ifeq ($(FLAGS_KERNMOD_LD_INCOBJ_LOADLIBS),)
FLAGS_KERNMOD_LD_INCOBJ_LOADLIBS =
endif
ifeq ($(FLAGS_KERNMOD_LD_INCOBJ_LOADLIBS_OPT),)
FLAGS_KERNMOD_LD_INCOBJ_LOADLIBS_OPT = $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_OPT)
endif
ifeq ($(FLAGS_KERNMOD_LD_INCOBJ_LOADLIBS_DBG),)
FLAGS_KERNMOD_LD_INCOBJ_LOADLIBS_DBG = $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_DBG)
endif
ifeq ($(FLAGS_KERNMOD_LD_INCOBJ_LOADLIBS_PROFILE),)
FLAGS_KERNMOD_LD_INCOBJ_LOADLIBS_PROFILE =
endif
ifeq ($(FLAGS_KERNMOD_LD_INCOBJ_LOADLIBS_COV),)
FLAGS_KERNMOD_LD_INCOBJ_LOADLIBS_COV =
endif

ifeq ($(FLAGS_KERNMOD_AR_LIB),)
FLAGS_KERNMOD_AR_LIB = $(FLAGS_VENDOR_AR_LIB)
endif
ifeq ($(FLAGS_KERNMOD_AR_LIB_OPT),)
FLAGS_KERNMOD_AR_LIB_OPT = $(FLAGS_VENDOR_AR_LIB_OPT)
endif
ifeq ($(FLAGS_KERNMOD_AR_LIB_DBG),)
FLAGS_KERNMOD_AR_LIB_DBG = $(FLAGS_VENDOR_AR_LIB_DBG)
endif
ifeq ($(FLAGS_KERNMOD_AR_LIB_PROFILE),)
FLAGS_KERNMOD_AR_LIB_PROFILE = $(FLAGS_VENDOR_AR_LIB_PROFILE)
endif
ifeq ($(FLAGS_KERNMOD_AR_LIB_COV),)
FLAGS_KERNMOD_AR_LIB_COV = $(FLAGS_VENDOR_AR_LIB_COV)
endif
ifeq ($(FLAGS_KERNMOD_AR_LIB_LOADLIBS),)
FLAGS_KERNMOD_AR_LIB_LOADLIBS = $(FLAGS_VENDOR_AR_LIB_LOADLIBS)
endif
ifeq ($(FLAGS_KERNMOD_AR_LIB_LOADLIBS_OPT),)
FLAGS_KERNMOD_AR_LIB_LOADLIBS_OPT = $(FLAGS_VENDOR_AR_LIB_LOADLIBS_OPT)
endif
ifeq ($(FLAGS_KERNMOD_AR_LIB_LOADLIBS_DBG),)
FLAGS_KERNMOD_AR_LIB_LOADLIBS_DBG = $(FLAGS_VENDOR_AR_LIB_LOADLIBS_DBG)
endif
ifeq ($(FLAGS_KERNMOD_AR_LIB_LOADLIBS_PROFILE),)
FLAGS_KERNMOD_AR_LIB_LOADLIBS_PROFILE = $(FLAGS_VENDOR_AR_LIB_LOADLIBS_PROFILE)
endif
ifeq ($(FLAGS_KERNMOD_AR_LIB_LOADLIBS_COV),)
FLAGS_KERNMOD_AR_LIB_LOADLIBS_COV = $(FLAGS_VENDOR_AR_LIB_LOADLIBS_COV)
endif

ifeq ($(FLAGS_KERNMOD_STRIP_EXE),)
FLAGS_KERNMOD_STRIP_EXE =
endif
ifeq ($(FLAGS_KERNMOD_STRIP_SHLIB),)
FLAGS_KERNMOD_STRIP_SHLIB =
endif
ifeq ($(FLAGS_KERNMOD_STRIP_LIB),)
FLAGS_KERNMOD_STRIP_LIB =
endif

