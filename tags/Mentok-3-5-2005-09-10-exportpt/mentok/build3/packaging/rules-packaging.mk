#
# Module rules
#
packaging_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Packaging Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_BSCATMAN) $(BS_ROOT)/packaging/packaging.html

packaging_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Packaging Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGE_ROOT                        $(PACKAGE_ROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGE_TARGET_DIR                  $(PACKAGE_TARGET_DIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGE_RELEASE_DIR                 $(PACKAGE_RELEASE_DIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGEFILE_TARGETS                 $(PACKAGEFILE_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGEDIR_TARGETS                  $(PACKAGEDIR_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) TARGZ_TARGETS                       $(TARGZ_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ZIP_TARGETS                         $(ZIP_TARGETS)")



package_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning package module targets")

package_nuke::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Nuking package module targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(PACKAGE_ROOT)


#
# Targz depend targets
#

PACKAGING_FUNC_GET_TARGZ_REALTARGET=$(if $($(1)_DEST),$($(1)_DEST),$(call _func_get_target_platform,$(1).tar.gz)/$(1).tar.gz)
PACKAGING_FUNC_GET_TARGZ_FLAGTARGET=$(call _func_get_target_dir,(packaging_flags_targz/$(1)))/packaging_flags_targz/$(1)

_TARGZ_REAL_TARGETS=$(foreach t,$(TARGZ_TARGETS),$(call PACKAGING_FUNC_GET_TARGZ_REALTARGET,$(t)))
_TARGZ_FLAG_TARGETS=$(foreach t,$(TARGZ_TARGETS),$(call PACKAGING_FUNC_GET_TARGZ_FLAGTARGET,$(t)))
_TARGZ_DEP_GENERATION_TARGETS=$(addprefix _TARGZ_DEP_,$(TARGZ_TARGETS))
_TARGZ_DEPEND_FILE=$(call _func_get_target_dir,packaging_depend_targz.mk)/packaging_depend_targz.mk

ifneq ($(strip $(TARGZ_TARGETS)),)
-include $(_TARGZ_DEPEND_FILE)

package_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) cleaning package module TARGZ_TARGETS")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_TARGZ_REAL_TARGETS)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_TARGZ_FLAG_TARGETS)

endif


$(_TARGZ_DEPEND_FILE): _TARGZ_DEP_PREP $(_TARGZ_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _TARGZ_DEP_PREP $(_TARGZ_DEP_GENERATION_TARGETS)


_TARGZ_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_TARGZ_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_TARGZ_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(call _func_get_target_dir,packaging_flags_targz)/packaging_flags_targz
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_TARGZ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for targz targets" >> $(_TARGZ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_TARGZ_DEPEND_FILE)


_TARGZ_DEP_%:
_TARGZ_DEP_%: _TARGZ_T=$(*)
_TARGZ_DEP_%:
_TARGZ_DEP_%: _TARGZ_FLAG_TARGET=$(call PACKAGING_FUNC_GET_TARGZ_FLAGTARGET,$*)
_TARGZ_DEP_%: _TARGZ_REAL_TARGET=$(call PACKAGING_FUNC_GET_TARGZ_REALTARGET,$*)
_TARGZ_DEP_%: _CWD=$(if $($*_CWD),$($*_CWD),$(BS_ARCH_TARGET_DIR))
_TARGZ_DEP_%: _RAW_FILES=$(addprefix $(_CWD)/,$($*_FILES))
_TARGZ_DEP_%: _MANIFEST=$(if $($*_MANIFEST),$($*_MANIFEST),)
_TARGZ_DEP_%: _MANIFEST_FILES=$(addprefix $(_CWD)/,$(if $(_MANIFEST),$(shell $(BIN_CAT) $(_MANIFEST)),))
_TARGZ_DEP_%:
_TARGZ_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for targz target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_TARGZ_FLAG_TARGET): $(_MANIFEST) $(_MANIFEST_FILES) $(_RAW_FILES)" >> $(_TARGZ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_TARGZ_REAL_TARGET): $(_TARGZ_FLAG_TARGET)" >> $(_TARGZ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_TARGZ_DEPEND_FILE)





#
# Targz targets
#


#
# We touch the real file again after the flag target because the
# dependancy rules have the real target depend on the flag.
# This is done so make file users can reference the _DEST
# in the _DEPS of other targets and have it work right.
$(_TARGZ_FLAG_TARGETS):
$(_TARGZ_FLAG_TARGETS): _T=$(notdir $(@))
$(_TARGZ_FLAG_TARGETS): _TARGZ_FLAG_TARGET=$(@)
$(_TARGZ_FLAG_TARGETS): _TARGZ_REAL_TARGET=$(call PACKAGING_FUNC_GET_TARGZ_REALTARGET,$(_T))
$(_TARGZ_FLAG_TARGETS):
$(_TARGZ_FLAG_TARGETS): _RAW_FILES=$($(_T)_FILES)
$(_TARGZ_FLAG_TARGETS): _MANIFEST=$(if $($(_T)_MANIFEST),$($(_T)_MANIFEST),)
$(_TARGZ_FLAG_TARGETS): _MANIFEST_FILES=$(if $(_MANIFEST),$(shell $(BIN_CAT) $(_MANIFEST)),)
$(_TARGZ_FLAG_TARGETS):
$(_TARGZ_FLAG_TARGETS): _CWD=$(if $($(_T)_CWD),$($(_T)_CWD),$(BS_ARCH_TARGET_DIR))
$(_TARGZ_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Creating TARGZ_TARGET $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Target Archive File           : $(_TARGZ_REAL_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Flag Target File              : $(_TARGZ_FLAG_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Creation Manifest     : $(_MANIFEST)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Relative CWD          : $(_CWD)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Files (Raw)           : $(_RAW_FILES)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Files (From Manifest) : $(_MANIFEST_FILES)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_TARGZ_REAL_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) ($(BIN_CD) $(_CWD) && $(BIN_TAR) -cvf - $(_RAW_FILES) $(_MANIFEST_FILES) ) | $(BIN_GZIP) -v9 > $(_TARGZ_REAL_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_TARGZ_FLAG_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_TARGZ_REAL_TARGET)

# Force packagaging to be done before archiving.
#packaging_targz: packaging_packagefile
#packaging_targz: packaging_packagedir
packaging_targz: $(_TARGZ_FLAG_TARGETS)


#
# Zip depend targets
#

PACKAGING_FUNC_GET_ZIP_REALTARGET=$(if $($(1)_DEST),$($(1)_DEST),$(call _func_get_target_platform,$(1).zip)/$(1).zip)
PACKAGING_FUNC_GET_ZIP_FLAGTARGET=$(call _func_get_target_dir,(packaging_flags_zip/$(1)))/packaging_flags_zip/$(1)

_ZIP_REAL_TARGETS=$(foreach t,$(ZIP_TARGETS),$(call PACKAGING_FUNC_GET_ZIP_REALTARGET,$(t)))
_ZIP_FLAG_TARGETS=$(foreach t,$(ZIP_TARGETS),$(call PACKAGING_FUNC_GET_ZIP_FLAGTARGET,$(t)))
_ZIP_DEP_GENERATION_TARGETS=$(addprefix _ZIP_DEP_,$(ZIP_TARGETS))
_ZIP_DEPEND_FILE=$(call _func_get_target_dir,packaging_depend_zip.mk)/packaging_depend_zip.mk

ifneq ($(strip $(ZIP_TARGETS)),)
-include $(_ZIP_DEPEND_FILE)

package_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning package module ZIP_TARGETS")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_ZIP_REAL_TARGETS)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_ZIP_FLAG_TARGETS)

endif


$(_ZIP_DEPEND_FILE): _ZIP_DEP_PREP $(_ZIP_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _ZIP_DEP_PREP $(_ZIP_DEP_GENERATION_TARGETS)


_ZIP_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_ZIP_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_ZIP_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(call _func_get_target_dir,packaging_flags_zip)/packaging_flags_zip
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_ZIP_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for zip targets" >> $(_ZIP_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_ZIP_DEPEND_FILE)


_ZIP_DEP_%:
_ZIP_DEP_%: _ZIP_T=$(*)
_ZIP_DEP_%:
_ZIP_DEP_%: _ZIP_FLAG_TARGET=$(call PACKAGING_FUNC_GET_ZIP_FLAGTARGET,$*)
_ZIP_DEP_%: _ZIP_REAL_TARGET=$(call PACKAGING_FUNC_GET_ZIP_REALTARGET,$*)
_ZIP_DEP_%: _CWD=$(if $($*_CWD),$($*_CWD),$(BS_ARCH_TARGET_DIR))
_ZIP_DEP_%: _RAW_FILES=$(addprefix $(_CWD)/,$($*_FILES))
_ZIP_DEP_%: _MANIFEST=$(if $($*_MANIFEST),$($*_MANIFEST),)
_ZIP_DEP_%: _MANIFEST_FILES=$(addprefix $(_CWD)/,$(if $(_MANIFEST),$(shell $(BIN_CAT) $(_MANIFEST)),))
_ZIP_DEP_%:
_ZIP_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for zip target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ZIP_FLAG_TARGET): $(_MANIFEST) $(_MANIFEST_FILES) $(_RAW_FILES)" >> $(_ZIP_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ZIP_REAL_TARGET): $(_ZIP_FLAG_TARGET)" >> $(_ZIP_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_ZIP_DEPEND_FILE)



#
# Zip targets
#


#
# We touch the real file again after the flag target because the
# dependancy rules have the real target depend on the flag.
# This is done so make file users can reference the _DEST
# in the _DEPS of other targets and have it work right.
$(_ZIP_FLAG_TARGETS):
$(_ZIP_FLAG_TARGETS): _T=$(notdir $(@))
$(_ZIP_FLAG_TARGETS): _ZIP_FLAG_TARGET=$(@)
$(_ZIP_FLAG_TARGETS): _ZIP_REAL_TARGET=$(call PACKAGING_FUNC_GET_ZIP_REALTARGET,$(_T))
$(_ZIP_FLAG_TARGETS):
$(_ZIP_FLAG_TARGETS): _RAW_FILES=$($(_T)_FILES)
$(_ZIP_FLAG_TARGETS): _MANIFEST=$(if $($(_T)_MANIFEST),$($(_T)_MANIFEST),)
$(_ZIP_FLAG_TARGETS): _MANIFEST_FILES=$(if $(_MANIFEST),$(shell $(BIN_CAT) $(_MANIFEST)),)
$(_ZIP_FLAG_TARGETS):
$(_ZIP_FLAG_TARGETS): _CWD=$(if $($(_T)_CWD),$($(_T)_CWD),$(BS_ARCH_TARGET_DIR))
$(_ZIP_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Creating ZIP_TARGET $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Target Archive File           : $(_ZIP_REAL_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Flag Target File              : $(_ZIP_FLAG_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Creation Manifest     : $(_MANIFEST)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Relative CWD          : $(_CWD)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Files (Raw)           : $(_RAW_FILES)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Files (From Manifest) : $(_MANIFEST_FILES)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_ZIP_REAL_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) ($(BIN_CD) $(_CWD) && $(BIN_ZIP) -r - $(_RAW_FILES) $(_MANIFEST_FILES) ) > $(_ZIP_REAL_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_ZIP_FLAG_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_ZIP_REAL_TARGET)



# Force packagaging to be done before archiving.
#packaging_zip: packaging_packagefile
#packaging_zip: packaging_packagedir
packaging_zip: $(_ZIP_FLAG_TARGETS)




#
# Package file depend targets
#
PACKAGING_FUNC_GET_PACKAGEFILE_REALTARGET=$(PACKAGE_TARGET_DIR)/$(if $($(1)_DEST),$($(1)_DEST),$(1))
PACKAGING_FUNC_GET_PACKAGEFILE_FLAGTARGET=$(call _func_get_target_dir,(packaging_flags_packagefile/$(1)))/packaging_flags_packagefile/$(1)


_PACKAGEFILE_TARGETS=$(PACKAGEFILE_TARGETS)
_PACKAGEFILE_REAL_TARGETS=$(foreach t,$(PACKAGEFILE_TARGETS),$(call PACKAGING_FUNC_GET_PACKAGEFILE_REALTARGET,$(t)))
_PACKAGEFILE_FLAG_TARGETS=$(foreach t,$(PACKAGEFILE_TARGETS),$(call PACKAGING_FUNC_GET_PACKAGEFILE_FLAGTARGET,$(t)))
_PACKAGEFILE_DEP_GENERATION_TARGETS=$(addprefix _PACKAGEFILE_DEP_,$(PACKAGEFILE_TARGETS))
_PACKAGEFILE_DEPEND_FILE=$(call _func_get_target_dir,packaging_depend_packagefile.mk)/packaging_depend_packagefile.mk


ifneq ($(strip $(PACKAGEFILE_TARGETS)),)
-include $(_PACKAGEFILE_DEPEND_FILE)

package_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) cleaning package module PACKAGEFILE_TARGETS")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_PACKAGEFILE_REAL_TARGETS)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_PACKAGEFILE_FLAG_TARGETS)

endif

$(_PACKAGEFILE_DEPEND_FILE): _PACKAGEFILE_DEP_PREP $(_PACKAGEFILE_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _PACKAGEFILE_DEP_PREP $(_PACKAGEFILE_DEP_GENERATION_TARGETS)

_PACKAGEFILE_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_PACKAGEFILE_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_PACKAGEFILE_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(call _func_get_target_dir,packaging_flags_packagefile)/packaging_flags_packagefile
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_PACKAGEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for package file targets" >> $(_PACKAGEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_PACKAGEFILE_DEPEND_FILE)


_PACKAGEFILE_DEP_%:
_PACKAGEFILE_DEP_%: _PACKAGEFILE_T=$(*)
_PACKAGEFILE_DEP_%:
_PACKAGEFILE_DEP_%:
_PACKAGEFILE_DEP_%: _PACKAGEFILE_REAL_TARGET=$(call PACKAGING_FUNC_GET_PACKAGEFILE_REALTARGET,$*)
_PACKAGEFILE_DEP_%: _PACKAGEFILE_FLAG_TARGET=$(call PACKAGING_FUNC_GET_PACKAGEFILE_FLAGTARGET,$*)
_PACKAGEFILE_DEP_%:
_PACKAGEFILE_DEP_%: _FROM=$(if $($*_FROM),$($*_FROM),$(call BS_FUNC_GEN_TARGET_DIR,$(call NC_FUNC_GET_TOOLCHAIN_PLATFORM_FULL,$(NC_CONTROL_TOOLCHAIN)))/$*)
_PACKAGEFILE_DEP_%: _DEP=$($*_DEP)
_PACKAGEFILE_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for package file target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## package file target: $(_PACKAGEFILE_T)" >> $(_PACKAGEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_PACKAGEFILE_FLAG_TARGET): $(_FROM)" >> $(_PACKAGEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_PACKAGEFILE_FLAG_TARGET): $(_DEP)" >> $(_PACKAGEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_PACKAGEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_PACKAGEFILE_REAL_TARGET): $(_PACKAGEFILE_FLAG_TARGET)" >> $(_PACKAGEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_PACKAGEFILE_DEPEND_FILE)





#
# Package file targets
#


$(_PACKAGEFILE_FLAG_TARGETS):
$(_PACKAGEFILE_FLAG_TARGETS): _T=$(notdir $(@))
$(_PACKAGEFILE_FLAG_TARGETS): _PACKAGEFILE_FLAG_TARGET=$(@)
$(_PACKAGEFILE_FLAG_TARGETS): _PACKAGEFILE_REAL_TARGET=$(call PACKAGING_FUNC_GET_PACKAGEFILE_REALTARGET,$(_T))
$(_PACKAGEFILE_FLAG_TARGETS):
$(_PACKAGEFILE_FLAG_TARGETS): _FROM=$(if $($(_T)_FROM),$($(_T)_FROM),$(call BS_FUNC_GEN_TARGET_DIR,$(call NC_FUNC_GET_TOOLCHAIN_PLATFORM_FULL,$(NC_CONTROL_TOOLCHAIN)))/$(_T))
$(_PACKAGEFILE_FLAG_TARGETS): _DIR=$(dir $(_PACKAGEFILE_REAL_TARGET))
$(_PACKAGEFILE_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Packaging File Target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Target Path                   : $(_PACKAGEFILE_REAL_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Target From                   : $(_FROM)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Target Flag                   : $(_PACKAGEFILE_FLAG_TARGET)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_TEST) ! -e $(_PACKAGEFILE_REAL_TARGET) -o -f $(_PACKAGEFILE_REAL_TARGET) || ($(BIN_ECHO) "$(BS_ERROR_PREFIX) $(_PACKAGEFILE_REAL_TARGET) must be a regular file" && $(BIN_FALSE) )
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_TEST) -f $(_FROM) || ($(BIN_ECHO) "$(BS_ERROR_PREFIX) $(_FROM) must be a regular file"  && $(BIN_FALSE) )
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(_DIR)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CP) -f $(_FROM) $(_PACKAGEFILE_REAL_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_PACKAGEFILE_FLAG_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_PACKAGEFILE_REAL_TARGET)


packaging_packagefile: $(_PACKAGEFILE_FLAG_TARGETS)




#
# Package dir depend targets
#
PACKAGING_FUNC_GET_PACKAGEDIR_REALTARGET=$(PACKAGE_TARGET_DIR)/$(if $($(1)_DEST),$($(1)_DEST),$(1))
PACKAGING_FUNC_GET_PACKAGEDIR_FLAGTARGET=$(call _func_get_target_dir,(packaging_flags_packagedir/$(1)))/packaging_flags_packagedir/$(1)


_PACKAGEDIR_TARGETS=$(PACKAGEDIR_TARGETS)
_PACKAGEDIR_REAL_TARGETS=$(foreach t,$(PACKAGEDIR_TARGETS),$(call PACKAGING_FUNC_GET_PACKAGEDIR_REALTARGET,$(t)))
_PACKAGEDIR_FLAG_TARGETS=$(foreach t,$(PACKAGEDIR_TARGETS),$(call PACKAGING_FUNC_GET_PACKAGEDIR_FLAGTARGET,$(t)))
_PACKAGEDIR_DEP_GENERATION_TARGETS=$(addprefix _PACKAGEDIR_DEP_,$(PACKAGEDIR_TARGETS))
_PACKAGEDIR_DEPEND_FILE=$(call _func_get_target_dir,packaging_depend_packagedir.mk)/packaging_depend_packagedir.mk


ifneq ($(strip $(PACKAGEDIR_TARGETS)),)
-include $(_PACKAGEDIR_DEPEND_FILE)

package_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) cleaning package module PACKAGEDIR_TARGETS")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_PACKAGEDIR_REAL_TARGETS)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_PACKAGEDIR_FLAG_TARGETS)

endif

$(_PACKAGEDIR_DEPEND_FILE): _PACKAGEDIR_DEP_PREP $(_PACKAGEDIR_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _PACKAGEDIR_DEP_PREP $(_PACKAGEDIR_DEP_GENERATION_TARGETS)

_PACKAGEDIR_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_PACKAGEDIR_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_PACKAGEDIR_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(call _func_get_target_dir,packaging_flags_packagedir)/packaging_flags_packagedir
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_PACKAGEDIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for package dir targets" >> $(_PACKAGEDIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_PACKAGEDIR_DEPEND_FILE)


_PACKAGEDIR_DEP_%:
_PACKAGEDIR_DEP_%: _PACKAGEDIR_T=$(*)
_PACKAGEDIR_DEP_%:
_PACKAGEDIR_DEP_%: _PACKAGEDIR_REAL_TARGET=$(call PACKAGING_FUNC_GET_PACKAGEDIR_REALTARGET,$*)
_PACKAGEDIR_DEP_%: _PACKAGEDIR_FLAG_TARGET=$(call PACKAGING_FUNC_GET_PACKAGEDIR_FLAGTARGET,$*)
_PACKAGEDIR_DEP_%:
_PACKAGEDIR_DEP_%: _FROM=$(if $($*_FROM),$($*_FROM),$(call BS_FUNC_GEN_TARGET_DIR,$(call NC_FUNC_GET_TOOLCHAIN_PLATFORM_FULL,$(NC_CONTROL_TOOLCHAIN)))/$*)
_PACKAGEDIR_DEP_%: _DEP=$($*_DEP)
_PACKAGEDIR_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for package dir target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## package dir target: $(_PACKAGEDIR_T)" >> $(_PACKAGEDIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_PACKAGEDIR_FLAG_TARGET): $(_FROM)" >> $(_PACKAGEDIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_PACKAGEDIR_FLAG_TARGET): $(_DEP)" >> $(_PACKAGEDIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_PACKAGEDIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_PACKAGEDIR_REAL_TARGET): $(_PACKAGEDIR_FLAG_TARGET)" >> $(_PACKAGEDIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_PACKAGEDIR_DEPEND_FILE)





#
# Package dir targets
#

# we never create package dir flags, since we never have a complete
# dependancy tree, and target can overlap.
.PHONY:: $(_PACKAGEDIR_FLAG_TARGETS)


$(_PACKAGEDIR_FLAG_TARGETS):
$(_PACKAGEDIR_FLAG_TARGETS): _T=$(notdir $(@))
$(_PACKAGEDIR_FLAG_TARGETS): _PACKAGEDIR_FLAG_TARGET=$(@)
$(_PACKAGEDIR_FLAG_TARGETS): _PACKAGEDIR_REAL_TARGET=$(call PACKAGING_FUNC_GET_PACKAGEDIR_REALTARGET,$(_T))
$(_PACKAGEDIR_FLAG_TARGETS): 
$(_PACKAGEDIR_FLAG_TARGETS): _FROM=$(if $($(_T)_FROM),$($(_T)_FROM),$(call BS_FUNC_GEN_TARGET_DIR,$(call NC_FUNC_GET_TOOLCHAIN_PLATFORM_FULL,$(NC_CONTROL_TOOLCHAIN)))/$(_T))
$(_PACKAGEDIR_FLAG_TARGETS): _SCRUB=$(if $($(_T)_SCRUB),$($(_T)_SCRUB),)
$(_PACKAGEDIR_FLAG_TARGETS): _SCRUB_RM=$(if $(_SCRUB),$(BIN_RM) -rf,$(BIN_TRUE))
$(_PACKAGEDIR_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Packaging Dir Target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Target Path                   : $(_PACKAGEDIR_REAL_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Target From                   : $(_FROM)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Target Flag                   : $(_PACKAGEDIR_FLAG_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Target Scrub                  : $(_SCRUB)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_TEST) ! -e $(_PACKAGEDIR_REAL_TARGET) -o -d $(_PACKAGEDIR_REAL_TARGET) || ($(BIN_ECHO) "$(BS_ERROR_PREFIX) $(_PACKAGEDIR_REAL_TARGET) must be a directory"  && $(BIN_FALSE) )
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_TEST) -d $(_FROM) || ($(BIN_ECHO) "$(BS_ERROR_PREFIX) $(_FROM) must be a directory"  && $(BIN_FALSE) )
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(_PACKAGEDIR_REAL_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) ($(BIN_CD) $(_FROM) && $(BIN_TAR) cf - . ) | ( $(BIN_CD) $(_PACKAGEDIR_REAL_TARGET) && $(BIN_TAR) xvpf - )
	$(BS_CMDPREFIX_VERBOSE2) $(_SCRUB_RM) `$(foreach scrub,$(_SCRUB),$(BIN_FIND) $(_PACKAGEDIR_REAL_TARGET) -name $(scrub) -print ; )`
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_PACKAGEDIR_FLAG_TARGET)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_PACKAGEDIR_REAL_TARGET)

packaging_packagedir: $(_PACKAGEDIR_FLAG_TARGETS)




#
# hook module rules into build system
#

info:: packaging_info

man:: packaging_man

depends:: _PACKAGEFILE_DEP_PREP $(_PACKAGEFILE_DEP_GENERATION_TARGETS)
depends:: _PACKAGEDIR_DEP_PREP $(_PACKAGEDIR_DEP_GENERATION_TARGETS)
depends:: _TARGZ_DEP_PREP $(_TARGZ_DEP_GENERATION_TARGETS)
depends:: _ZIP_DEP_PREP $(_ZIP_DEP_GENERATION_TARGETS)

pretarget::

target::

posttarget:: packaging_packagefile
posttarget:: packaging_packagedir
posttarget:: packaging_targz
posttarget:: packaging_zip

clean:: package_clean

nuke:: package_nuke

.PHONY:: packaging_info packaging_man


