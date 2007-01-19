

nativecode_toolchain_vendor_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Native Code Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Vendor Toolchain Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_CC                            $(BIN_VENDOR_CC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_CC_OUTPUTFLAG                 $(BIN_VENDOR_CC_OUTPUTFLAG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_CXX                           $(BIN_VENDOR_CXX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_CXX_OUTPUTFLAG                $(BIN_VENDOR_CXX_OUTPUTFLAG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_AS                            $(BIN_VENDOR_AS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_AS_OUTPUTFLAG                 $(BIN_VENDOR_AS_OUTPUTFLAG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_CPP                           $(BIN_VENDOR_CPP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_CPP_OUTPUTFLAG                $(BIN_VENDOR_CPP_OUTPUTFLAG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_AR                            $(BIN_VENDOR_AR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_AR_OUTPUTFLAG                 $(BIN_VENDOR_AR_OUTPUTFLAG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_LD                            $(BIN_VENDOR_LD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_LD_OUTPUTFLAG_EXE             $(BIN_VENDOR_LD_OUTPUTFLAG_EXE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_LD_OUTPUTFLAG_SHLIB           $(BIN_VENDOR_LD_OUTPUTFLAG_SHLIB)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_LD_OUTPUTFLAG_INCOBJ          $(BIN_VENDOR_LD_OUTPUTFLAG_INCOBJ)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_VENDOR_STRIP                         $(BIN_VENDOR_STRIP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CC                          $(FLAGS_VENDOR_CC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_DEP                      $(FLAGS_VENDOR_CC_DEP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_OPT                      $(FLAGS_VENDOR_CC_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_DBG                      $(FLAGS_VENDOR_CC_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_PROFILE                  $(FLAGS_VENDOR_CC_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_COV                      $(FLAGS_VENDOR_CC_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_NOASSERT                 $(FLAGS_VENDOR_CC_NOASSERT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_REENT                    $(FLAGS_VENDOR_CC_REENT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX                         $(FLAGS_VENDOR_CXX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_DEP                     $(FLAGS_VENDOR_CXX_DEP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_OPT                     $(FLAGS_VENDOR_CXX_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_DBG                     $(FLAGS_VENDOR_CXX_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_PROFILE                 $(FLAGS_VENDOR_CXX_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_COV                     $(FLAGS_VENDOR_CXX_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_NOASSERT                $(FLAGS_VENDOR_CXX_NOASSERT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_REENT                   $(FLAGS_VENDOR_CXX_REENT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AS                          $(FLAGS_VENDOR_AS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AS_DEP                      $(FLAGS_VENDOR_AS_DEP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AS_OPT                      $(FLAGS_VENDOR_AS_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AS_DBG                      $(FLAGS_VENDOR_AS_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AS_PROFILE                  $(FLAGS_VENDOR_AS_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AS_COV                      $(FLAGS_VENDOR_AS_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE                      $(FLAGS_VENDOR_LD_EXE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_OPT                  $(FLAGS_VENDOR_LD_EXE_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_DBG                  $(FLAGS_VENDOR_LD_EXE_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_PROFILE              $(FLAGS_VENDOR_LD_EXE_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_COV                  $(FLAGS_VENDOR_LD_EXE_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_LOADLIBS             $(FLAGS_VENDOR_LD_EXE_LOADLIBS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_LOADLIBS_OPT         $(FLAGS_VENDOR_LD_EXE_LOADLIBS_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_LOADLIBS_DBG         $(FLAGS_VENDOR_LD_EXE_LOADLIBS_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_LOADLIBS_PROFILE     $(FLAGS_VENDOR_LD_EXE_LOADLIBS_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_LOADLIBS_COV         $(FLAGS_VENDOR_LD_EXE_LOADLIBS_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB                    $(FLAGS_VENDOR_LD_SHLIB)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_OPT                $(FLAGS_VENDOR_LD_SHLIB_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_DBG                $(FLAGS_VENDOR_LD_SHLIB_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_PROFILE            $(FLAGS_VENDOR_LD_SHLIB_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_COV                $(FLAGS_VENDOR_LD_SHLIB_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_LOADLIBS           $(FLAGS_VENDOR_LD_SHLIB_LOADLIBS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_LOADLIBS_OPT       $(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_LOADLIBS_DBG       $(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_LOADLIBS_PROFILE   $(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_LOADLIBS_COV       $(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ                   $(FLAGS_VENDOR_LD_INCOBJ)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_OPT               $(FLAGS_VENDOR_LD_INCOBJ_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_DBG               $(FLAGS_VENDOR_LD_INCOBJ_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_PROFILE           $(FLAGS_VENDOR_LD_INCOBJ_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_COV               $(FLAGS_VENDOR_LD_INCOBJ_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_LOADLIBS          $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_OPT      $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_DBG      $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_PROFILE  $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_COV      $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB                      $(FLAGS_VENDOR_AR_LIB)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_OPT                  $(FLAGS_VENDOR_AR_LIB_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_DBG                  $(FLAGS_VENDOR_AR_LIB_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_PROFILE              $(FLAGS_VENDOR_AR_LIB_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_COV                  $(FLAGS_VENDOR_AR_LIB_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_LOADLIBS             $(FLAGS_VENDOR_AR_LIB_LOADLIBS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_LOADLIBS_OPT         $(FLAGS_VENDOR_AR_LIB_LOADLIBS_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_LOADLIBS_DBG         $(FLAGS_VENDOR_AR_LIB_LOADLIBS_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_LOADLIBS_PROFILE     $(FLAGS_VENDOR_AR_LIB_LOADLIBS_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_LOADLIBS_COV         $(FLAGS_VENDOR_AR_LIB_LOADLIBS_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_STRIP_EXE                   $(FLAGS_VENDOR_STRIP_EXE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_STRIP_LIB                   $(FLAGS_VENDOR_STRIP_LIB)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_VENDOR_STRIP_SHLIB                 $(FLAGS_VENDOR_STRIP_SHLIB)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")



# hook it into the main native code module
nativecode_info_toolchains:: nativecode_toolchain_vendor_info

