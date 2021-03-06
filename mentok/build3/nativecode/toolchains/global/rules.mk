

nativecode_toolchain_global_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Native Code Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Global Toolchain Settings (impacts all toolchains)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CC                                 $(FLAGS_CC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CC_OPT                             $(FLAGS_CC_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CC_DBG                             $(FLAGS_CC_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CC_PROFILE                         $(FLAGS_CC_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CC_COV                             $(FLAGS_CC_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CC_NOASSERT                        $(FLAGS_CC_NOASSERT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CC_REENT                           $(FLAGS_CC_REENT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CC_PIC                             $(FLAGS_CC_PIC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CXX                                $(FLAGS_CXX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CXX_OPT                            $(FLAGS_CXX_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CXX_DBG                            $(FLAGS_CXX_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CXX_PROFILE                        $(FLAGS_CXX_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CXX_COV                            $(FLAGS_CXX_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CXX_NOASSERT                       $(FLAGS_CXX_NOASSERT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CXX_REENT                          $(FLAGS_CXX_REENT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_CXX_PIC                            $(FLAGS_CXX_PIC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AS                                 $(FLAGS_AS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AS_OPT                             $(FLAGS_AS_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AS_DBG                             $(FLAGS_AS_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AS_PROFILE                         $(FLAGS_AS_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AC_COV                             $(FLAGS_AS_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_EXE                             $(FLAGS_LD_EXE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_EXE_OPT                         $(FLAGS_LD_EXE_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_EXE_DBG                         $(FLAGS_LD_EXE_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_EXE_PROFILE                     $(FLAGS_LD_EXE_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_EXE_COV                         $(FLAGS_LD_EXE_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_EXE_LOADLIBS                    $(FLAGS_LD_EXE_LOADLIBS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_EXE_LOADLIBS_OPT                $(FLAGS_LD_EXE_LOADLIBS_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_EXE_LOADLIBS_DBG                $(FLAGS_LD_EXE_LOADLIBS_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_EXE_LOADLIBS_PROFILE            $(FLAGS_LD_EXE_LOADLIBS_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_EXE_LOADLIBS_COV                $(FLAGS_LD_EXE_LOADLIBS_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_SHLIB                           $(FLAGS_LD_SHLIB)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_OPT                       $(FLAGS_LD_SHLIB_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_DBG                       $(FLAGS_LD_SHLIB_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_PROFILE                   $(FLAGS_LD_SHLIB_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_COV                       $(FLAGS_LD_SHLIB_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_LOADLIBS                  $(FLAGS_LD_SHLIB_LOADLIBS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_LOADLIBS_OPT              $(FLAGS_LD_SHLIB_LOADLIBS_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_LOADLIBS_DBG              $(FLAGS_LD_SHLIB_LOADLIBS_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_LOADLIBS_PROFILE          $(FLAGS_LD_SHLIB_LOADLIBS_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_LOADLIBS_COV              $(FLAGS_LD_SHLIB_LOADLIBS_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ                          $(FLAGS_LD_INCOBJ)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_OPT                      $(FLAGS_LD_INCOBJ_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_DBG                      $(FLAGS_LD_INCOBJ_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_PROFILE                  $(FLAGS_LD_INCOBJ_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_COV                      $(FLAGS_LD_INCOBJ_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_LOADLIBS                 $(FLAGS_LD_INCOBJ_LOADLIBS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_LOADLIBS_OPT             $(FLAGS_LD_INCOBJ_LOADLIBS_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_LOADLIBS_DBG             $(FLAGS_LD_INCOBJ_LOADLIBS_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_LOADLIBS_PROFILE         $(FLAGS_LD_INCOBJ_LOADLIBS_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_LOADLIBS_COV             $(FLAGS_LD_INCOBJ_LOADLIBS_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AR_LIB                             $(FLAGS_AR_LIB)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AR_LIB_OPT                         $(FLAGS_AR_LIB_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AR_LIB_DBG                         $(FLAGS_AR_LIB_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AR_LIB_PROFILE                     $(FLAGS_AR_LIB_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AR_LIB_COV                         $(FLAGS_AR_LIB_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AR_LIB_LOADLIBS                    $(FLAGS_AR_LIB_LOADLIBS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AR_LIB_LOADLIBS_OPT                $(FLAGS_AR_LIB_LOADLIBS_OPT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AR_LIB_LOADLIBS_DBG                $(FLAGS_AR_LIB_LOADLIBS_DBG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AR_LIB_LOADLIBS_PROFILE            $(FLAGS_AR_LIB_LOADLIBS_PROFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_AR_LIB_LOADLIBS_COV                $(FLAGS_AR_LIB_LOADLIBS_COV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_STRIP_EXE                          $(FLAGS_STRIP_EXE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_STRIP_LIB                          $(FLAGS_STRIP_LIB)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_STRIP_SHLIB                        $(FLAGS_STRIP_SHLIB)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")

# hook it into the main native code module
nativecode_info_toolchains:: nativecode_toolchain_global_info

