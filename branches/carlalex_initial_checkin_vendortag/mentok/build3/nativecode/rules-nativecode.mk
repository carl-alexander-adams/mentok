#
# Module PRIVATE function. call at your own peril
#

#
# Define functions to try and figure out what type
# of .o a file is. This is a bastard since simply
# stating that program.exe depends on module.o does
# nothing to answer the question of whether module.o
# arises from C code, C++ code, assembly code, fortran
# code, incremental linking, etc. This is a fundamental 
# problem in the classical way make files are written.
#
# Note: we use more than one function for these to
# skirt some bugs in gmake that cause it to core dump

_filterobjlist_cc_marcoSRC=$(if $(filter %.c,$($(1)_SRC)),$(1),)
_filterobjlist_cc_guessSRC=$(if $(wildcard $(1:.o=.c)),$(1),)
filterobjlist_only_cc=$(foreach o,$(1),\
	$(if $($(o)_SRC),\
		$(call _filterobjlist_cc_marcoSRC,$(o)),\
		$(call _filterobjlist_cc_guessSRC,$(o))))

_filterobjlist_cxx_marcoSRC=$(if $(filter %.cc,$($(1)_SRC)),$(1),)
_filterobjlist_cxx_guessSRC=$(if $(wildcard $(1:.o=.cc)),$(1),)
filterobjlist_only_cxx=$(foreach o,$(1),\
	$(if $($(o)_SRC),\
		$(call _filterobjlist_cxx_marcoSRC,$(o)),\
		$(call _filterobjlist_cxx_guessSRC,$(o))))

_filterobjlist_as_marcoSRC=$(if $(filter %.s,$($(1)_SRC)),$(1),)
_filterobjlist_as_guessSRC=$(if $(wildcard $(1:.o=.s)),$(1),)
filterobjlist_only_as=$(foreach o,$(1),\
	$(if $($(o)_SRC),\
		$(call _filterobjlist_as_marcoSRC,$(o)),\
		$(call _filterobjlist_as_guessSRC,$(o))))

# no guessing for if a OBJ arose from an incremental link.
# these must be called out explicitly in a OBJ_INC_TARGETS
# in the make file. we cannot guess if a .o came from linking
# several .o's incrementally together.
filterobjlist_only_inc=$(foreach o,$(1),$(filter $(o), $(OBJ_INC_TARGETS)))


#
# Module rules
#
nativecode_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Native Code Module Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_BSCATMAN) $(BS_ROOT)/nativecode/nativecode.html

nativecode_info:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Native Code Module Macro Settings"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) NC_CONTROL_TOOLCHAIN                     $(NC_CONTROL_TOOLCHAIN)"
	@echo "$(BS_INFO_PREFIX) NC_CONTROL_OPTIMIZE                      $(NC_CONTROL_OPTIMIZE)"
	@echo "$(BS_INFO_PREFIX) NC_CONTROL_DEBUG                         $(NC_CONTROL_DEBUG)"
	@echo "$(BS_INFO_PREFIX) NC_CONTROL_STRIP                         $(NC_CONTROL_STRIP)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) BIN_GNU_CC                               $(BIN_GNU_CC)"
	@echo "$(BS_INFO_PREFIX) BIN_GNU_CXX                              $(BIN_GNU_CXX)"
	@echo "$(BS_INFO_PREFIX) BIN_GNU_AS                               $(BIN_GNU_AS)"
	@echo "$(BS_INFO_PREFIX) BIN_GNU_CPP                              $(BIN_GNU_CPP)"
	@echo "$(BS_INFO_PREFIX) BIN_GNU_AR                               $(BIN_GNU_AR)"
	@echo "$(BS_INFO_PREFIX) BIN_GNU_LD                               $(BIN_GNU_LD)"
	@echo "$(BS_INFO_PREFIX) BIN_GNU_STRIP                            $(BIN_GNU_STRIP)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CC                             $(FLAGS_GNU_CC)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CC_DEP                         $(FLAGS_GNU_CC_DEP)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CC_OPT                         $(FLAGS_GNU_CC_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CC_DBG                         $(FLAGS_GNU_CC_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CC_PROFILE                     $(FLAGS_GNU_CC_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CC_COV                         $(FLAGS_GNU_CC_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CXX                            $(FLAGS_GNU_CXX)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CXX_DEP                        $(FLAGS_GNU_CXX_DEP)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CXX_OPT                        $(FLAGS_GNU_CXX_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CXX_DBG                        $(FLAGS_GNU_CXX_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CXX_PROFILE                    $(FLAGS_GNU_CXX_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_CXX_COV                        $(FLAGS_GNU_CXX_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AS                             $(FLAGS_GNU_AS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AS_DEP                         $(FLAGS_GNU_AS_DEP)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AS_OPT                         $(FLAGS_GNU_AS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AS_DBG                         $(FLAGS_GNU_AS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AS_PROFILE                     $(FLAGS_GNU_AS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AS_COV                         $(FLAGS_GNU_AS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_EXE                         $(FLAGS_GNU_LD_EXE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_EXE_OPT                     $(FLAGS_GNU_LD_EXE_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_EXE_DBG                     $(FLAGS_GNU_LD_EXE_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_EXE_PROFILE                 $(FLAGS_GNU_LD_EXE_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_EXE_COV                     $(FLAGS_GNU_LD_EXE_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_EXE_LOADLIBS                $(FLAGS_GNU_LD_EXE_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_EXE_LOADLIBS_OPT            $(FLAGS_GNU_LD_EXE_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_EXE_LOADLIBS_DBG            $(FLAGS_GNU_LD_EXE_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_EXE_LOADLIBS_PROFILE        $(FLAGS_GNU_LD_EXE_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_EXE_LOADLIBS_COV            $(FLAGS_GNU_LD_EXE_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_SHLIB                       $(FLAGS_GNU_LD_SHLIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_SHLIB_OPT                   $(FLAGS_GNU_LD_SHLIB_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_SHLIB_DBG                   $(FLAGS_GNU_LD_SHLIB_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_SHLIB_PROFILE               $(FLAGS_GNU_LD_SHLIB_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_SHLIB_COV                   $(FLAGS_GNU_LD_SHLIB_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_SHLIB_LOADLIBS              $(FLAGS_GNU_LD_SHLIB_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_SHLIB_LOADLIBS_OPT          $(FLAGS_GNU_LD_SHLIB_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_SHLIB_LOADLIBS_DBG          $(FLAGS_GNU_LD_SHLIB_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_SHLIB_LOADLIBS_PROFILE      $(FLAGS_GNU_LD_SHLIB_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_SHLIB_LOADLIBS_COV          $(FLAGS_GNU_LD_SHLIB_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_INCOBJ                      $(FLAGS_GNU_LD_INCOBJ)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_INCOBJ_OPT                  $(FLAGS_GNU_LD_INCOBJ_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_INCOBJ_DBG                  $(FLAGS_GNU_LD_INCOBJ_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_INCOBJ_PROFILE              $(FLAGS_GNU_LD_INCOBJ_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_INCOBJ_COV                  $(FLAGS_GNU_LD_INCOBJ_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_INCOBJ_LOADLIBS             $(FLAGS_GNU_LD_INCOBJ_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_INCOBJ_LOADLIBS_OPT         $(FLAGS_GNU_LD_INCOBJ_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_INCOBJ_LOADLIBS_DBG         $(FLAGS_GNU_LD_INCOBJ_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_INCOBJ_LOADLIBS_PROFILE     $(FLAGS_GNU_LD_INCOBJ_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_LD_INCOBJ_LOADLIBS_COV         $(FLAGS_GNU_LD_INCOBJ_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AR_LIB                         $(FLAGS_GNU_AR_LIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AR_LIB_OPT                     $(FLAGS_GNU_AR_LIB_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AR_LIB_DBG                     $(FLAGS_GNU_AR_LIB_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AR_LIB_PROFILE                 $(FLAGS_GNU_AR_LIB_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AR_LIB_COV                     $(FLAGS_GNU_AR_LIB_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AR_LIB_LOADLIBS                $(FLAGS_GNU_AR_LIB_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AR_LIB_LOADLIBS_OPT            $(FLAGS_GNU_AR_LIB_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AR_LIB_LOADLIBS_DBG            $(FLAGS_GNU_AR_LIB_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AR_LIB_LOADLIBS_PROFILE        $(FLAGS_GNU_AR_LIB_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_AR_LIB_LOADLIBS_COV            $(FLAGS_GNU_AR_LIB_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_STRIP_EXE                      $(FLAGS_GNU_STRIP_EXE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_STRIP_LIB                      $(FLAGS_GNU_STRIP_LIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_GNU_STRIP_SHLIB                    $(FLAGS_GNU_STRIP_SHLIB)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) BIN_VENDOR_CC                            $(BIN_VENDOR_CC)"
	@echo "$(BS_INFO_PREFIX) BIN_VENDOR_CXX                           $(BIN_VENDOR_CXX)"
	@echo "$(BS_INFO_PREFIX) BIN_VENDOR_AS                            $(BIN_VENDOR_AS)"
	@echo "$(BS_INFO_PREFIX) BIN_VENDOR_CPP                           $(BIN_VENDOR_CPP)"
	@echo "$(BS_INFO_PREFIX) BIN_VENDOR_AR                            $(BIN_VENDOR_AR)"
	@echo "$(BS_INFO_PREFIX) BIN_VENDOR_LD                            $(BIN_VENDOR_LD)"
	@echo "$(BS_INFO_PREFIX) BIN_VENDOR_STRIP                         $(BIN_VENDOR_STRIP)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CC                          $(FLAGS_VENDOR_CC)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_DEP                      $(FLAGS_VENDOR_CC_DEP)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_OPT                      $(FLAGS_VENDOR_CC_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_DBG                      $(FLAGS_VENDOR_CC_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_PROFILE                  $(FLAGS_VENDOR_CC_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CC_COV                      $(FLAGS_VENDOR_CC_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX                         $(FLAGS_VENDOR_CXX)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_DEP                     $(FLAGS_VENDOR_CXX_DEP)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_OPT                     $(FLAGS_VENDOR_CXX_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_DBG                     $(FLAGS_VENDOR_CXX_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_PROFILE                 $(FLAGS_VENDOR_CXX_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_CXX_COV                     $(FLAGS_VENDOR_CXX_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AS                          $(FLAGS_VENDOR_AS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AS_DEP                      $(FLAGS_VENDOR_AS_DEP)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AS_OPT                      $(FLAGS_VENDOR_AS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AS_DBG                      $(FLAGS_VENDOR_AS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AS_PROFILE                  $(FLAGS_VENDOR_AS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AS_COV                      $(FLAGS_VENDOR_AS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE                      $(FLAGS_VENDOR_LD_EXE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_OPT                  $(FLAGS_VENDOR_LD_EXE_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_DBG                  $(FLAGS_VENDOR_LD_EXE_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_PROFILE              $(FLAGS_VENDOR_LD_EXE_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_COV                  $(FLAGS_VENDOR_LD_EXE_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_LOADLIBS             $(FLAGS_VENDOR_LD_EXE_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_LOADLIBS_OPT         $(FLAGS_VENDOR_LD_EXE_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_LOADLIBS_DBG         $(FLAGS_VENDOR_LD_EXE_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_LOADLIBS_PROFILE     $(FLAGS_VENDOR_LD_EXE_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_EXE_LOADLIBS_COV         $(FLAGS_VENDOR_LD_EXE_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB                    $(FLAGS_VENDOR_LD_SHLIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_OPT                $(FLAGS_VENDOR_LD_SHLIB_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_DBG                $(FLAGS_VENDOR_LD_SHLIB_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_PROFILE            $(FLAGS_VENDOR_LD_SHLIB_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_COV                $(FLAGS_VENDOR_LD_SHLIB_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_LOADLIBS           $(FLAGS_VENDOR_LD_SHLIB_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_LOADLIBS_OPT       $(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_LOADLIBS_DBG       $(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_LOADLIBS_PROFILE   $(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_SHLIB_LOADLIBS_COV       $(FLAGS_VENDOR_LD_SHLIB_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ                   $(FLAGS_VENDOR_LD_INCOBJ)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_OPT               $(FLAGS_VENDOR_LD_INCOBJ_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_DBG               $(FLAGS_VENDOR_LD_INCOBJ_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_PROFILE           $(FLAGS_VENDOR_LD_INCOBJ_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_COV               $(FLAGS_VENDOR_LD_INCOBJ_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_LOADLIBS          $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_OPT      $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_DBG      $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_PROFILE  $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_COV      $(FLAGS_VENDOR_LD_INCOBJ_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB                      $(FLAGS_VENDOR_AR_LIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_OPT                  $(FLAGS_VENDOR_AR_LIB_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_DBG                  $(FLAGS_VENDOR_AR_LIB_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_PROFILE              $(FLAGS_VENDOR_AR_LIB_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_COV                  $(FLAGS_VENDOR_AR_LIB_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_LOADLIBS             $(FLAGS_VENDOR_AR_LIB_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_LOADLIBS_OPT         $(FLAGS_VENDOR_AR_LIB_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_LOADLIBS_DBG         $(FLAGS_VENDOR_AR_LIB_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_LOADLIBS_PROFILE     $(FLAGS_VENDOR_AR_LIB_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_AR_LIB_LOADLIBS_COV         $(FLAGS_VENDOR_AR_LIB_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_STRIP_EXE                   $(FLAGS_VENDOR_STRIP_EXE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_STRIP_LIB                   $(FLAGS_VENDOR_STRIP_LIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_VENDOR_STRIP_SHLIB                 $(FLAGS_VENDOR_STRIP_SHLIB)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) BIN_PURIFY_CC                            $(BIN_PURIFY_CC)"
	@echo "$(BS_INFO_PREFIX) BIN_PURIFY_CXX                           $(BIN_PURIFY_CXX)"
	@echo "$(BS_INFO_PREFIX) BIN_PURIFY_AS                            $(BIN_PURIFY_AS)"
	@echo "$(BS_INFO_PREFIX) BIN_PURIFY_CPP                           $(BIN_PURIFY_CPP)"
	@echo "$(BS_INFO_PREFIX) BIN_PURIFY_AR                            $(BIN_PURIFY_AR)"
	@echo "$(BS_INFO_PREFIX) BIN_PURIFY_LD                            $(BIN_PURIFY_LD)"
	@echo "$(BS_INFO_PREFIX) BIN_PURIFY_STRIP                         $(BIN_PURIFY_STRIP)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CC                          $(FLAGS_PURIFY_CC)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CC_DEP                      $(FLAGS_PURIFY_CC_DEP)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CC_OPT                      $(FLAGS_PURIFY_CC_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CC_DBG                      $(FLAGS_PURIFY_CC_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CC_PROFILE                  $(FLAGS_PURIFY_CC_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CC_COV                      $(FLAGS_PURIFY_CC_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CXX                         $(FLAGS_PURIFY_CXX)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CXX_DEP                     $(FLAGS_PURIFY_CXX_DEP)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CXX_OPT                     $(FLAGS_PURIFY_CXX_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CXX_DBG                     $(FLAGS_PURIFY_CXX_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CXX_PROFILE                 $(FLAGS_PURIFY_CXX_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_CXX_COV                     $(FLAGS_PURIFY_CXX_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AS                          $(FLAGS_PURIFY_AS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AS_DEP                      $(FLAGS_PURIFY_AS_DEP)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AS_OPT                      $(FLAGS_PURIFY_AS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AS_DBG                      $(FLAGS_PURIFY_AS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AS_PROFILE                  $(FLAGS_PURIFY_AS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AS_COV                      $(FLAGS_PURIFY_AS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_EXE                      $(FLAGS_PURIFY_LD_EXE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_EXE_OPT                  $(FLAGS_PURIFY_LD_EXE_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_EXE_DBG                  $(FLAGS_PURIFY_LD_EXE_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_EXE_PROFILE              $(FLAGS_PURIFY_LD_EXE_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_EXE_COV                  $(FLAGS_PURIFY_LD_EXE_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_EXE_LOADLIBS             $(FLAGS_PURIFY_LD_EXE_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_EXE_LOADLIBS_OPT         $(FLAGS_PURIFY_LD_EXE_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_EXE_LOADLIBS_DBG         $(FLAGS_PURIFY_LD_EXE_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_EXE_LOADLIBS_PROFILE     $(FLAGS_PURIFY_LD_EXE_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_EXE_LOADLIBS_COV         $(FLAGS_PURIFY_LD_EXE_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_SHLIB                    $(FLAGS_PURIFY_LD_SHLIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_SHLIB_OPT                $(FLAGS_PURIFY_LD_SHLIB_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_SHLIB_DBG                $(FLAGS_PURIFY_LD_SHLIB_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_SHLIB_PROFILE            $(FLAGS_PURIFY_LD_SHLIB_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_SHLIB_COV                $(FLAGS_PURIFY_LD_SHLIB_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_SHLIB_LOADLIBS           $(FLAGS_PURIFY_LD_SHLIB_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_SHLIB_LOADLIBS_OPT       $(FLAGS_PURIFY_LD_SHLIB_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_SHLIB_LOADLIBS_DBG       $(FLAGS_PURIFY_LD_SHLIB_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_SHLIB_LOADLIBS_PROFILE   $(FLAGS_PURIFY_LD_SHLIB_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_SHLIB_LOADLIBS_COV       $(FLAGS_PURIFY_LD_SHLIB_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_INCOBJ                   $(FLAGS_PURIFY_LD_INCOBJ)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_INCOBJ_OPT               $(FLAGS_PURIFY_LD_INCOBJ_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_INCOBJ_DBG               $(FLAGS_PURIFY_LD_INCOBJ_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_INCOBJ_PROFILE           $(FLAGS_PURIFY_LD_INCOBJ_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_INCOBJ_COV               $(FLAGS_PURIFY_LD_INCOBJ_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_INCOBJ_LOADLIBS          $(FLAGS_PURIFY_LD_INCOBJ_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_OPT      $(FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_DBG      $(FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_PROFILE  $(FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_COV      $(FLAGS_PURIFY_LD_INCOBJ_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AR_LIB                      $(FLAGS_PURIFY_AR_LIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AR_LIB_OPT                  $(FLAGS_PURIFY_AR_LIB_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AR_LIB_DBG                  $(FLAGS_PURIFY_AR_LIB_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AR_LIB_PROFILE              $(FLAGS_PURIFY_AR_LIB_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AR_LIB_COV                  $(FLAGS_PURIFY_AR_LIB_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AR_LIB_LOADLIBS             $(FLAGS_PURIFY_AR_LIB_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AR_LIB_LOADLIBS_OPT         $(FLAGS_PURIFY_AR_LIB_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AR_LIB_LOADLIBS_DBG         $(FLAGS_PURIFY_AR_LIB_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AR_LIB_LOADLIBS_PROFILE     $(FLAGS_PURIFY_AR_LIB_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_AR_LIB_LOADLIBS_COV         $(FLAGS_PURIFY_AR_LIB_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_STRIP_EXE                   $(FLAGS_PURIFY_STRIP_EXE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_STRIP_LIB                   $(FLAGS_PURIFY_STRIP_LIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_PURIFY_STRIP_SHLIB                 $(FLAGS_PURIFY_STRIP_SHLIB)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_CC                                 $(FLAGS_CC)"
	@echo "$(BS_INFO_PREFIX) FLAGS_CC_OPT                             $(FLAGS_CC_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_CC_DBG                             $(FLAGS_CC_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_CC_PROFILE                         $(FLAGS_CC_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_CC_COV                             $(FLAGS_CC_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_CXX                                $(FLAGS_CXX)"
	@echo "$(BS_INFO_PREFIX) FLAGS_CXX_OPT                            $(FLAGS_CXX_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_CXX_DBG                            $(FLAGS_CXX_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_CXX_PROFILE                        $(FLAGS_CXX_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_CXX_COV                            $(FLAGS_CXX_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_AS                                 $(FLAGS_AS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AS_OPT                             $(FLAGS_AS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AS_DBG                             $(FLAGS_AS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AS_PROFILE                         $(FLAGS_AS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AC_COV                             $(FLAGS_AS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_EXE                             $(FLAGS_LD_EXE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_EXE_OPT                         $(FLAGS_LD_EXE_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_EXE_DBG                         $(FLAGS_LD_EXE_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_EXE_PROFILE                     $(FLAGS_LD_EXE_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_EXE_COV                         $(FLAGS_LD_EXE_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_EXE_LOADLIBS                    $(FLAGS_LD_EXE_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_EXE_LOADLIBS_OPT                $(FLAGS_LD_EXE_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_EXE_LOADLIBS_DBG                $(FLAGS_LD_EXE_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_EXE_LOADLIBS_PROFILE            $(FLAGS_LD_EXE_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_EXE_LOADLIBS_COV                $(FLAGS_LD_EXE_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_SHLIB                           $(FLAGS_LD_SHLIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_OPT                       $(FLAGS_LD_SHLIB_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_DBG                       $(FLAGS_LD_SHLIB_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_PROFILE                   $(FLAGS_LD_SHLIB_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_COV                       $(FLAGS_LD_SHLIB_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_LOADLIBS                  $(FLAGS_LD_SHLIB_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_LOADLIBS_OPT              $(FLAGS_LD_SHLIB_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_LOADLIBS_DBG              $(FLAGS_LD_SHLIB_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_LOADLIBS_PROFILE          $(FLAGS_LD_SHLIB_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_SHLIB_LOADLIBS_COV              $(FLAGS_LD_SHLIB_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ                          $(FLAGS_LD_INCOBJ)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_OPT                      $(FLAGS_LD_INCOBJ_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_DBG                      $(FLAGS_LD_INCOBJ_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_PROFILE                  $(FLAGS_LD_INCOBJ_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_COV                      $(FLAGS_LD_INCOBJ_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_LOADLIBS                 $(FLAGS_LD_INCOBJ_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_LOADLIBS_OPT             $(FLAGS_LD_INCOBJ_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_LOADLIBS_DBG             $(FLAGS_LD_INCOBJ_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_LOADLIBS_PROFILE         $(FLAGS_LD_INCOBJ_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LD_INCOBJ_LOADLIBS_COV             $(FLAGS_LD_INCOBJ_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_AR_LIB                             $(FLAGS_AR_LIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AR_LIB_OPT                         $(FLAGS_AR_LIB_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AR_LIB_DBG                         $(FLAGS_AR_LIB_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AR_LIB_PROFILE                     $(FLAGS_AR_LIB_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AR_LIB_COV                         $(FLAGS_AR_LIB_COV)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AR_LIB_LOADLIBS                    $(FLAGS_AR_LIB_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AR_LIB_LOADLIBS_OPT                $(FLAGS_AR_LIB_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AR_LIB_LOADLIBS_DBG                $(FLAGS_AR_LIB_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AR_LIB_LOADLIBS_PROFILE            $(FLAGS_AR_LIB_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_AR_LIB_LOADLIBS_COV                $(FLAGS_AR_LIB_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) FLAGS_STRIP_EXE                          $(FLAGS_STRIP_EXE)"
	@echo "$(BS_INFO_PREFIX) FLAGS_STRIP_LIB                          $(FLAGS_STRIP_LIB)"
	@echo "$(BS_INFO_PREFIX) FLAGS_STRIP_SHLIB                        $(FLAGS_STRIP_SHLIB)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) OBJ_CC_TARGETS                           $(OBJ_CC_TARGETS)"
	@echo "$(BS_INFO_PREFIX) OBJ_CXX_TARGETS                          $(OBJ_CXX_TARGETS)"
	@echo "$(BS_INFO_PREFIX) OBJ_AS_TARGETS                           $(OBJ_AS_TARGETS)"
	@echo "$(BS_INFO_PREFIX) OBJ_INC_TARGETS                          $(OBJ_INC_TARGETS)"
	@echo "$(BS_INFO_PREFIX) EXE_TARGETS                              $(EXE_TARGETS)"
	@echo "$(BS_INFO_PREFIX) LIB_TARGETS                              $(LIB_TARGETS)"
	@echo "$(BS_INFO_PREFIX) SHLIB_TARGETS                            $(SHLIB_TARGETS)"



nativecode_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning native code targets..."


#
# EXE linked targets
#
_EXE_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(sort $(EXE_TARGETS)))
_EXE_DEP_GENERATION_TARGETS=$(addprefix _EXE_DEP_,$(EXE_TARGETS))
_EXE_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/nativecode_depend_exe.mk

# These need to be above the object generation rules below.
_EXE_OBJ_TARGETS=$(foreach t,$(EXE_TARGETS),$(if $($(t)_OBJS),$($(t)_OBJS),$(t).o))
OBJ_CC_TARGETS+=$(call filterobjlist_only_cc,$(_EXE_OBJ_TARGETS))
OBJ_CXX_TARGETS+=$(call filterobjlist_only_cxx,$(_EXE_OBJ_TARGETS))
OBJ_AS_TARGETS+=$(call filterobjlist_only_as,$(_EXE_OBJ_TARGETS))


ifneq ($(strip $(EXE_TARGETS)),)
-include $(_EXE_DEPEND_FILE)

nativecode_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning native code EXE targets"
	$(BIN_RM) -f $(_EXE_TARGETS)
endif


$(_EXE_DEPEND_FILE): _EXE_DEP_PREP $(_EXE_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _EXE_DEP_PREP $(_EXE_DEP_GENERATION_TARGETS)



_EXE_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_EXE_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_EXE_DEPEND_FILE))
	echo "##" > $(_EXE_DEPEND_FILE)
	echo "## Auto generated depend file for EXE linked objects" >> $(_EXE_DEPEND_FILE)
	echo "##" >> $(_EXE_DEPEND_FILE)


_EXE_DEP_%:
_EXE_DEP_%: _EXE=$(BS_ARCH_TARGET_DIR)/$(*)
_EXE_DEP_%: _OBJ=$(addprefix $(BS_ARCH_TARGET_DIR)/,$($*_OBJS))
_EXE_DEP_%: _RAWOBJ=$($*_RAWOBJS)
_EXE_DEP_%: _DEP=$($*_DEP)
_EXE_DEP_%:
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for EXE linked target $(*) "
	@echo "## EXE target: $(*) $(_EXE)" >> $(_EXE_DEPEND_FILE)
	@echo "$(_EXE): $(_OBJ)" >> $(_EXE_DEPEND_FILE)
	@echo "$(_EXE): $(_RAWOBJ)" >> $(_EXE_DEPEND_FILE)
	@echo "$(_EXE): $(_DEP)" >> $(_EXE_DEPEND_FILE)
	@echo "" >> $(_EXE_DEPEND_FILE)




$(_EXE_TARGETS):
$(_EXE_TARGETS): _T=$(notdir $@)
$(_EXE_TARGETS):
$(_EXE_TARGETS): _TC=$(if $($(_T)_TOOLCHAIN),$($(_T)_TOOLCHAIN),$(NC_CONTROL_TOOLCHAIN))
$(_EXE_TARGETS): _LD=$(if $($(_T)_LD),$($(_T)_LD),$(BIN_$(_TC)_LD))
$(_EXE_TARGETS): _STRIP=$(if $($(_T)_STRIP),$($(_T)_STRIP),$(BIN_$(_TC)_STRIP))
$(_EXE_TARGETS):
$(_EXE_TARGETS): _OBJS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$($(_T)_OBJS))
$(_EXE_TARGETS): _RAWOBJS=$($(_T)_RAWOBJS)
$(_EXE_TARGETS):
$(_EXE_TARGETS): _T_LDFLAGS=$(if $($(_T)_LDFLAGS),$($(_T)_LDFLAGS),$(FLAGS_$(_TC)_LD_EXE) $(FLAGS_LD_EXE))
$(_EXE_TARGETS): _T_LDFLAGS_OPT=$(if $($(_T)_LDFLAGS_OPT),$($(_T)_LDFLAGS_OPT),$(FLAGS_$(_TC)_LD_EXE_OPT) $(FLAGS_LD_EXE_OPT))
$(_EXE_TARGETS): _T_LDFLAGS_DBG=$(if $($(_T)_LDFLAGS_DBG),$($(_T)_LDFLAGS_DBG),$(FLAGS_$(_TC)_LD_EXE_DBG) $(FLAGS_LD_EXE_DBG))
$(_EXE_TARGETS): _T_LDFLAGS_PROFILE=$(if $($(_T)_LDFLAGS_PROFILE),$($(_T)_LDFLAGS_PROFILE),$(FLAGS_$(_TC)_LD_EXE_PROFILE) $(FLAGS_LD_EXE_PROFILE))
$(_EXE_TARGETS): _T_LDFLAGS_COV=$(if $($(_T)_LDFLAGS_COV),$($(_T)_LDFLAGS_COV),$(FLAGS_$(_TC)_LD_EXE_COV) $(FLAGS_LD_EXE_COV))
$(_EXE_TARGETS):
$(_EXE_TARGETS): _T_LDFLAGS_LOADLIBS=$(if $($(_T)_LDFLAGS_LOADLIBS),$($(_T)_LDFLAGS_LOADLIBS),$(FLAGS_$(_TC)_LD_EXE_LOADLIBS) $(FLAGS_LD_EXE_LOADLIBS))
$(_EXE_TARGETS): _T_LDFLAGS_LOADLIBS_OPT=$(if $($(_T)_LDFLAGS_LOADLIBS_OPT),$($(_T)_LDFLAGS_LOADLIBS_OPT),$(FLAGS_$(_TC)_LD_EXE_LOADLIBS_OPT) $(FLAGS_LD_EXE_LOADLIBS_OPT))
$(_EXE_TARGETS): _T_LDFLAGS_LOADLIBS_DBG=$(if $($(_T)_LDFLAGS_LOADLIBS_DBG),$($(_T)_LDFLAGS_LOADLIBS_DBG),$(FLAGS_$(_TC)_LD_EXE_LOADLIBS_DBG) $(FLAGS_LD_EXE_LOADLIBS_DBG))
$(_EXE_TARGETS): _T_LDFLAGS_LOADLIBS_PROFILE=$(if $($(_T)_LDFLAGS_LOADLIBS_PROFILE),$($(_T)_LDFLAGS_LOADLIBS_PROFILE),$(FLAGS_$(_TC)_LD_EXE_LOADLIBS_PROFILE) $(FLAGS_LD_EXE_LOADLIBS_PROFILE))
$(_EXE_TARGETS): _T_LDFLAGS_LOADLIBS_COV=$(if $($(_T)_LDFLAGS_LOADLIBS_COV),$($(_T)_LDFLAGS_LOADLIBS_COV),$(FLAGS_$(_TC)_LD_EXE_LOADLIBS_COV) $(FLAGS_LD_EXE_LOADLIBS_COV))
$(_EXE_TARGETS):
$(_EXE_TARGETS):
$(_EXE_TARGETS): _LDFLAGS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_LDFLAGS_OPT))
$(_EXE_TARGETS): _LDFLAGS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_LDFLAGS_DBG))
$(_EXE_TARGETS): _LDFLAGS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_LDFLAGS_PROFILE))
$(_EXE_TARGETS): _LDFLAGS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_LDFLAGS_COV))
$(_EXE_TARGETS):
$(_EXE_TARGETS): _LDFLAGS_LOADLIBS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_LDFLAGS_LOADLIBS_OPT))
$(_EXE_TARGETS): _LDFLAGS_LOADLIBS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_LDFLAGS_LOADLIBS_DBG))
$(_EXE_TARGETS): _LDFLAGS_LOADLIBS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_LDFLAGS_LOADLIBS_PROFILE))
$(_EXE_TARGETS): _LDFLAGS_LOADLIBS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_LDFLAGS_LOADLIBS_COV))
$(_EXE_TARGETS):
$(_EXE_TARGETS):
$(_EXE_TARGETS): _LDFLAGS=$(_T_LDFLAGS) $(_LDFLAGS_OPT) $(_LDFLAGS_DBG) $(_LDFLAGS_PROFILE) $(_LDFLAGS_COV)
$(_EXE_TARGETS): _LDFLAGS_LOADLIBS=$(_T_LDFLAGS_LOADLIBS) $(_LDFLAGS_LOADLIBS_OPT) $(_LDFLAGS_LOADLIBS_DBG) $(_LDFLAGS_LOADLIBS_PROFILE) $(_LDFLAGS_LOADLIBS_COV)
$(_EXE_TARGETS):
$(_EXE_TARGETS):
$(_EXE_TARGETS): _STRIP_FLAGS=$(if $($(_T)_STRIPFLAGS),$($(_T)_STRIPFLAGS),$(FLAGS_$(_TC)_STRIP_EXE) $(FLAGS_STRIP_EXE))
$(_EXE_TARGETS): _STRIP_CMD=$(if $(filter 1,$(NC_CONTROL_STRIP)),$(_STRIP) $(_STRIP_FLAGS) $@,)
$(_EXE_TARGETS):
$(_EXE_TARGETS):
	@echo
	@echo "$(BS_INFO_PREFIX)  Linking EXE target $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                    :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                    :  $@"
	@echo "$(BS_INFO_PREFIX)      Toolchain                      :  $(_TC)"
	@echo "$(BS_INFO_PREFIX)      Linker                         :  $(_LD)"
	@echo "$(BS_INFO_PREFIX)      Strip Command                  :  $(_STRIP_CMD)"
	@echo "$(BS_INFO_PREFIX)      Objects                        :  $(_OBJS)"
	@echo "$(BS_INFO_PREFIX)      Raw Objects                    :  $(_RAWOBJS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Base)          :  $(_T_LDFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Optimize)      :  $(_T_LDFLAGS_OPT)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Debug)         :  $(_T_LDFLAGS_DBG)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Profile)       :  $(_T_LDFLAGS_PROFILE)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Coverage)      :  $(_T_LDFLAGS_COV)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Base)          :  $(_T_LDFLAGS_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Optimize)      :  $(_T_LDFLAGS_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Debug)         :  $(_T_LDFLAGS_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Profile)       :  $(_T_LDFLAGS_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Coverage)      :  $(_T_LDFLAGS_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Current Build) :  $(_LDFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Current Build) :  $(_LDFLAGS_LOADLIBS)"
	@echo
	$(_LD) -o $@ $(_LDFLAGS) $(_OBJS) $(_RAWOBJS) $(_LDFLAGS_LOADLIBS)
	$(_STRIP_CMD)


#
# Static lib linked targets
#
_LIB_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(sort $(LIB_TARGETS)))
_LIB_DEP_GENERATION_TARGETS=$(addprefix _LIB_DEP_,$(LIB_TARGETS))
_LIB_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/nativecode_depend_lib.mk

# These need to be above the object generation rules below.
_LIB_OBJ_TARGETS=$(foreach t,$(LIB_TARGETS),$(if $($(t)_OBJS),$($(t)_OBJS),$(t).o))
OBJ_CC_TARGETS+=$(call filterobjlist_only_cc,$(_LIB_OBJ_TARGETS))
OBJ_CXX_TARGETS+=$(call filterobjlist_only_cxx,$(_LIB_OBJ_TARGETS))
OBJ_AS_TARGETS+=$(call filterobjlist_only_as,$(_LIB_OBJ_TARGETS))


ifneq ($(strip $(LIB_TARGETS)),)
-include $(_LIB_DEPEND_FILE)

nativecode_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning native code Static Library targets"
	$(BIN_RM) -f $(_LIB_TARGETS)
endif


$(_LIB_DEPEND_FILE): _LIB_DEP_PREP $(_LIB_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _LIB_DEP_PREP $(_LIB_DEP_GENERATION_TARGETS)



_LIB_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_LIB_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_LIB_DEPEND_FILE))
	echo "##" > $(_LIB_DEPEND_FILE)
	echo "## Auto generated depend file for Static Library linked objects" >> $(_LIB_DEPEND_FILE)
	echo "##" >> $(_LIB_DEPEND_FILE)


_LIB_DEP_%:
_LIB_DEP_%: _LIB=$(BS_ARCH_TARGET_DIR)/$(*)
_LIB_DEP_%: _OBJ=$(addprefix $(BS_ARCH_TARGET_DIR)/,$($*_OBJS))
_LIB_DEP_%: _RAWOBJ=$($*_RAWOBJS)
_LIB_DEP_%: _DEP=$($*_DEP)
_LIB_DEP_%:
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for Static Library linked target $(*) "
	@echo "## LIB target: $(*) $(_LIB)" >> $(_LIB_DEPEND_FILE)
	@echo "$(_LIB): $(_OBJ)" >> $(_LIB_DEPEND_FILE)
	@echo "$(_LIB): $(_RAWOBJ)" >> $(_LIB_DEPEND_FILE)
	@echo "$(_LIB): $(_DEP)" >> $(_LIB_DEPEND_FILE)
	@echo "" >> $(_LIB_DEPEND_FILE)




$(_LIB_TARGETS):
$(_LIB_TARGETS): _T=$(notdir $@)
$(_LIB_TARGETS):
$(_LIB_TARGETS): _TC=$(if $($(_T)_TOOLCHAIN),$($(_T)_TOOLCHAIN),$(NC_CONTROL_TOOLCHAIN))
$(_LIB_TARGETS): _AR=$(if $($(_T)_AR),$($(_T)_AR),$(BIN_$(_TC)_AR))
$(_LIB_TARGETS): _STRIP=$(if $($(_T)_STRIP),$($(_T)_STRIP),$(BIN_$(_TC)_STRIP))
$(_LIB_TARGETS):
$(_LIB_TARGETS): _OBJS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$($(_T)_OBJS))
$(_LIB_TARGETS): _RAWOBJS=$($(_T)_RAWOBJS)
$(_LIB_TARGETS):
$(_LIB_TARGETS): _T_ARFLAGS=$(if $($(_T)_ARFLAGS),$($(_T)_ARFLAGS),$(FLAGS_$(_TC)_AR_LIB) $(FLAGS_AR_LIB))
$(_LIB_TARGETS): _T_ARFLAGS_OPT=$(if $($(_T)_ARFLAGS_OPT),$($(_T)_ARFLAGS_OPT),$(FLAGS_$(_TC)_AR_LIB_OPT) $(FLAGS_AR_LIB_OPT))
$(_LIB_TARGETS): _T_ARFLAGS_DBG=$(if $($(_T)_ARFLAGS_DBG),$($(_T)_ARFLAGS_DBG),$(FLAGS_$(_TC)_AR_LIB_DBG) $(FLAGS_AR_LIB_DBG))
$(_LIB_TARGETS): _T_ARFLAGS_PROFILE=$(if $($(_T)_ARFLAGS_PROFILE),$($(_T)_ARFLAGS_PROFILE),$(FLAGS_$(_TC)_AR_LIB_PROFILE) $(FLAGS_AR_LIB_PROFILE))
$(_LIB_TARGETS): _T_ARFLAGS_COV=$(if $($(_T)_ARFLAGS_COV),$($(_T)_ARFLAGS_COV),$(FLAGS_$(_TC)_AR_LIB_COV) $(FLAGS_AR_LIB_COV))
$(_LIB_TARGETS):
$(_LIB_TARGETS): _T_ARFLAGS_LOADLIBS=$(if $($(_T)_ARFLAGS_LOADLIBS),$($(_T)_ARFLAGS_LOADLIBS),$(FLAGS_$(_TC)_AR_LIB_LOADLIBS) $(FLAGS_AR_LIB_LOADLIBS))
$(_LIB_TARGETS): _T_ARFLAGS_LOADLIBS_OPT=$(if $($(_T)_ARFLAGS_LOADLIBS_OPT),$($(_T)_ARFLAGS_LOADLIBS_OPT),$(FLAGS_$(_TC)_AR_LIB_LOADLIBS_OPT) $(FLAGS_AR_LIB_LOADLIBS_OPT))
$(_LIB_TARGETS): _T_ARFLAGS_LOADLIBS_DBG=$(if $($(_T)_ARFLAGS_LOADLIBS_DBG),$($(_T)_ARFLAGS_LOADLIBS_DBG),$(FLAGS_$(_TC)_AR_LIB_LOADLIBS_DBG) $(FLAGS_AR_LIB_LOADLIBS_DBG))
$(_LIB_TARGETS): _T_ARFLAGS_LOADLIBS_PROFILE=$(if $($(_T)_ARFLAGS_LOADLIBS_PROFILE),$($(_T)_ARFLAGS_LOADLIBS_PROFILE),$(FLAGS_$(_TC)_AR_LIB_LOADLIBS_PROFILE) $(FLAGS_AR_LIB_LOADLIBS_PROFILE))
$(_LIB_TARGETS): _T_ARFLAGS_LOADLIBS_COV=$(if $($(_T)_ARFLAGS_LOADLIBS_COV),$($(_T)_ARFLAGS_LOADLIBS_COV),$(FLAGS_$(_TC)_AR_LIB_LOADLIBS_COV) $(FLAGS_AR_LIB_LOADLIBS_COV))
$(_LIB_TARGETS):
$(_LIB_TARGETS):
$(_LIB_TARGETS): _ARFLAGS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_ARFLAGS_OPT))
$(_LIB_TARGETS): _ARFLAGS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_ARFLAGS_DBG))
$(_LIB_TARGETS): _ARFLAGS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_ARFLAGS_PROFILE))
$(_LIB_TARGETS): _ARFLAGS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_ARFLAGS_COV))
$(_LIB_TARGETS):
$(_LIB_TARGETS): _ARFLAGS_LOADLIBS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_ARFLAGS_LOADLIBS_OPT))
$(_LIB_TARGETS): _ARFLAGS_LOADLIBS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_ARFLAGS_LOADLIBS_DBG))
$(_LIB_TARGETS): _ARFLAGS_LOADLIBS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_ARFLAGS_LOADLIBS_PROFILE))
$(_LIB_TARGETS): _ARFLAGS_LOADLIBS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_ARFLAGS_LOADLIBS_COV))
$(_LIB_TARGETS):
$(_LIB_TARGETS):
$(_LIB_TARGETS): _ARFLAGS=$(_T_ARFLAGS) $(_ARFLAGS_OPT) $(_ARFLAGS_DBG) $(_ARFLAGS_PROFILE) $(_ARFLAGS_COV)
$(_LIB_TARGETS): _ARFLAGS_LOADLIBS=$(_T_ARFLAGS_LOADLIBS) $(_ARFLAGS_LOADLIBS_OPT) $(_ARFLAGS_LOADLIBS_DBG) $(_ARFLAGS_LOADLIBS_PROFILE) $(_ARFLAGS_LOADLIBS_COV)
$(_LIB_TARGETS):
$(_LIB_TARGETS): _STRIP_FLAGS=$(if $($(_T)_STRIPFLAGS),$($(_T)_STRIPFLAGS),$(FLAGS_$(_TC)_STRIP_LIB) $(FLAGS_STRIP_LIB))
$(_LIB_TARGETS): _STRIP_CMD=$(if $(filter 1,$(NC_CONTROL_STRIP)),$(_STRIP) $(_STRIP_FLAGS) $@,)
$(_LIB_TARGETS):
	@echo
	@echo "$(BS_INFO_PREFIX)  Linking Static Library target $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                    :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                    :  $@"
	@echo "$(BS_INFO_PREFIX)      Toolchain                      :  $(_TC)"
	@echo "$(BS_INFO_PREFIX)      Archiver                       :  $(_AR)"
	@echo "$(BS_INFO_PREFIX)      Strip Command                  :  $(_STRIP_CMD)"
	@echo "$(BS_INFO_PREFIX)      Objects                        :  $(_OBJS)"
	@echo "$(BS_INFO_PREFIX)      Raw Objects                    :  $(_RAWOBJS)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS          (Base)          :  $(_T_ARFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS          (Optimize)      :  $(_T_ARFLAGS_OPT)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS          (Debug)         :  $(_T_ARFLAGS_DBG)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS          (Profile)       :  $(_T_ARFLAGS_PROFILE)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS          (Coverage)      :  $(_T_ARFLAGS_COV)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS_LOADLIBS (Base)          :  $(_T_ARFLAGS_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS_LOADLIBS (Optimize)      :  $(_T_ARFLAGS_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS_LOADLIBS (Debug)         :  $(_T_ARFLAGS_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS_LOADLIBS (Profile)       :  $(_T_ARFLAGS_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS_LOADLIBS (Coverage)      :  $(_T_ARFLAGS_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS          (Current Build) :  $(_ARFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Target ARFLAGS_LOADLIBS (Current Build) :  $(_ARFLAGS_LOADLIBS)"
	@echo
	$(_AR) $(_ARFLAGS) $@ $(_OBJS) $(_RAWOBJS) $(_ARFLAGS_LOADLIBS)
	$(_STRIP_CMD)




#
# Shared lib linked targets
#
_SHLIB_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(sort $(SHLIB_TARGETS)))
_SHLIB_DEP_GENERATION_TARGETS=$(addprefix _SHLIB_DEP_,$(SHLIB_TARGETS))
_SHLIB_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/nativecode_depend_shlib.mk

# These need to be above the object generation rules below.
_SHLIB_OBJ_TARGETS=$(foreach t,$(SHLIB_TARGETS),$(if $($(t)_OBJS),$($(t)_OBJS),$(t).o))
OBJ_CC_TARGETS+=$(call filterobjlist_only_cc,$(_SHLIB_OBJ_TARGETS))
OBJ_CXX_TARGETS+=$(call filterobjlist_only_cxx,$(_SHLIB_OBJ_TARGETS))
OBJ_AS_TARGETS+=$(call filterobjlist_only_as,$(_SHLIB_OBJ_TARGETS))


ifneq ($(strip $(SHLIB_TARGETS)),)

-include $(_SHLIB_DEPEND_FILE)
nativecode_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning native code Shared Library targets"
	$(BIN_RM) -f $(_SHLIB_TARGETS)
endif


$(_SHLIB_DEPEND_FILE): _SHLIB_DEP_PREP $(_SHLIB_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _SHLIB_DEP_PREP $(_SHLIB_DEP_GENERATION_TARGETS)



_SHLIB_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_SHLIB_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_SHLIB_DEPEND_FILE))
	echo "##" > $(_SHLIB_DEPEND_FILE)
	echo "## Auto generated depend file for Shared Library linked objects" >> $(_SHLIB_DEPEND_FILE)
	echo "##" >> $(_SHLIB_DEPEND_FILE)


_SHLIB_DEP_%:
_SHLIB_DEP_%: _SHLIB=$(BS_ARCH_TARGET_DIR)/$(*)
_SHLIB_DEP_%: _OBJ=$(addprefix $(BS_ARCH_TARGET_DIR)/,$($*_OBJS))
_SHLIB_DEP_%: _RAWOBJ=$($*_RAWOBJS)
_SHLIB_DEP_%: _DEP=$($*_DEP)
_SHLIB_DEP_%:
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for Shared Library linked target $(*) "
	@echo "## SHLIB target: $(*) $(_SHLIB)" >> $(_SHLIB_DEPEND_FILE)
	@echo "$(_SHLIB): $(_OBJ)" >> $(_SHLIB_DEPEND_FILE)
	@echo "$(_SHLIB): $(_RAWOBJ)" >> $(_SHLIB_DEPEND_FILE)
	@echo "$(_SHLIB): $(_DEP)" >> $(_SHLIB_DEPEND_FILE)
	@echo "" >> $(_SHLIB_DEPEND_FILE)




$(_SHLIB_TARGETS):
$(_SHLIB_TARGETS): _T=$(notdir $@)
$(_SHLIB_TARGETS):
$(_SHLIB_TARGETS): _TC=$(if $($(_T)_TOOLCHAIN),$($(_T)_TOOLCHAIN),$(NC_CONTROL_TOOLCHAIN))
$(_SHLIB_TARGETS): _LD=$(if $($(_T)_LD),$($(_T)_LD),$(BIN_$(_TC)_LD))
$(_SHLIB_TARGETS): _STRIP=$(if $($(_T)_STRIP),$($(_T)_STRIP),$(BIN_$(_TC)_STRIP))
$(_SHLIB_TARGETS):
$(_SHLIB_TARGETS): _OBJS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$($(_T)_OBJS))
$(_SHLIB_TARGETS): _RAWOBJS=$($(_T)_RAWOBJS)
$(_SHLIB_TARGETS):
$(_SHLIB_TARGETS): _T_LDFLAGS=$(if $($(_T)_LDFLAGS),$($(_T)_LDFLAGS),$(FLAGS_$(_TC)_LD_SHLIB) $(FLAGS_LD_SHLIB))
$(_SHLIB_TARGETS): _T_LDFLAGS_OPT=$(if $($(_T)_LDFLAGS_OPT),$($(_T)_LDFLAGS_OPT),$(FLAGS_$(_TC)_LD_SHLIB_OPT) $(FLAGS_LD_SHLIB_OPT))
$(_SHLIB_TARGETS): _T_LDFLAGS_DBG=$(if $($(_T)_LDFLAGS_DBG),$($(_T)_LDFLAGS_DBG),$(FLAGS_$(_TC)_LD_SHLIB_DBG) $(FLAGS_LD_SHLIB_DBG))
$(_SHLIB_TARGETS): _T_LDFLAGS_PROFILE=$(if $($(_T)_LDFLAGS_PROFILE),$($(_T)_LDFLAGS_PROFILE),$(FLAGS_$(_TC)_LD_SHLIB_PROFILE) $(FLAGS_LD_SHLIB_PROFILE))
$(_SHLIB_TARGETS): _T_LDFLAGS_COV=$(if $($(_T)_LDFLAGS_COV),$($(_T)_LDFLAGS_COV),$(FLAGS_$(_TC)_LD_SHLIB_COV) $(FLAGS_LD_SHLIB_COV))
$(_SHLIB_TARGETS):
$(_SHLIB_TARGETS): _T_LDFLAGS_LOADLIBS=$(if $($(_T)_LDFLAGS_LOADLIBS),$($(_T)_LDFLAGS_LOADLIBS),$(FLAGS_$(_TC)_LD_SHLIB_LOADLIBS) $(FLAGS_LD_SHLIB_LOADLIBS))
$(_SHLIB_TARGETS): _T_LDFLAGS_LOADLIBS_OPT=$(if $($(_T)_LDFLAGS_LOADLIBS_OPT),$($(_T)_LDFLAGS_LOADLIBS_OPT),$(FLAGS_$(_TC)_LD_SHLIB_LOADLIBS_OPT) $(FLAGS_LD_SHLIB_LOADLIBS_OPT))
$(_SHLIB_TARGETS): _T_LDFLAGS_LOADLIBS_DBG=$(if $($(_T)_LDFLAGS_LOADLIBS_DBG),$($(_T)_LDFLAGS_LOADLIBS_DBG),$(FLAGS_$(_TC)_LD_SHLIB_LOADLIBS_DBG) $(FLAGS_LD_SHLIB_LOADLIBS_DBG))
$(_SHLIB_TARGETS): _T_LDFLAGS_LOADLIBS_PROFILE=$(if $($(_T)_LDFLAGS_LOADLIBS_PROFILE),$($(_T)_LDFLAGS_LOADLIBS_PROFILE),$(FLAGS_$(_TC)_LD_SHLIB_LOADLIBS_PROFILE) $(FLAGS_LD_SHLIB_LOADLIBS_PROFILE))
$(_SHLIB_TARGETS): _T_LDFLAGS_LOADLIBS_COV=$(if $($(_T)_LDFLAGS_LOADLIBS_COV),$($(_T)_LDFLAGS_LOADLIBS_COV),$(FLAGS_$(_TC)_LD_SHLIB_LOADLIBS_COV) $(FLAGS_LD_SHLIB_LOADLIBS_COV))
$(_SHLIB_TARGETS):
$(_SHLIB_TARGETS):
$(_SHLIB_TARGETS): _LDFLAGS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_LDFLAGS_OPT))
$(_SHLIB_TARGETS): _LDFLAGS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_LDFLAGS_DBG))
$(_SHLIB_TARGETS): _LDFLAGS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_LDFLAGS_PROFILE))
$(_SHLIB_TARGETS): _LDFLAGS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_LDFLAGS_COV))
$(_SHLIB_TARGETS):
$(_SHLIB_TARGETS): _LDFLAGS_LOADLIBS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_LDFLAGS_LOADLIBS_OPT))
$(_SHLIB_TARGETS): _LDFLAGS_LOADLIBS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_LDFLAGS_LOADLIBS_DBG))
$(_SHLIB_TARGETS): _LDFLAGS_LOADLIBS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_LDFLAGS_LOADLIBS_PROFILE))
$(_SHLIB_TARGETS): _LDFLAGS_LOADLIBS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_LDFLAGS_LOADLIBS_COV))
$(_SHLIB_TARGETS):
$(_SHLIB_TARGETS):
$(_SHLIB_TARGETS): _LDFLAGS=$(_T_LDFLAGS) $(_LDFLAGS_OPT) $(_LDFLAGS_DBG) $(_LDFLAGS_PROFILE) $(_T_LDFLAGS_COV)
$(_SHLIB_TARGETS): _LDFLAGS_LOADLIBS=$(_T_LDFLAGS_LOADLIBS) $(_LDFLAGS_LOADLIBS_OPT) $(_LDFLAGS_LOADLIBS_DBG) $(_LDFLAGS_LOADLIBS_PROFILE) $(_LDFLAGS_LOADLIBS_COV) 
$(_SHLIB_TARGETS):
$(_SHLIB_TARGETS): _STRIP_FLAGS=$(if $($(_T)_STRIPFLAGS),$($(_T)_STRIPFLAGS),$(FLAGS_$(_TC)_STRIP_SHLIB) $(FLAGS_STRIP_SHLIB))
$(_SHLIB_TARGETS): _STRIP_CMD=$(if $(filter 1,$(NC_CONTROL_STRIP)),$(_STRIP) $(_STRIP_FLAGS) $@,)
$(_SHLIB_TARGETS):
	@echo
	@echo "$(BS_INFO_PREFIX)  Linking Shared Library target $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                    :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                    :  $@"
	@echo "$(BS_INFO_PREFIX)      Toolchain                      :  $(_TC)"
	@echo "$(BS_INFO_PREFIX)      Linker                         :  $(_LD)"
	@echo "$(BS_INFO_PREFIX)      Strip Command                  :  $(_STRIP_CMD)"
	@echo "$(BS_INFO_PREFIX)      Objects                        :  $(_OBJS)"
	@echo "$(BS_INFO_PREFIX)      Raw Objects                    :  $(_RAWOBJS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Base)          :  $(_T_LDFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Optimize)      :  $(_T_LDFLAGS_OPT)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Debug)         :  $(_T_LDFLAGS_DBG)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Profile)       :  $(_T_LDFLAGS_PROFILE)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Coverage)      :  $(_T_LDFLAGS_COV)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Base)          :  $(_T_LDFLAGS_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Optimize)      :  $(_T_LDFLAGS_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Debug)         :  $(_T_LDFLAGS_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Profile)       :  $(_T_LDFLAGS_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Coverage)      :  $(_T_LDFLAGS_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Current Build) :  $(_LDFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Current Build) :  $(_LDFLAGS_LOADLIBS)"
	@echo
	$(_LD) -o $@ $(_LDFLAGS) $(_OBJS) $(_RAWOBJS) $(_LDFLAGS_LOADLIBS)
	$(_STRIP_CMD)




#
# Incrementally linked Object targets
#
_OBJ_INC_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(sort $(OBJ_INC_TARGETS)))
_INCOBJ_DEP_GENERATION_TARGETS=$(addprefix _INCOBJ_DEP_,$(OBJ_INC_TARGETS))
_INCOBJ_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/nativecode_depend_obj_inc.mk

# These need to be above the object generation rules below.
_INCOBJ_OBJ_TARGETS=$(foreach t,$(OBJ_INC_TARGETS),$(if $($(t)_OBJS),$($(t)_OBJS),$(t).o))
OBJ_CC_TARGETS+=$(call filterobjlist_only_cc,$(_INCOBJ_OBJ_TARGETS))
OBJ_CXX_TARGETS+=$(call filterobjlist_only_cxx,$(_INCOBJ_OBJ_TARGETS))
OBJ_AS_TARGETS+=$(call filterobjlist_only_as,$(_INCOBJ_OBJ_TARGETS))


ifneq ($(strip $(OBJ_INC_TARGETS)),)
-include $(_INCOBJ_DEPEND_FILE)

nativecode_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning native code Incrementally Linked Object Target"
	$(BIN_RM) -f $(_OBJ_INC_TARGETS)
endif


$(_INCOBJ_DEPEND_FILE): _INCOBJ_DEP_PREP $(_INCOBJ_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _INCOBJ_DEP_PREP $(_INCOBJ_DEP_GENERATION_TARGETS)



_INCOBJ_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_INCOBJ_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_INCOBJ_DEPEND_FILE))
	echo "##" > $(_INCOBJ_DEPEND_FILE)
	echo "## Auto generated depend file for Incrementally Linked Object targets" >> $(_INCOBJ_DEPEND_FILE)
	echo "##" >> $(_INCOBJ_DEPEND_FILE)


_INCOBJ_DEP_%:
_INCOBJ_DEP_%: _INCOBJ=$(BS_ARCH_TARGET_DIR)/$(*)
_INCOBJ_DEP_%: _OBJ=$(addprefix $(BS_ARCH_TARGET_DIR)/,$($*_OBJS))
_INCOBJ_DEP_%: _RAWOBJ=$($*_RAWOBJS)
_INCOBJ_DEP_%: _DEP=$($*_DEP)
_INCOBJ_DEP_%:
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for Incrementally Linked Object target $(*) "
	@echo "## Incrementally Linked Object Target: $(*) $(_INCOBJ)" >> $(_INCOBJ_DEPEND_FILE)
	@echo "$(_INCOBJ): $(_OBJ)" >> $(_INCOBJ_DEPEND_FILE)
	@echo "$(_INCOBJ): $(_RAWOBJ)" >> $(_INCOBJ_DEPEND_FILE)
	@echo "$(_INCOBJ): $(_DEP)" >> $(_INCOBJ_DEPEND_FILE)
	@echo "" >> $(_INCOBJ_DEPEND_FILE)




$(_OBJ_INC_TARGETS):
$(_OBJ_INC_TARGETS): _T=$(notdir $@)
$(_OBJ_INC_TARGETS):
$(_OBJ_INC_TARGETS): _TC=$(if $($(_T)_TOOLCHAIN),$($(_T)_TOOLCHAIN),$(NC_CONTROL_TOOLCHAIN))
$(_OBJ_INC_TARGETS): _LD=$(if $($(_T)_LD),$($(_T)_LD),$(BIN_$(_TC)_LD))
$(_OBJ_INC_TARGETS):
$(_OBJ_INC_TARGETS): _OBJS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$($(_T)_OBJS))
$(_OBJ_INC_TARGETS): _RAWOBJS=$($(_T)_RAWOBJS)
$(_OBJ_INC_TARGETS):
$(_OBJ_INC_TARGETS): _T_LDFLAGS=$(if $($(_T)_LDFLAGS),$($(_T)_LDFLAGS),$(FLAGS_$(_TC)_LD_INCOBJ) $(FLAGS_LD_INCOBJ))
$(_OBJ_INC_TARGETS): _T_LDFLAGS_OPT=$(if $($(_T)_LDFLAGS_OPT),$($(_T)_LDFLAGS_OPT),$(FLAGS_$(_TC)_LD_INCOBJ_OPT) $(FLAGS_LD_INCOBJ_OPT))
$(_OBJ_INC_TARGETS): _T_LDFLAGS_DBG=$(if $($(_T)_LDFLAGS_DBG),$($(_T)_LDFLAGS_DBG),$(FLAGS_$(_TC)_LD_INCOBJ_DBG) $(FLAGS_LD_INCOBJ_DBG))
$(_OBJ_INC_TARGETS): _T_LDFLAGS_PROFILE=$(if $($(_T)_LDFLAGS_PROFILE),$($(_T)_LDFLAGS_PROFILE),$(FLAGS_$(_TC)_LD_INCOBJ_PROFILE) $(FLAGS_LD_INCOBJ_PROFILE))
$(_OBJ_INC_TARGETS): _T_LDFLAGS_COV=$(if $($(_T)_LDFLAGS_COV),$($(_T)_LDFLAGS_COV),$(FLAGS_$(_TC)_LD_INCOBJ_COV) $(FLAGS_LD_INCOBJ_COV))
$(_OBJ_INC_TARGETS):
$(_OBJ_INC_TARGETS): _T_LDFLAGS_LOADLIBS=$(if $($(_T)_LDFLAGS_LOADLIBS),$($(_T)_LDFLAGS_LOADLIBS),$(FLAGS_$(_TC)_LD_INCOBJ_LOADLIBS) $(FLAGS_LD_INCOBJ_LOADLIBS))
$(_OBJ_INC_TARGETS): _T_LDFLAGS_LOADLIBS_OPT=$(if $($(_T)_LDFLAGS_LOADLIBS_OPT),$($(_T)_LDFLAGS_LOADLIBS_OPT),$(FLAGS_$(_TC)_LD_INCOBJ_LOADLIBS_OPT) $(FLAGS_LD_INCOBJ_LOADLIBS_OPT))
$(_OBJ_INC_TARGETS): _T_LDFLAGS_LOADLIBS_DBG=$(if $($(_T)_LDFLAGS_LOADLIBS_DBG),$($(_T)_LDFLAGS_LOADLIBS_DBG),$(FLAGS_$(_TC)_LD_INCOBJ_LOADLIBS_DBG) $(FLAGS_LD_INCOBJ_LOADLIBS_DBG))
$(_OBJ_INC_TARGETS): _T_LDFLAGS_LOADLIBS_PROFILE=$(if $($(_T)_LDFLAGS_LOADLIBS_PROFILE),$($(_T)_LDFLAGS_LOADLIBS_PROFILE),$(FLAGS_$(_TC)_LD_INCOBJ_LOADLIBS_PROFILE) $(FLAGS_LD_INCOBJ_LOADLIBS_PROFILE))
$(_OBJ_INC_TARGETS): _T_LDFLAGS_LOADLIBS_COV=$(if $($(_T)_LDFLAGS_LOADLIBS_COV),$($(_T)_LDFLAGS_LOADLIBS_COV),$(FLAGS_$(_TC)_LD_INCOBJ_LOADLIBS_COV) $(FLAGS_LD_INCOBJ_LOADLIBS_COV))
$(_OBJ_INC_TARGETS):
$(_OBJ_INC_TARGETS):
$(_OBJ_INC_TARGETS): _LDFLAGS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_LDFLAGS_OPT))
$(_OBJ_INC_TARGETS): _LDFLAGS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_LDFLAGS_DBG))
$(_OBJ_INC_TARGETS): _LDFLAGS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_LDFLAGS_PROFILE))
$(_OBJ_INC_TARGETS): _LDFLAGS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_LDFLAGS_COV))
$(_OBJ_INC_TARGETS):
$(_OBJ_INC_TARGETS): _LDFLAGS_LOADLIBS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_LDFLAGS_LOADLIBS_OPT))
$(_OBJ_INC_TARGETS): _LDFLAGS_LOADLIBS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_LDFLAGS_LOADLIBS_DBG))
$(_OBJ_INC_TARGETS): _LDFLAGS_LOADLIBS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_LDFLAGS_LOADLIBS_PROFILE))
$(_OBJ_INC_TARGETS): _LDFLAGS_LOADLIBS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_LDFLAGS_LOADLIBS_COV))
$(_OBJ_INC_TARGETS):
$(_OBJ_INC_TARGETS):
$(_OBJ_INC_TARGETS): _LDFLAGS=$(_T_LDFLAGS) $(_LDFLAGS_OPT) $(_LDFLAGS_DBG) $(_LDFLAGS_PROFILE) $(_LDFLAGS_COV) 
$(_OBJ_INC_TARGETS): _LDFLAGS_LOADLIBS=$(_T_LDFLAGS_LOADLIBS) $(_LDFLAGS_LOADLIBS_OPT) $(_LDFLAGS_LOADLIBS_DBG) $(_LDFLAGS_LOADLIBS_PROFILE) $(_LDFLAGS_LOADLIBS_COV) 
$(_OBJ_INC_TARGETS):
$(_OBJ_INC_TARGETS):
	@echo
	@echo "$(BS_INFO_PREFIX)  Linking Incrementally Linked Object $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                    :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                    :  $@"
	@echo "$(BS_INFO_PREFIX)      Toolchain                      :  $(_TC)"
	@echo "$(BS_INFO_PREFIX)      Linker                         :  $(_LD)"
	@echo "$(BS_INFO_PREFIX)      Objects                        :  $(_OBJS)"
	@echo "$(BS_INFO_PREFIX)      Raw Objects                    :  $(_RAWOBJS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Base)          :  $(_T_LDFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Optimize)      :  $(_T_LDFLAGS_OPT)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Debug)         :  $(_T_LDFLAGS_DBG)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Profile)       :  $(_T_LDFLAGS_PROFILE)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Coverage)      :  $(_T_LDFLAGS_COV)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Base)          :  $(_T_LDFLAGS_LOADLIBS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Optimize)      :  $(_T_LDFLAGS_LOADLIBS_OPT)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Debug)         :  $(_T_LDFLAGS_LOADLIBS_DBG)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Profile)       :  $(_T_LDFLAGS_LOADLIBS_PROFILE)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Coverage)      :  $(_T_LDFLAGS_LOADLIBS_COV)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS          (Current Build) :  $(_LDFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Target LDFLAGS_LOADLIBS (Current Build) :  $(_LDFLAGS_LOADLIBS)"
	@echo
	$(_LD) -o $@ $(_LDFLAGS) $(_OBJS) $(_RAWOBJS) $(_LDFLAGS_LOADLIBS)





#
# Assembly Object targets
#
_OBJ_AS_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(sort $(OBJ_AS_TARGETS)))
_OBJ_AS_DEP_GENERATION_TARGETS=$(addprefix _OBJ_AS_DEP_,$(OBJ_AS_TARGETS))
_OBJ_AS_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/nativecode_depend_obj_as.mk


ifneq ($(strip $(OBJ_AS_TARGETS)),)
-include $(_OBJ_AS_DEPEND_FILE)

nativecode_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning native code Assembly Object targets"
	$(BIN_RM) -f $(_OBJ_AS_TARGETS)
endif


$(_OBJ_AS_DEPEND_FILE): _OBJ_AS_DEP_PREP $(_OBJ_AS_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _OBJ_AS_DEP_PREP $(_OBJ_AS_DEP_GENERATION_TARGETS)


_OBJ_AS_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_OBJ_AS_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_OBJ_AS_DEPEND_FILE))
	echo "##" > $(_OBJ_AS_DEPEND_FILE)
	echo "## Auto generated depend file for Assembly objects" >> $(_OBJ_AS_DEPEND_FILE)
	echo "##" >> $(_OBJ_AS_DEPEND_FILE)


_OBJ_AS_DEP_%:
_OBJ_AS_DEP_%: _OBJ=$(BS_ARCH_TARGET_DIR)/$(*)
_OBJ_AS_DEP_%: _SRC=$(if $($*_SRC),$($*_SRC),$(*:%.o=%.s))
_OBJ_AS_DEP_%: _DEP=$($*_DEP)
_OBJ_AS_DEP_%: 
_OBJ_AS_DEP_%: _TC=$(if $($*_TOOLCHAIN),$($*_TOOLCHAIN),$(NC_CONTROL_TOOLCHAIN))
_OBJ_AS_DEP_%: _T_ASFLAGS_DEP=$(FLAGS_$(_TC)_AS_DEP)
_OBJ_AS_DEP_%: _DEPAS=$(if $(_T_ASFLAGS_DEP),$(if $($*_AS),$($*_AS),$(BIN_$(_TC)_AS)),$(BIN_TRUE))
_OBJ_AS_DEP_%: 
_OBJ_AS_DEP_%: 
_OBJ_AS_DEP_%: _T_ASFLAGS         = $(if $($*_ASFLAGS),$($*_ASFLAGS),$(FLAGS_$(_TC)_AS) $(FLAGS_AS))
_OBJ_AS_DEP_%: _T_ASFLAGS_OPT     = $(if $($*_ASFLAGS_OPT),$($*_ASFLAGS_OPT),$(FLAGS_$(_TC)_AS_OPT) $(FLAGS_AS_OPT))
_OBJ_AS_DEP_%: _T_ASFLAGS_DBG     = $(if $($*_ASFLAGS_DBG),$($*_ASFLAGS_DBG),$(FLAGS_$(_TC)_AS_DBG) $(FLAGS_AS_DBG))
_OBJ_AS_DEP_%: _T_ASFLAGS_PROFILE = $(if $($*_ASFLAGS_PROFILE),$($*_ASFLAGS_PROFILE),$(FLAGS_$(_TC)_AS_PROFILE) $(FLAGS_AS_PROFILE))
_OBJ_AS_DEP_%: _T_ASFLAGS_COV = $(if $($*_ASFLAGS_COV),$($*_ASFLAGS_COV),$(FLAGS_$(_TC)_AS_COV) $(FLAGS_AS_COV))
_OBJ_AS_DEP_%:
_OBJ_AS_DEP_%: _ASFLAGS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_ASFLAGS_OPT))
_OBJ_AS_DEP_%: _ASFLAGS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_ASFLAGS_DBG))
_OBJ_AS_DEP_%: _ASFLAGS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_ASFLAGS_PROFILE))
_OBJ_AS_DEP_%: _ASFLAGS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_ASFLAGS_COV))
_OBJ_AS_DEP_%:
_OBJ_AS_DEP_%: _ASFLAGS=$(_T_ASFLAGS) $(_ASFLAGS_OPT) $(_ASFLAGS_DBG) $(_ASFLAGS_PROFILE) $(_ASFLAGS_COV) 
_OBJ_AS_DEP_%: 
_OBJ_AS_DEP_%: _SED_HACK = s?^\(.*:\)?$(BS_ARCH_TARGET_DIR)\/$(*):?
_OBJ_AS_DEP_%: 
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for Assembly object target $(*) "
	@echo "## Object file: $(*) $(_OBJ)" >> $(_OBJ_AS_DEPEND_FILE)
	@echo "$(_OBJ): $(_SRC)" >> $(_OBJ_AS_DEPEND_FILE)
	@echo "$(_OBJ): $(_DEP)" >> $(_OBJ_AS_DEPEND_FILE)
	$(_DEPAS) $(_T_ASFLAGS_DEP) $(_ASFLAGS) -c $(_SRC) | $(BIN_SED) -e '$(_SED_HACK)' >> $(_OBJ_AS_DEPEND_FILE)
	@echo "" >> $(_OBJ_AS_DEPEND_FILE)




$(_OBJ_AS_TARGETS): _T=$(notdir $@)
$(_OBJ_AS_TARGETS): _SRC=$(if $($(_T)_SRC),$($(_T)_SRC),$(_T:%.o=%.s))
$(_OBJ_AS_TARGETS): _TC=$(if $($(_T)_TOOLCHAIN),$($(_T)_TOOLCHAIN),$(NC_CONTROL_TOOLCHAIN))
$(_OBJ_AS_TARGETS): _AS=$(if $($(_T)_AS),$($(_T)_AS),$(BIN_$(_TC)_AS))
$(_OBJ_AS_TARGETS):
$(_OBJ_AS_TARGETS): _T_ASFLAGS         = $(if $($(_T)_ASFLAGS),$($(_T)_ASFLAGS),$(FLAGS_$(_TC)_AS) $(FLAGS_AS))
$(_OBJ_AS_TARGETS): _T_ASFLAGS_OPT     = $(if $($(_T)_ASFLAGS_OPT),$($(_T)_ASFLAGS_OPT),$(FLAGS_$(_TC)_AS_OPT) $(FLAGS_AS_OPT))
$(_OBJ_AS_TARGETS): _T_ASFLAGS_DBG     = $(if $($(_T)_ASFLAGS_DBG),$($(_T)_ASFLAGS_DBG),$(FLAGS_$(_TC)_AS_DBG) $(FLAGS_AS_DBG))
$(_OBJ_AS_TARGETS): _T_ASFLAGS_PROFILE = $(if $($(_T)_ASFLAGS_PROFILE),$($(_T)_ASFLAGS_PROFILE),$(FLAGS_$(_TC)_AS_PROFILE) $(FLAGS_AS_PROFILE))
$(_OBJ_AS_TARGETS): _T_ASFLAGS_COV = $(if $($(_T)_ASFLAGS_COV),$($(_T)_ASFLAGS_COV),$(FLAGS_$(_TC)_AS_COV) $(FLAGS_AS_COV))
$(_OBJ_AS_TARGETS):
$(_OBJ_AS_TARGETS): _ASFLAGS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_ASFLAGS_OPT))
$(_OBJ_AS_TARGETS): _ASFLAGS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_ASFLAGS_DBG))
$(_OBJ_AS_TARGETS): _ASFLAGS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_ASFLAGS_PROFILE))
$(_OBJ_AS_TARGETS): _ASFLAGS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_ASFLAGS_COV))
$(_OBJ_AS_TARGETS):
$(_OBJ_AS_TARGETS): _ASFLAGS=$(_T_ASFLAGS) $(_ASFLAGS_OPT) $(_ASFLAGS_DBG) $(_ASFLAGS_PROFILE) $(_ASFLAGS_COV) 
$(_OBJ_AS_TARGETS):
$(_OBJ_AS_TARGETS):
	@echo
	@echo "$(BS_INFO_PREFIX)  compiling Assembly object $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                     :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                     :  $@"
	@echo "$(BS_INFO_PREFIX)      Source File                     :  $(_SRC)"
	@echo "$(BS_INFO_PREFIX)      Toolchain                       :  $(_TC)"
	@echo "$(BS_INFO_PREFIX)      Assembler                       :  $(_AS)"
	@echo "$(BS_INFO_PREFIX)      Target ASFLAGS (base)           :  $(_T_ASFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Target ASFLAGS (Optimize)       :  $(_T_ASFLAGS_OPT)"
	@echo "$(BS_INFO_PREFIX)      Target ASFLAGS (Debug)          :  $(_T_ASFLAGS_DBG)"
	@echo "$(BS_INFO_PREFIX)      Target ASFLAGS (Profile)        :  $(_T_ASFLAGS_PROFILE)"
	@echo "$(BS_INFO_PREFIX)      Target ASFLAGS (Coverage)       :  $(_T_ASFLAGS_COV)"
	@echo "$(BS_INFO_PREFIX)      Target ASFLAGS (current build)  :  $(_ASFLAGS)"
	@echo
	$(_AS) $(_ASFLAGS) -c -o $@ $(_SRC)




#
# C++ Object targets
#
_OBJ_CXX_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(sort $(OBJ_CXX_TARGETS)))
_OBJ_CXX_DEP_GENERATION_TARGETS=$(addprefix _OBJ_CXX_DEP_,$(OBJ_CXX_TARGETS))
_OBJ_CXX_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/nativecode_depend_obj_cxx.mk


ifneq ($(strip $(OBJ_CXX_TARGETS)),)
-include $(_OBJ_CXX_DEPEND_FILE)

nativecode_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning native code C++ Object targets"
	$(BIN_RM) -f $(_OBJ_CXX_TARGETS)
endif


$(_OBJ_CXX_DEPEND_FILE): _OBJ_CXX_DEP_PREP $(_OBJ_CXX_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _OBJ_CXX_DEP_PREP $(_OBJ_CXX_DEP_GENERATION_TARGETS)


_OBJ_CXX_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_OBJ_CXX_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_OBJ_CXX_DEPEND_FILE))
	echo "##" > $(_OBJ_CXX_DEPEND_FILE)
	echo "## Auto generated depend file for C++ objects" >> $(_OBJ_CXX_DEPEND_FILE)
	echo "##" >> $(_OBJ_CXX_DEPEND_FILE)


_OBJ_CXX_DEP_%:
_OBJ_CXX_DEP_%: _OBJ=$(BS_ARCH_TARGET_DIR)/$(*)
_OBJ_CXX_DEP_%: _SRC=$(if $($*_SRC),$($*_SRC),$(*:%.o=%.cc))
_OBJ_CXX_DEP_%: _DEP=$($*_DEP)
_OBJ_CXX_DEP_%: 
_OBJ_CXX_DEP_%: _TC=$(if $($*_TOOLCHAIN),$($*_TOOLCHAIN),$(NC_CONTROL_TOOLCHAIN))
_OBJ_CXX_DEP_%: _T_CXXFLAGS_DEP=$(FLAGS_$(_TC)_CXX_DEP)
_OBJ_CXX_DEP_%: _DEPCXX=$(if $(_T_CXXFLAGS_DEP),$(if $($*_CXX),$($*_CXX),$(BIN_$(_TC)_CXX)),$(BIN_TRUE))
_OBJ_CXX_DEP_%: 
_OBJ_CXX_DEP_%: 
_OBJ_CXX_DEP_%: _T_CXXFLAGS         = $(if $($*_CXXFLAGS),$($*_CXXFLAGS),$(FLAGS_$(_TC)_CXX) $(FLAGS_CXX))
_OBJ_CXX_DEP_%: _T_CXXFLAGS_OPT     = $(if $($*_CXXFLAGS_OPT),$($*_CXXFLAGS_OPT),$(FLAGS_$(_TC)_CXX_OPT) $(FLAGS_CXX_OPT))
_OBJ_CXX_DEP_%: _T_CXXFLAGS_DBG     = $(if $($*_CXXFLAGS_DBG),$($*_CXXFLAGS_DBG),$(FLAGS_$(_TC)_CXX_DBG) $(FLAGS_CXX_DBG))
_OBJ_CXX_DEP_%: _T_CXXFLAGS_PROFILE = $(if $($*_CXXFLAGS_PROFILE),$($*_CXXFLAGS_PROFILE),$(FLAGS_$(_TC)_CXX_PROFILE) $(FLAGS_CXX_PROFILE))
_OBJ_CXX_DEP_%: _T_CXXFLAGS_COV = $(if $($*_CXXFLAGS_COV),$($*_CXXFLAGS_COV),$(FLAGS_$(_TC)_CXX_COV) $(FLAGS_CXX_COV))
_OBJ_CXX_DEP_%:
_OBJ_CXX_DEP_%: _CXXFLAGS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_CXXFLAGS_OPT))
_OBJ_CXX_DEP_%: _CXXFLAGS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_CXXFLAGS_DBG))
_OBJ_CXX_DEP_%: _CXXFLAGS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_CXXFLAGS_PROFILE))
_OBJ_CXX_DEP_%: _CXXFLAGS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_CXXFLAGS_COV))
_OBJ_CXX_DEP_%:
_OBJ_CXX_DEP_%: _CXXFLAGS=$(_T_CXXFLAGS) $(_CXXFLAGS_OPT) $(_CXXFLAGS_DBG) $(_CXXFLAGS_PROFILE) $(_CXXFLAGS_COV) 
_OBJ_CXX_DEP_%: 
_OBJ_CXX_DEP_%: _SED_HACK = s?^\(.*:\)?$(BS_ARCH_TARGET_DIR)\/$(*):?
_OBJ_CXX_DEP_%: 
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for C++ object target $(*) "
	@echo "## Object file: $(*) $(_OBJ)" >> $(_OBJ_CXX_DEPEND_FILE)
	@echo "$(_OBJ): $(_SRC)" >> $(_OBJ_CXX_DEPEND_FILE)
	@echo "$(_OBJ): $(_DEP)" >> $(_OBJ_CXX_DEPEND_FILE)
	$(_DEPCXX) $(_T_CXXFLAGS_DEP) $(_CXXFLAGS) -c $(_SRC) | $(BIN_SED) -e '$(_SED_HACK)' >> $(_OBJ_CXX_DEPEND_FILE)
	@echo "" >> $(_OBJ_CXX_DEPEND_FILE)




$(_OBJ_CXX_TARGETS): _T=$(notdir $@)
$(_OBJ_CXX_TARGETS): _SRC=$(if $($(_T)_SRC),$($(_T)_SRC),$(_T:%.o=%.cc))
$(_OBJ_CXX_TARGETS): _TC=$(if $($(_T)_TOOLCHAIN),$($(_T)_TOOLCHAIN),$(NC_CONTROL_TOOLCHAIN))
$(_OBJ_CXX_TARGETS): _CXX=$(if $($(_T)_CXX),$($(_T)_CXX),$(BIN_$(_TC)_CXX))
$(_OBJ_CXX_TARGETS):
$(_OBJ_CXX_TARGETS): _T_CXXFLAGS         = $(if $($(_T)_CXXFLAGS),$($(_T)_CXXFLAGS),$(FLAGS_$(_TC)_CXX) $(FLAGS_CXX))
$(_OBJ_CXX_TARGETS): _T_CXXFLAGS_OPT     = $(if $($(_T)_CXXFLAGS_OPT),$($(_T)_CXXFLAGS_OPT),$(FLAGS_$(_TC)_CXX_OPT) $(FLAGS_CXX_OPT))
$(_OBJ_CXX_TARGETS): _T_CXXFLAGS_DBG     = $(if $($(_T)_CXXFLAGS_DBG),$($(_T)_CXXFLAGS_DBG),$(FLAGS_$(_TC)_CXX_DBG) $(FLAGS_CXX_DBG))
$(_OBJ_CXX_TARGETS): _T_CXXFLAGS_PROFILE = $(if $($(_T)_CXXFLAGS_PROFILE),$($(_T)_CXXFLAGS_PROFILE),$(FLAGS_$(_TC)_CXX_PROFILE) $(FLAGS_CXX_PROFILE))
$(_OBJ_CXX_TARGETS): _T_CXXFLAGS_COV = $(if $($(_T)_CXXFLAGS_COV),$($(_T)_CXXFLAGS_COV),$(FLAGS_$(_TC)_CXX_COV) $(FLAGS_CXX_COV))
$(_OBJ_CXX_TARGETS):
$(_OBJ_CXX_TARGETS): _CXXFLAGS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_CXXFLAGS_OPT))
$(_OBJ_CXX_TARGETS): _CXXFLAGS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_CXXFLAGS_DBG))
$(_OBJ_CXX_TARGETS): _CXXFLAGS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_CXXFLAGS_PROFILE))
$(_OBJ_CXX_TARGETS): _CXXFLAGS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_CXXFLAGS_COV))
$(_OBJ_CXX_TARGETS):
$(_OBJ_CXX_TARGETS): _CXXFLAGS=$(_T_CXXFLAGS) $(_CXXFLAGS_OPT) $(_CXXFLAGS_DBG) $(_CXXFLAGS_PROFILE) $(_CXXFLAGS_COV) 
$(_OBJ_CXX_TARGETS):
$(_OBJ_CXX_TARGETS):
	@echo
	@echo "$(BS_INFO_PREFIX)  compiling C++ object $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                     :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                     :  $@"
	@echo "$(BS_INFO_PREFIX)      Source File                     :  $(_SRC)"
	@echo "$(BS_INFO_PREFIX)      Toolchain                       :  $(_TC)"
	@echo "$(BS_INFO_PREFIX)      Compiler                        :  $(_CXX)"
	@echo "$(BS_INFO_PREFIX)      Target CXXFLAGS (base)          :  $(_T_CXXFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Target CXXFLAGS (Optimize)      :  $(_T_CXXFLAGS_OPT)"
	@echo "$(BS_INFO_PREFIX)      Target CXXFLAGS (Debug)         :  $(_T_CXXFLAGS_DBG)"
	@echo "$(BS_INFO_PREFIX)      Target CXXFLAGS (Profile)       :  $(_T_CXXFLAGS_PROFILE)"
	@echo "$(BS_INFO_PREFIX)      Target CXXFLAGS (Coverage)      :  $(_T_CXXFLAGS_COV)"
	@echo "$(BS_INFO_PREFIX)      Target CXXFLAGS (current build) :  $(_CXXFLAGS)"
	@echo
	$(_CXX) $(_CXXFLAGS) -c -o $@ $(_SRC)





#
# C Object targets
#
_OBJ_CC_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/nativecode_depend_obj_cc.mk
_OBJ_CC_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(sort $(OBJ_CC_TARGETS)))
_OBJ_CC_DEP_GENERATION_TARGETS=$(addprefix _OBJ_CC_DEP_,$(OBJ_CC_TARGETS))


ifneq ($(strip $(OBJ_CC_TARGETS)),)
-include $(_OBJ_CC_DEPEND_FILE)

nativecode_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning native code C Object targets"
	$(BIN_RM) -f $(_OBJ_CC_TARGETS)
endif


$(_OBJ_CC_DEPEND_FILE): _OBJ_CC_DEP_PREP $(_OBJ_CC_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _OBJ_CC_DEP_PREP $(_OBJ_CC_DEP_GENERATION_TARGETS)

_OBJ_CC_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_OBJ_CC_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_OBJ_CC_DEPEND_FILE))
	echo "##" > $(_OBJ_CC_DEPEND_FILE)
	echo "## Auto generated depend file for C objects" >> $(_OBJ_CC_DEPEND_FILE)
	echo "##" >> $(_OBJ_CC_DEPEND_FILE)



_OBJ_CC_DEP_%:
_OBJ_CC_DEP_%: _OBJ=$(BS_ARCH_TARGET_DIR)/$(*)
_OBJ_CC_DEP_%: _SRC=$(if $($*_SRC),$($*_SRC),$(*:%.o=%.c))
_OBJ_CC_DEP_%: _DEP=$($*_DEP)
_OBJ_CC_DEP_%: 
_OBJ_CC_DEP_%: _TC=$(if $($*_TOOLCHAIN),$($*_TOOLCHAIN),$(NC_CONTROL_TOOLCHAIN))
_OBJ_CC_DEP_%: _T_CFLAGS_DEP=$(FLAGS_$(_TC)_CC_DEP)
_OBJ_CC_DEP_%: _DEPCC=$(if $(_T_CFLAGS_DEP),$(if $($*_CC),$($*_CC),$(BIN_$(_TC)_CC)),$(BIN_TRUE))
_OBJ_CC_DEP_%: 
_OBJ_CC_DEP_%: 
_OBJ_CC_DEP_%: _T_CFLAGS         = $(if $($*_CFLAGS),$($*_CFLAGS),$(FLAGS_$(_TC)_CC) $(FLAGS_CC))
_OBJ_CC_DEP_%: _T_CFLAGS_OPT     = $(if $($*_CFLAGS_OPT),$($*_CFLAGS_OPT),$(FLAGS_$(_TC)_CC_OPT) $(FLAGS_CC_OPT))
_OBJ_CC_DEP_%: _T_CFLAGS_DBG     = $(if $($*_CFLAGS_DBG),$($*_CFLAGS_DBG),$(FLAGS_$(_TC)_CC_DBG) $(FLAGS_CC_DBG))
_OBJ_CC_DEP_%: _T_CFLAGS_PROFILE = $(if $($*_CFLAGS_PROFILE),$($*_CFLAGS_PROFILE),$(FLAGS_$(_TC)_CC_PROFILE) $(FLAGS_CC_PROFILE))
_OBJ_CC_DEP_%: _T_CFLAGS_COV = $(if $($*_CFLAGS_COV),$($*_CFLAGS_COV),$(FLAGS_$(_TC)_CC_COV) $(FLAGS_CC_COV))
_OBJ_CC_DEP_%:
_OBJ_CC_DEP_%: _CFLAGS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_CFLAGS_OPT))
_OBJ_CC_DEP_%: _CFLAGS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_CFLAGS_DBG))
_OBJ_CC_DEP_%: _CFLAGS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_CFLAGS_PROFILE))
_OBJ_CC_DEP_%: _CFLAGS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_CFLAGS_COV))
_OBJ_CC_DEP_%:
_OBJ_CC_DEP_%: _CFLAGS=$(_T_CFLAGS) $(_CFLAGS_OPT) $(_CFLAGS_DBG) $(_CFLAGS_PROFILE) $(_CFLAGS_COV) 
_OBJ_CC_DEP_%: 
_OBJ_CC_DEP_%: _SED_HACK = s?^\(.*:\)?$(BS_ARCH_TARGET_DIR)\/$(*):?
_OBJ_CC_DEP_%: 
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for C object target $(*) "
	@echo "## Object file: $(*) $(_OBJ)" >> $(_OBJ_CC_DEPEND_FILE)
	@echo "$(_OBJ): $(_SRC)" >> $(_OBJ_CC_DEPEND_FILE)
	@echo "$(_OBJ): $(_DEP)" >> $(_OBJ_CC_DEPEND_FILE)
	$(_DEPCC) $(_T_CFLAGS_DEP) $(_CFLAGS) -c $(_SRC) | $(BIN_SED) -e '$(_SED_HACK)' >> $(_OBJ_CC_DEPEND_FILE)
	@echo "" >> $(_OBJ_CC_DEPEND_FILE)




$(_OBJ_CC_TARGETS): _T=$(notdir $@)
$(_OBJ_CC_TARGETS): _SRC=$(if $($(_T)_SRC),$($(_T)_SRC),$(_T:%.o=%.c))
$(_OBJ_CC_TARGETS): _TC=$(if $($(_T)_TOOLCHAIN),$($(_T)_TOOLCHAIN),$(NC_CONTROL_TOOLCHAIN))
$(_OBJ_CC_TARGETS): _CC=$(if $($(_T)_CC),$($(_T)_CC),$(BIN_$(_TC)_CC))
$(_OBJ_CC_TARGETS):
$(_OBJ_CC_TARGETS): _T_CFLAGS         = $(if $($(_T)_CFLAGS),$($(_T)_CFLAGS),$(FLAGS_$(_TC)_CC) $(FLAGS_CC))
$(_OBJ_CC_TARGETS): _T_CFLAGS_OPT     = $(if $($(_T)_CFLAGS_OPT),$($(_T)_CFLAGS_OPT),$(FLAGS_$(_TC)_CC_OPT) $(FLAGS_CC_OPT))
$(_OBJ_CC_TARGETS): _T_CFLAGS_DBG     = $(if $($(_T)_CFLAGS_DBG),$($(_T)_CFLAGS_DBG),$(FLAGS_$(_TC)_CC_DBG) $(FLAGS_CC_DBG))
$(_OBJ_CC_TARGETS): _T_CFLAGS_PROFILE = $(if $($(_T)_CFLAGS_PROFILE),$($(_T)_CFLAGS_PROFILE),$(FLAGS_$(_TC)_CC_PROFILE) $(FLAGS_CC_PROFILE))
$(_OBJ_CC_TARGETS): _T_CFLAGS_COV = $(if $($(_T)_CFLAGS_COV),$($(_T)_CFLAGS_COV),$(FLAGS_$(_TC)_CC_COV) $(FLAGS_CC_COV))
$(_OBJ_CC_TARGETS):
$(_OBJ_CC_TARGETS): _CFLAGS_OPT=$(if $(filter 1,$(NC_CONTROL_OPTIMIZE)),$(_T_CFLAGS_OPT))
$(_OBJ_CC_TARGETS): _CFLAGS_DBG=$(if $(filter 1,$(NC_CONTROL_DEBUG)),$(_T_CFLAGS_DBG))
$(_OBJ_CC_TARGETS): _CFLAGS_PROFILE=$(if $(filter 1,$(NC_CONTROL_PROFILE)),$(_T_CFLAGS_PROFILE))
$(_OBJ_CC_TARGETS): _CFLAGS_COV=$(if $(filter 1,$(NC_CONTROL_COV)),$(_T_CFLAGS_COV))
$(_OBJ_CC_TARGETS):
$(_OBJ_CC_TARGETS): _CFLAGS=$(_T_CFLAGS) $(_CFLAGS_OPT) $(_CFLAGS_DBG) $(_CFLAGS_PROFILE) $(_CFLAGS_COV) 
$(_OBJ_CC_TARGETS):
$(_OBJ_CC_TARGETS):
	@echo
	@echo "$(BS_INFO_PREFIX)  compiling C object $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                    :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                    :  $@"
	@echo "$(BS_INFO_PREFIX)      Source File                    :  $(_SRC)"
	@echo "$(BS_INFO_PREFIX)      Toolchain                      :  $(_TC)"
	@echo "$(BS_INFO_PREFIX)      Compiler                       :  $(_CC)"
	@echo "$(BS_INFO_PREFIX)      Target CFLAGS (base)           :  $(_T_CFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Target CFLAGS (Optimize)       :  $(_T_CFLAGS_OPT)"
	@echo "$(BS_INFO_PREFIX)      Target CFLAGS (Debug)          :  $(_T_CFLAGS_DBG)"
	@echo "$(BS_INFO_PREFIX)      Target CFLAGS (Profile)        :  $(_T_CFLAGS_PROFILE)"
	@echo "$(BS_INFO_PREFIX)      Target CFLAGS (Coverage)       :  $(_T_CFLAGS_COV)"
	@echo "$(BS_INFO_PREFIX)      Target CFLAGS (current build)  :  $(_CFLAGS)"
	@echo
	$(_CC) $(_CFLAGS) -c -o $@ $(_SRC)




#
# hook module rules into build system
#

info:: nativecode_info

man::  nativecode_man

pretarget::

target:: $(_OBJ_CC_TARGETS)
target:: $(_OBJ_CXX_TARGETS)
target:: $(_OBJ_AS_TARGETS)
target:: $(_OBJ_INC_TARGETS)
target:: $(_LIB_TARGETS)
target:: $(_SHLIB_TARGETS)
target:: $(_EXE_TARGETS)

posttarget::

clean:: nativecode_clean

depends:: _OBJ_CC_DEP_PREP $(_OBJ_CC_DEP_GENERATION_TARGETS)
depends:: _OBJ_CXX_DEP_PREP $(_OBJ_CXX_DEP_GENERATION_TARGETS)
depends:: _OBJ_AS_DEP_PREP $(_OBJ_AS_DEP_GENERATION_TARGETS)
depends:: _INCOBJ_DEP_PREP $(_INCOBJ_DEP_GENERATION_TARGETS)
depends:: _EXE_DEP_PREP $(_EXE_DEP_GENERATION_TARGETS)
depends:: _LIB_DEP_PREP $(_LIB_DEP_GENERATION_TARGETS)
depends:: _SHLIB_DEP_PREP $(_SHLIB_DEP_GENERATION_TARGETS)

nuke::

.PHONY:: nativecode_info nativecode_man nativecode_clean

