#
# Module rules
#
packaging_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Packaging Module Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_BSCATMAN) $(BS_ROOT)/packaging/packaging.html

packaging_info:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Packaging Module Macro Settings"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) PACKAGE_ROOT                        $(PACKAGE_ROOT)"
	@echo "$(BS_INFO_PREFIX) PACKAGE_TARGET_DIR                  $(PACKAGE_TARGET_DIR)"
	@echo "$(BS_INFO_PREFIX) PACKAGE_RELEASE_DIR                 $(PACKAGE_RELEASE_DIR)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) PACKAGE_TARGETS                     $(PACKAGE_TARGETS)"
	@echo "$(BS_INFO_PREFIX) TARGZ_TARGETS                       $(TARGZ_TARGETS)"
	@echo "$(BS_INFO_PREFIX) ZIP_TARGETS                         $(ZIP_TARGETS)"



package_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning package module targets"

package_nuke::
	@echo "$(BS_INFO_PREFIX)  nuking package module targets"



#
# Targz depend targets
#

PACKAGING_FUNC_GET_TARGZ_REALTARGET=$(if $($(1)_DEST),$($(1)_DEST),$(BS_ARCH_TARGET_DIR)/$(1).tar.gz)
PACKAGING_FUNC_GET_TARGZ_FLAGTARGET=$(BS_ARCH_TARGET_DIR)/packaging_flags_targz/$(1)

_TARGZ_REAL_TARGETS=$(foreach t,$(TARGZ_TARGETS),$(call PACKAGING_FUNC_GET_TARGZ_REALTARGET,$(t)))
_TARGZ_FLAG_TARGETS=$(foreach t,$(TARGZ_TARGETS),$(call PACKAGING_FUNC_GET_TARGZ_FLAGTARGET,$(t)))
_TARGZ_DEP_GENERATION_TARGETS=$(addprefix _TARGZ_DEP_,$(TARGZ_TARGETS))
_TARGZ_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/packaging_depend_targz.mk

ifneq ($(strip $(TARGZ_TARGETS)),)
-include $(_TARGZ_DEPEND_FILE)

package_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning package module TARGZ_TARGETS"
	$(BIN_RM) -rf $(_TARGZ_REAL_TARGETS)
	$(BIN_RM) -rf $(_TARGZ_FLAG_TARGETS)

package_nuke::
	@echo "$(BS_INFO_PREFIX)  nuking package module TARGZ_TARGETS"
	$(BIN_RM) -rf $(_TARGZ_REAL_TARGETS)
	$(BIN_RM) -rf $(_TARGZ_FLAG_TARGETS)

endif


$(_TARGZ_DEPEND_FILE): _TARGZ_DEP_PREP $(_TARGZ_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _TARGZ_DEP_PREP $(_TARGZ_DEP_GENERATION_TARGETS)


_TARGZ_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_TARGZ_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_TARGZ_DEPEND_FILE))
	$(BIN_MKDIR) -p $(BS_ARCH_TARGET_DIR)/packaging_flags_targz
	echo "##" > $(_TARGZ_DEPEND_FILE)
	echo "## Auto generated depend file for targz targets" >> $(_TARGZ_DEPEND_FILE)
	echo "##" >> $(_TARGZ_DEPEND_FILE)


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
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for targz target $(*) "
	@echo "$(_TARGZ_FLAG_TARGET): $(_MANIFEST) $(_MANIFEST_FILES) $(_RAW_FILES)" >> $(_TARGZ_DEPEND_FILE)
	@echo "$(_TARGZ_REAL_TARGET): $(_TARGZ_FLAG_TARGET)" >> $(_TARGZ_DEPEND_FILE)
	@echo "" >> $(_TARGZ_DEPEND_FILE)





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
$(_TARGZ_FLAG_TARGETS): _MANIFEST_FILES=$(if $(_MANIFEST),$(shell $(CAT) $(_MANIFEST)),)
$(_TARGZ_FLAG_TARGETS):
$(_TARGZ_FLAG_TARGETS): _CWD=$(if $($(_T)_CWD),$($(_T)_CWD),$(BS_ARCH_TARGET_DIR))
$(_TARGZ_FLAG_TARGETS):
	@echo "$(BS_INFO_PREFIX)  creating TARGZ_TARGET $(_T)"
	@echo "$(BS_INFO_PREFIX)     Target Archive File           : $(_TARGZ_REAL_TARGET)"
	@echo "$(BS_INFO_PREFIX)     Flag Target File              : $(_TARGZ_FLAG_TARGET)"
	@echo "$(BS_INFO_PREFIX)     Archive Creation Manifest     : $(_MANIFEST)"
	@echo "$(BS_INFO_PREFIX)     Archive Relative CWD          : $(_CWD)"
	@echo "$(BS_INFO_PREFIX)     Archive Files (Raw)           : $(_RAW_FILES)"
	@echo "$(BS_INFO_PREFIX)     Archive Files (From Manifest) : $(_MANIFEST_FILES)"
	$(BIN_RM) -f $(_TARGZ_REAL_TARGET)
	($(BIN_CD) $(_CWD) && $(BIN_TAR) -cvf - $(_RAW_FILES) $(_MANIFEST_FILES) ) | $(BIN_GZIP) -v9 > $(_TARGZ_REAL_TARGET)
	$(BIN_TOUCH) $(_TARGZ_FLAG_TARGET)
	$(BIN_TOUCH) $(_TARGZ_REAL_TARGET)

# Force packagaging to be done before archiving.
#packaging_targz: packaging_package
packaging_targz: $(_TARGZ_FLAG_TARGETS)


#
# Zip depend targets
#

PACKAGING_FUNC_GET_ZIP_REALTARGET=$(if $($(1)_DEST),$($(1)_DEST),$(BS_ARCH_TARGET_DIR)/$(1).zip)
PACKAGING_FUNC_GET_ZIP_FLAGTARGET=$(BS_ARCH_TARGET_DIR)/packaging_flags_zip/$(1)

_ZIP_REAL_TARGETS=$(foreach t,$(ZIP_TARGETS),$(call PACKAGING_FUNC_GET_ZIP_REALTARGET,$(t)))
_ZIP_FLAG_TARGETS=$(foreach t,$(ZIP_TARGETS),$(call PACKAGING_FUNC_GET_ZIP_FLAGTARGET,$(t)))
_ZIP_DEP_GENERATION_TARGETS=$(addprefix _ZIP_DEP_,$(ZIP_TARGETS))
_ZIP_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/packaging_depend_zip.mk

ifneq ($(strip $(ZIP_TARGETS)),)
-include $(_ZIP_DEPEND_FILE)

package_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning package module ZIP_TARGETS"
	$(BIN_RM) -rf $(_ZIP_REAL_TARGETS)
	$(BIN_RM) -rf $(_ZIP_FLAG_TARGETS)

package_nuke::
	@echo "$(BS_INFO_PREFIX)  nuking package module ZIP_TARGETS"
	$(BIN_RM) -rf $(_ZIP_REAL_TARGETS)
	$(BIN_RM) -rf $(_ZIP_FLAG_TARGETS)

endif


$(_ZIP_DEPEND_FILE): _ZIP_DEP_PREP $(_ZIP_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _ZIP_DEP_PREP $(_ZIP_DEP_GENERATION_TARGETS)


_ZIP_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_ZIP_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_ZIP_DEPEND_FILE))
	$(BIN_MKDIR) -p $(BS_ARCH_TARGET_DIR)/packaging_flags_zip
	echo "##" > $(_ZIP_DEPEND_FILE)
	echo "## Auto generated depend file for zip targets" >> $(_ZIP_DEPEND_FILE)
	echo "##" >> $(_ZIP_DEPEND_FILE)


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
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for zip target $(*) "
	@echo "$(_ZIP_FLAG_TARGET): $(_MANIFEST) $(_MANIFEST_FILES) $(_RAW_FILES)" >> $(_ZIP_DEPEND_FILE)
	@echo "$(_ZIP_REAL_TARGET): $(_ZIP_FLAG_TARGET)" >> $(_ZIP_DEPEND_FILE)
	@echo "" >> $(_ZIP_DEPEND_FILE)



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
$(_ZIP_FLAG_TARGETS): _MANIFEST_FILES=$(if $(_MANIFEST),$(shell $(CAT) $(_MANIFEST)),)
$(_ZIP_FLAG_TARGETS):
$(_ZIP_FLAG_TARGETS): _CWD=$(if $($(_T)_CWD),$($(_T)_CWD),$(BS_ARCH_TARGET_DIR))
$(_ZIP_FLAG_TARGETS):
	@echo "$(BS_INFO_PREFIX)  creating ZIP_TARGET $(_T)"
	@echo "$(BS_INFO_PREFIX)     Target Archive File           : $(_ZIP_REAL_TARGET)"
	@echo "$(BS_INFO_PREFIX)     Flag Target File              : $(_ZIP_FLAG_TARGET)"
	@echo "$(BS_INFO_PREFIX)     Archive Creation Manifest     : $(_MANIFEST)"
	@echo "$(BS_INFO_PREFIX)     Archive Relative CWD          : $(_CWD)"
	@echo "$(BS_INFO_PREFIX)     Archive Files (Raw)           : $(_RAW_FILES)"
	@echo "$(BS_INFO_PREFIX)     Archive Files (From Manifest) : $(_MANIFEST_FILES)"
	$(BIN_RM) -f $(_ZIP_REAL_TARGET)
	($(BIN_CD) $(_CWD) && $(BIN_ZIP) -r - $(_RAW_FILES) $(_MANIFEST_FILES) ) > $(_ZIP_REAL_TARGET)
	$(BIN_TOUCH) $(_ZIP_FLAG_TARGET)
	$(BIN_TOUCH) $(_ZIP_REAL_TARGET)



# Force packagaging to be done before archiving.
#packaging_zip: packaging_package
packaging_zip: $(_ZIP_FLAG_TARGETS)


#
# Packaging depend targets
#

_PACKAGING_FUNC_GET_PACKAGE_DIR=$(PACKAGE_TARGET_DIR)/$(dir $($(1)_DEST))
_PACKAGING_FUNC_GET_PACKAGE_NOTDIR=$(if $(notdir $($(1)_DEST)),$(notdir $($(1)_DEST)),$(notdir $(1)))
PACKAGING_FUNC_GET_PACKAGE_REALTARGET=$(subst //,/,$(subst /./,/,$(call _PACKAGING_FUNC_GET_PACKAGE_DIR,$(1))/$(call _PACKAGING_FUNC_GET_PACKAGE_NOTDIR,$(1))))
PACKAGING_FUNC_GET_PACKAGE_FLAGTARGET=$(BS_ARCH_TARGET_DIR)/packaging_flags_package/$(1)


_PACKAGE_TARGETS=$(PACKAGE_TARGETS)
_PACKAGE_REAL_TARGETS=$(foreach t,$(PACKAGE_TARGETS),$(call PACKAGING_FUNC_GET_PACKAGE_REALTARGET,$(t)))
_PACKAGE_FLAG_TARGETS=$(foreach t,$(PACKAGE_TARGETS),$(call PACKAGING_FUNC_GET_PACKAGE_FLAGTARGET,$(t)))
_PACKAGE_DEP_GENERATION_TARGETS=$(addprefix _PACKAGE_DEP_,$(PACKAGE_TARGETS))
_PACKAGE_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/packaging_depend_package.mk

ifneq ($(strip $(PACKAGE_TARGETS)),)
-include $(_PACKAGE_DEPEND_FILE)

package_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning package module PACKAGE_TARGETS"
	$(BIN_RM) -rf $(_PACKAGE_REAL_TARGETS)
	$(BIN_RM) -rf $(_PACKAGE_FLAG_TARGETS)

package_nuke::
	@echo "$(BS_INFO_PREFIX)  nuking package module PACKAGE_TARGETS"
	$(BIN_RM) -rf $(PACKAGE_TARGET_DIR)
endif

$(_PACKAGE_DEPEND_FILE): _PACKAGE_DEP_PREP $(_PACKAGE_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _PACKAGE_DEP_PREP $(_PACKAGE_DEP_GENERATION_TARGETS)

_PACKAGE_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_PACKAGE_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_PACKAGE_DEPEND_FILE))
	$(BIN_MKDIR) -p $(BS_ARCH_TARGET_DIR)/packaging_flags_package
	echo "##" > $(_PACKAGE_DEPEND_FILE)
	echo "## Auto generated depend file for package targets" >> $(_PACKAGE_DEPEND_FILE)
	echo "##" >> $(_PACKAGE_DEPEND_FILE)


_PACKAGE_DEP_%:
_PACKAGE_DEP_%: _PACKAGE_T=$(*)
_PACKAGE_DEP_%:
_PACKAGE_DEP_%:
_PACKAGE_DEP_%: _PACKAGE_DIR=$(call _PACKAGING_FUNC_GET_PACKAGE_DIR,$*)
_PACKAGE_DEP_%: _PACKAGE_NOTDIR=$(call _PACKAGING_FUNC_GET_PACKAGE_NOTDIR,$*)
_PACKAGE_DEP_%: _PACKAGE_REAL_TARGET=$(call PACKAGING_FUNC_GET_PACKAGE_REALTARGET,$*)
_PACKAGE_DEP_%: _PACKAGE_FLAG_TARGET=$(call PACKAGING_FUNC_GET_PACKAGE_FLAGTARGET,$*)
_PACKAGE_DEP_%:
_PACKAGE_DEP_%: _PLATFORM=$(if $($*_PLATFORM),$($*_PLATFORM),$(BS_PLATFORM_ARCH_FULL))
_PACKAGE_DEP_%: _FROM=$(if $($*_FROM),$($*_FROM),$(BS_ROOT_TARGET_DIR)/$(_PLATFORM)/$*)
_PACKAGE_DEP_%:
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for package target $(*) "
	@echo "## package target: $(_PACKAGE_T)" >> $(_PACKAGE_DEPEND_FILE)
	@echo "$(_PACKAGE_FLAG_TARGET): $(_FROM)" >> $(_PACKAGE_DEPEND_FILE)
	@echo "" >> $(_PACKAGE_DEPEND_FILE)
	@echo "$(_PACKAGE_REAL_TARGET): $(_PACKAGE_FLAG_TARGET)" >> $(_PACKAGE_DEPEND_FILE)
	@echo "" >> $(_PACKAGE_DEPEND_FILE)





#
# Package targets
#


$(_PACKAGE_FLAG_TARGETS):
$(_PACKAGE_FLAG_TARGETS): _PACKAGE_FLAG_TARGET=$(@)
$(_PACKAGE_FLAG_TARGETS): _T=$(notdir $(@))
$(_PACKAGE_FLAG_TARGETS):
$(_PACKAGE_FLAG_TARGETS): _PACKAGE_DIR=$(call _PACKAGING_FUNC_GET_PACKAGE_DIR,$(_T))
$(_PACKAGE_FLAG_TARGETS): _PACKAGE_NOTDIR=$(call _PACKAGING_FUNC_GET_PACKAGE_NOTDIR,$(_T))
$(_PACKAGE_FLAG_TARGETS): _PACKAGE_REAL_TARGET=$(call PACKAGING_FUNC_GET_PACKAGE_REALTARGET,$(_T))
$(_PACKAGE_FLAG_TARGETS):
$(_PACKAGE_FLAG_TARGETS): _PLATFORM=$(if $($(_T)_PLATFORM),$($(_T)_PLATFORM),$(BS_PLATFORM_ARCH_FULL))
$(_PACKAGE_FLAG_TARGETS): _FROM=$(if $($(_T)_FROM),$($(_T)_FROM),$(BS_ROOT_TARGET_DIR)/$(_PLATFORM)/$(_T))
$(_PACKAGE_FLAG_TARGETS): _SCRUB=$(if $($(_T)_SCRUB),$($(_T)_SCRUB),)
$(_PACKAGE_FLAG_TARGETS): _SCRUB_RM=$(if $(_SCRUB),$(BIN_RM) -rf,$(BIN_TRUE))
$(_PACKAGE_FLAG_TARGETS):
	@echo "$(BS_INFO_PREFIX) Packaging Target $(_T)"
	@echo "$(BS_INFO_PREFIX)   Target Directory              : $(_PACKAGE_DIR)"
	@echo "$(BS_INFO_PREFIX)   Target Name                   : $(_PACKAGE_NOTDIR)"
	@echo "$(BS_INFO_PREFIX)   Target Path                   : $(_PACKAGE_REAL_TARGET)"
	@echo "$(BS_INFO_PREFIX)   Target Plarform               : $(_PLATFORM)"
	@echo "$(BS_INFO_PREFIX)   Package From                  : $(_FROM)"
	@echo "$(BS_INFO_PREFIX)   Package Flag                  : $(_PACKAGE_FLAG_TARGET)"
	@echo "$(BS_INFO_PREFIX)   Package Scrub                 : $(_SCRUB)"
	$(BIN_MKDIR) -p $(_PACKAGE_DIR)
	$(BIN_CP) -R $(_FROM) $(_PACKAGE_REAL_TARGET)
	$(_SCRUB_RM) `$(foreach scrub,$(_SCRUB),$(BIN_FIND) $(_PACKAGE_REAL_TARGET) -name $(scrub) -print ; )`
	$(BIN_TOUCH) $(_PACKAGE_FLAG_TARGET)
	$(BIN_TOUCH) $(_PACKAGE_REAL_TARGET)


packaging_package: $(_PACKAGE_FLAG_TARGETS)


#
# hook module rules into build system
#

info:: packaging_info

man:: packaging_man

depends:: _PACKAGE_DEP_PREP $(_PACKAGE_DEP_GENERATION_TARGETS)
depends:: _TARGZ_DEP_PREP $(_TARGZ_DEP_GENERATION_TARGETS)
depends:: _ZIP_DEP_PREP $(_ZIP_DEP_GENERATION_TARGETS)

pretarget::

target::

posttarget:: packaging_package
posttarget:: packaging_targz
posttarget:: packaging_zip

clean:: package_clean

nuke:: package_nuke

.PHONY:: packaging_info packaging_man


