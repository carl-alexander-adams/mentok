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
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGE_ROOT_ABSPATH                $(PACKAGE_ROOT_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGE_TARGET_DIR                  $(PACKAGE_TARGET_DIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGE_TARGET_DIR_ABSPATH          $(PACKAGE_TARGET_DIR_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGE_RELEASE_DIR                 $(PACKAGE_RELEASE_DIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGE_RELEASE_DIR_ABSPATH         $(PACKAGE_RELEASE_DIR_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGE_LIBDIR                      $(PACKAGE_LIBDIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGEFILE_TARGETS                 $(PACKAGEFILE_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PACKAGEDIR_TARGETS                  $(PACKAGEDIR_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) MKDIR_TARGETS                       $(MKDIR_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) TARGZ_TARGETS                       $(TARGZ_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ZIP_TARGETS                         $(ZIP_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) EPM_TARGETS                         $(EPM_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ISO_TARGETS                         $(ISO_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) RSYNCTREE_TARGETS                   $(RSYNCTREE_TARGETS)")

package_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning package module targets")

package_nuke::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Nuking package module targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(PACKAGE_ROOT)

$(PACKAGE_RELEASE_DIR):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Creating packaging release targets dir")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $@

$(PACKAGE_TARGET_DIR):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Creating packaging staging targets dir")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $@


#
# EPM depend targets
#
PACKAGING_FUNC_GET_EPM_REALTARGET=$(error) #$(PACKAGE_RELEASE_DIR)/$(if $($(1)_DEST),$($(1)_DEST),$(1).tgz)
PACKAGING_FUNC_GET_EPM_FLAGTARGET=$(call _func_get_target_dir,(packaging_flags_epm/$(1)))/packaging_flags_epm/$(1)
PACKAGING_FUNC_GET_EPM_OUTPUT_MANIFEST=$(call _func_get_target_dir,$(1)-epm.manifest)/$(1)-epm.manifest
# XXX Should we just use the output manifest as the flag target?

_EPM_REAL_TARGETS=$(error) # $(foreach t,$(TARGZ_TARGETS),$(call PACKAGING_FUNC_GET_TARGZ_REALTARGET,$(t)))
_EPM_FLAG_TARGETS=$(foreach t,$(EPM_TARGETS),$(call PACKAGING_FUNC_GET_EPM_FLAGTARGET,$(t)))
_EPM_DEP_GENERATION_TARGETS=$(addprefix _EPM_DEP_,$(EPM_TARGETS))
_EPM_DEPEND_FILE=$(call _func_get_target_dir,packaging_depend_epm.mk)/packaging_depend_epm.mk

ifneq ($(strip $(EPM_TARGETS)),)
-include $(_EPM_DEPEND_FILE)

package_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) cleaning package module EPM_TARGETS")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_EPM_REAL_TARGETS)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_EPM_FLAG_TARGETS)

endif


$(_EPM_DEPEND_FILE): _EPM_DEP_PREP $(_EPM_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _EPM_DEP_PREP $(_EPM_DEP_GENERATION_TARGETS)


_EPM_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_EPM_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_EPM_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(call _func_get_target_dir,packaging_flags_epm)/packaging_flags_epm
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_EPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for epm targets" >> $(_EPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_EPM_DEPEND_FILE)

# Artificially make all archive targets (tgz/zip/epm) depend on all packaging targets so nothing is missed.
_EPM_DEP_%:
_EPM_DEP_%: _EPM_T=$(*)
_EPM_DEP_%:
_EPM_DEP_%: _EPM_FLAG_TARGET=$(call PACKAGING_FUNC_GET_EPM_FLAGTARGET,$*)
_EPM_DEP_%: _EPM_REAL_TARGET=$(call PACKAGING_FUNC_GET_EPM_REALTARGET,$*)
_EPM_DEP_%: _EPM_OUTPUTMANIFEST_TARGET=$(call PACKAGING_FUNC_GET_EPM_OUTPUT_MANIFEST,$*)
_EPM_DEP_%: 
_EPM_DEP_%: _EPMNAME=$(if $($*_EPMNAME),$($*_EPMNAME),$*)
_EPM_DEP_%: _EPMLIST=$(if $($*_EPMLIST),$($*_EPMLIST),$*.list)
_EPM_DEP_%: _ENV=$(if $($*_ENV),$($*_ENV),)
_EPM_DEP_%: _DEPS=$(if $($*_DEPS),$($*_DEPS),)
_EPM_DEP_%:
_EPM_DEP_%: _SRCENV=$(if $($(_T)_ENV),. $($(_T)_ENV) &&,)
_EPM_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for epm target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_EPM_FLAG_TARGET): $(PACKAGE_RELEASE_DIR)" >> $(_EPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_EPM_FLAG_TARGET): $(_EPMLIST)" >> $(_EPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_EPM_FLAG_TARGET): $(_MKDIR_TARGETS)" >> $(_EPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_EPM_FLAG_TARGET): $(_PACKAGEDIR_FLAG_TARGETS)" >> $(_EPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_EPM_FLAG_TARGET): $(_PACKAGEFILE_FLAG_TARGETS)" >> $(_EPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_EPM_FLAG_TARGET): $(_DEPS) $(_ENV)" >> $(_EPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(_SRCENV) $(BIN_EPM) --depend '$(_EPMNAME)' '$(_EPMLIST)' | $(BIN_SED) -e '/::/d' -e 's?^?$(_EPM_FLAG_TARGET): ?' >> $(_EPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_EPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_EPM_OUTPUTMANIFEST_TARGET): $(_EPM_FLAG_TARGET)" >> $(_EPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_EPM_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_EPM_REAL_TARGET): $(_EPM_FLAG_TARGET)" >> $(_EPM_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_EPM_DEPEND_FILE)


#
# EPM targets.
# 
# Currently, we don't control binary stripping with EPM, the native code 
# module has controls for this. So, we always tell EPM do not strip (-g)
#
# EPM has a few irritating features from make's POV... the output file name 
# may vary depending on the contents of the list (sub packages get rolled
# up into a tgz, which isn't what we really want)
# We use a patched version of EPM to fix some of these problems.
#
# We override EPM's default platform name by build3 default to align with
# Redhat/CentOS naming conventions.  We want packages named like
# "x86_64", not "linux-2.6-x86_64"
$(_EPM_FLAG_TARGETS):
$(_EPM_FLAG_TARGETS): _T_vtag=$(notdir $(@))
$(_EPM_FLAG_TARGETS): _T=$(_T_vtag:$(PACKAGE_VTAG)=)
$(_EPM_FLAG_TARGETS):
$(_EPM_FLAG_TARGETS): _EPM_FLAG_TARGET=$(@)
$(_EPM_FLAG_TARGETS): _EPM_REAL_TARGET=$(call PACKAGING_FUNC_GET_EPM_REALTARGET,$(_T))
$(_EPM_FLAG_TARGETS): _EPM_OUTPUT_MANIFEST=$(call PACKAGING_FUNC_GET_EPM_OUTPUT_MANIFEST,$(_T))
$(_EPM_FLAG_TARGETS):
$(_EPM_FLAG_TARGETS): _NAME=$(if $($(_T)_EPMNAME),$($(_T)_EPMNAME)$(PACKAGE_VTAG),$(_T)$(PACKAGE_VTAG))
$(_EPM_FLAG_TARGETS): _LIST=$(if $($(_T)_EPMLIST),$($(_T)_EPMLIST),$(_T).list)
$(_EPM_FLAG_TARGETS): _FORMAT=$(if $($(_T)_EPMFORMAT),$($(_T)_EPMFORMAT),)
$(_EPM_FLAG_TARGETS): _ARCH=$(if $($(_T)_EPMARCH),$($(_T)_EPMARCH),)
$(_EPM_FLAG_TARGETS): _FLAGS=$(if $($(_T)_EPMFLAGS),$($(_T)_EPMFLAGS),$(FLAGS_EPM))
$(_EPM_FLAG_TARGETS): _ENV=$(if $($(_T)_ENV),. $($(_T)_ENV) &&,)
$(_EPM_FLAG_TARGETS): 
$(_EPM_FLAG_TARGETS): _PLATNAME_ARGS=$(if $($(_T)_EPMPLATNAME),-m $($(_T)_EPMPLATNAME),-m $(BS_OS_MACHINEPROC))
$(_EPM_FLAG_TARGETS): 
$(_EPM_FLAG_TARGETS): _TMP_DIR=$(BS_ARCH_TARGET_DIR)/epm_$(_T)
$(_EPM_FLAG_TARGETS):
$(_EPM_FLAG_TARGETS): _OPTIONAL_ARGS=$(if $(_FORMAT), -f $(_FORMAT) ,) $(if $(_ARCH), -a $(_ARCH) ,)
$(_EPM_FLAG_TARGETS):
$(_EPM_FLAG_TARGETS): _SIGN_CMD=$(if $(EPM_PKGSIGN),$(EPM_PKGSIGN),)
$(_EPM_FLAG_TARGETS): _CRYPT_CMD=$(if $(EPM_PKGCRYPT),$(EPM_PKGCRYPT),)
$(_EPM_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Creating EPM_TARGET $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     EPM Name                      : $(_NAME)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     EPM List                      : $(_LIST)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     EPM Architecture              : $(_ARCH)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     EPM Format                    : $(_FORMAT)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     EPM Extra Command Flags       : $(_FLAGS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     EPM generated package files   : (FIXME - Unknown. Depends on list file. Multiple targets might be created.)$(_EPM_REAL_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     EPM Output Manifest           : $(_EPM_OUTPUT_MANIFEST)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     EPM Flag Target File          : $(_EPM_FLAG_TARGET)")
	$(BS_CMDPREFIX_VERBOSE1) $(_ENV) $(BIN_EPM) $(_FLAGS) $(_PLATNAME_ARGS) --no-subpackage-rollup -g --output-dir '$(_TMP_DIR)' $(_OPTIONAL_ARGS) '$(_NAME)' '$(_LIST)'
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Signing EPM_TARGET $(_T) package files")
	$(BS_CMDPREFIX_VERBOSE1) $(if $(_SIGN_CMD),$(BIN_CD) $(_TMP_DIR) && $(_SIGN_CMD) *,)
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Encrypting EPM_TARGET $(_T) package files")
	$(BS_CMDPREFIX_VERBOSE1) $(if $(_CRYPT_CMD),$(BIN_CD) $(_TMP_DIR) && $(_CRYPT_CMD) *,)
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Creating EPM_TARGET $(_T) output manifest")
#	$(BS_CMDPREFIX_VERBOSE1) ( $(BIN_CD) $(_TMP_DIR) && $(BIN_LS) * ) > $(_EPM_OUTPUT_MANIFEST)
	$(BS_CMDPREFIX_VERBOSE1) ( $(BIN_CD) $(_TMP_DIR) && $(BIN_LS) * | $(BIN_SED) 's?^?$(PACKAGE_RELEASE_DIR_ABSPATH)/?') > $(_EPM_OUTPUT_MANIFEST)
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Publishing EPM_TARGET $(_T) package files in the release dir")
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_MV) $(_TMP_DIR)/* $(PACKAGE_RELEASE_DIR)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_EPM_FLAG_TARGET)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_EPM_REAL_TARGET)

# Force packagaging to be done before archiving.
#packaging_epm: packaging_packagefile
#packaging_epm: packaging_packagedir
#packaging_epm: packaging_mkdir
#packaging_epm: $(_MKDIR_TARGETS)
#packaging_epm: $(_PACKAGEDIR_FLAG_TARGETS)
#packaging_epm: $(_PACKAGEFILE_FLAG_TARGETS)
packaging_epm: $(_EPM_FLAG_TARGETS)


#
# ISO imagetargets
#

#PACKAGING_FUNC_GET_ISO_REALTARGET=$(PACKAGE_RELEASE_DIR)/$(if $($(1)_DEST),$($(1)_DEST),$(1))
PACKAGING_FUNC_GET_ISO_REALTARGET=$(PACKAGE_RELEASE_DIR_ABSPATH)/$(if $($(1)_DEST),$($(1)_DEST),$(1))
PACKAGING_FUNC_GET_ISO_FLAGTARGET=$(call _func_get_target_dir,(packaging_flags_iso/$(1)))/packaging_flags_iso/$(1)

_ISO_REAL_TARGETS=$(foreach t,$(ISO_TARGETS),$(call PACKAGING_FUNC_GET_ISO_REALTARGET,$(t)))
_ISO_FLAG_TARGETS=$(foreach t,$(ISO_TARGETS),$(call PACKAGING_FUNC_GET_ISO_FLAGTARGET,$(t)))
_ISO_DEP_GENERATION_TARGETS=$(addprefix _ISO_DEP_,$(ISO_TARGETS))
_ISO_DEPEND_FILE=$(call _func_get_target_dir,packaging_depend_iso.mk)/packaging_depend_iso.mk

ifneq ($(strip $(ISO_TARGETS)),)
-include $(_ISO_DEPEND_FILE)

package_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) cleaning package module ISO_TARGETS")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_ISO_REAL_TARGETS)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_ISO_FLAG_TARGETS)

endif


$(_ISO_DEPEND_FILE): _ISO_DEP_PREP $(_ISO_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _ISO_DEP_PREP $(_ISO_DEP_GENERATION_TARGETS)


_ISO_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_ISO_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_ISO_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(call _func_get_target_dir,packaging_flags_iso)/packaging_flags_iso
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_ISO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for iso targets" >> $(_ISO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_ISO_DEPEND_FILE)

# Artificially make all archive targets (iso/tgz/zip/epm) depend on all packaging targets so nothing is missed.
_ISO_DEP_%:
_ISO_DEP_%: _ISO_T=$(*)
_ISO_DEP_%:
_ISO_DEP_%: _ISO_FLAG_TARGET=$(call PACKAGING_FUNC_GET_ISO_FLAGTARGET,$*)
_ISO_DEP_%: _ISO_REAL_TARGET=$(call PACKAGING_FUNC_GET_ISO_REALTARGET,$*)
_ISO_DEP_%: 
_ISO_DEP_%: _CWD=$(if $($*_CWD),$($*_CWD),$(BS_ARCH_TARGET_DIR))
_ISO_DEP_%: 
_ISO_DEP_%: _MANIFEST=$(if $($*_MANIFEST),$($*_MANIFEST),$*.manifest)
_ISO_DEP_%: 
_ISO_DEP_%: # manifests may include directories.... they do not work so well, and may be populated from several rules.
_ISO_DEP_%: # _MANIFEST_FILES=$(addprefix $(_CWD)/,$(shell $(BIN_CAT) $(_MANIFEST) | $(BIN_SED) 's/.*=//'))
_ISO_DEP_%: _DEPS=$(if $($*_DEPS),$($*_DEPS),)
_ISO_DEP_%:
_ISO_DEP_%: _ALL_FILES=$(strip $(_MANIFEST_FILES))
_ISO_DEP_%:
_ISO_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for iso target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ISO_FLAG_TARGET): $(_MANIFEST)" >> $(_ISO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ISO_FLAG_TARGET): $(_MANIFEST_FILES)" >> $(_ISO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ISO_FLAG_TARGET): $(_DEPS)" >> $(_ISO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ISO_FLAG_TARGET): $(_MKDIR_TARGETS)" >> $(_ISO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ISO_FLAG_TARGET): $(_PACKAGEDIR_FLAG_TARGETS)" >> $(_ISO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ISO_FLAG_TARGET): $(_PACKAGEFILE_FLAG_TARGETS)" >> $(_ISO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_ISO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ISO_REAL_TARGET): $(_ISO_FLAG_TARGET)" >> $(_ISO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_ISO_DEPEND_FILE)


$(_ISO_FLAG_TARGETS):
$(_ISO_FLAG_TARGETS): _T=$(notdir $(@))
$(_ISO_FLAG_TARGETS): _ISO_FLAG_TARGET=$(@)
$(_ISO_FLAG_TARGETS): _ISO_REAL_TARGET=$(call PACKAGING_FUNC_GET_ISO_REALTARGET,$(_T))
$(_ISO_FLAG_TARGETS):
$(_ISO_FLAG_TARGETS): # _CWD=$(if $($(_T)_CWD),$($(_T)_CWD),$(BS_ARCH_TARGET_DIR))
$(_ISO_FLAG_TARGETS): _CWD=$(if $($(_T)_CWD),$($(_T)_CWD),)
$(_ISO_FLAG_TARGETS): _CWD_CMD=$(if $(_CWD),$(BIN_CD) $(_CWD) &&,)
$(_ISO_FLAG_TARGETS):
$(_ISO_FLAG_TARGETS): _MANIFEST=$(if $($(_T)_MANIFEST),$($(_T)_MANIFEST),$(_T).manifest)
$(_ISO_FLAG_TARGETS): _MANIFEST_FILES=$(shell $(BIN_CAT) $(_MANIFEST))
$(_ISO_FLAG_TARGETS):
$(_ISO_FLAG_TARGETS): _MKISOFS_FLAGS=$(if $($(_T)_MKISOFS_FLAGS),$($(_T)_MKISOFS_FLAGS),)
$(_ISO_FLAG_TARGETS):
$(_ISO_FLAG_TARGETS): _MD5_CMD=$(if $($(_T)_EMBEDMD5),$(BIN_IMPLANTISOMD5) $(_ISO_REAL_TARGET),)
$(_ISO_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Creating ISO_TARGET $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     ISO File             : $(_ISO_REAL_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Flag Target File     : $(_ISO_FLAG_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Manifest             : $(_MANIFEST)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Embed MD5?           : $($(_T)_EMBEDMD5)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_ISO_REAL_TARGET) $(_ISO_FLAG_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_ISO_REAL_TARGET))
	$(BS_CMDPREFIX_VERBOSE1) $(_CWD_CMD) $(BIN_MKISOFS) -v $(_MKISOFS_FLAGS) -o $(_ISO_REAL_TARGET) -path-list $(BS_CURRENT_SRCDIR_ABSPATH)/$(_MANIFEST)
	$(BS_CMDPREFIX_VERBOSE1) $(_MD5_CMD)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_ISO_FLAG_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_ISO_REAL_TARGET)

# Force packagaging to be done before archiving.
#packaging_iso: packaging_packagefile
#packaging_iso: packaging_packagedir
#packaging_iso: packaging_mkdir
#packaging_iso: $(_MKDIR_TARGETS)
#packaging_iso: $(_PACKAGEDIR_FLAG_TARGETS)
#packaging_iso: $(_PACKAGEFILE_FLAG_TARGETS)
packaging_iso: $(_ISO_FLAG_TARGETS)



#
# Rsynctree targets - mirror source tree at the specified destination using rsync.
#
PACKAGING_FUNC_GET_RSYNCTREE_FLAGTARGET=$(BS_ARCH_TARGET_DIR)/packaging_flags_rsynctree/$(1)
_RSYNCTREE_FLAG_TARGETS=$(foreach t,$(RSYNCTREE_TARGETS),$(call PACKAGING_FUNC_GET_RSYNCTREE_FLAGTARGET,$(t)))
_RSYNCTREE_DEP_GENERATION_TARGETS=$(addprefix _RSYNCTREE_DEP_,$(RSYNCTREE_TARGETS))
_RSYNCTREE_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/packaging_depend_rsynctree.mk

ifneq ($(strip $(RSYNCTREE_TARGETS)),)
-include $(_RSYNCTREE_DEPEND_FILE)

package_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) cleaning package module RSYNCTREE_TARGETS (Cleanign Flags target only. Nuke recommended to really clean overlapping RSYNC targets.)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_RSYNCTREE_FLAG_TARGETS)

endif


$(_RSYNCTREE_DEPEND_FILE): _RSYNCTREE_DEP_PREP $(_RSYNCTREE_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _RSYNCTREE_DEP_PREP $(_RSYNCTREE_DEP_GENERATION_TARGETS)


_RSYNCTREE_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_RSYNCTREE_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_RSYNCTREE_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(BS_ARCH_TARGET_DIR)/packaging_flags_rsynctree
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_RSYNCTREE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for Rsynctree targets" >> $(_RSYNCTREE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_RSYNCTREE_DEPEND_FILE)



#
# Since "from" may be a URL, we cannot have proper dependency on the import package.
# 
_RSYNCTREE_DEP_%:
_RSYNCTREE_DEP_%: _RSYNCTREE_T=$(*)
_RSYNCTREE_DEP_%: _RSYNCTREE_FLAG_TARGET=$(call PACKAGING_FUNC_GET_RSYNCTREE_FLAGTARGET,$*)
_RSYNCTREE_DEP_%: _MANIFEST=$($(*)_MANIFEST)
_RSYNCTREE_DEP_%: _FILTERFILE=$($(*)_FILTERFILE)
_RSYNCTREE_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for Rsynctree target $(*) ")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Rsynctree target:  $(_RSYNCTREE_T)" >> $(_RSYNCTREE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_RSYNCTREE_FLAG_TARGET): $(_MANIFEST)" >> $(_RSYNCTREE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_RSYNCTREE_FLAG_TARGET): $(_FILTERFILE)" >> $(_RSYNCTREE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_RSYNCTREE_DEPEND_FILE)



# RSync doesn't allow comments in "files from" manifest files, but that's way too useful
# to disallow.  So, we strip them ourselves.
$(_RSYNCTREE_FLAG_TARGETS): 
$(_RSYNCTREE_FLAG_TARGETS): _T=$(notdir $@)
$(_RSYNCTREE_FLAG_TARGETS):
$(_RSYNCTREE_FLAG_TARGETS): _FLAG_TARGET=$(@)
$(_RSYNCTREE_FLAG_TARGETS): 
$(_RSYNCTREE_FLAG_TARGETS): _DEFAULT_TO=$(if $(RSYNCTREE_DEFAULT_TO),$(RSYNCTREE_DEFAULT_TO),$(BS_ARCH_TARGET_DIR)/$(_T))
$(_RSYNCTREE_FLAG_TARGETS): _TO=$(if $($(_T)_TO),$($(_T)_TO),$(_DEFAULT_TO))
$(_RSYNCTREE_FLAG_TARGETS):
$(_RSYNCTREE_FLAG_TARGETS): _URLBASE=$(if $($(_T)_URLBASE),$($(_T)_URLBASE),$(RSYNCTREE_DEFAULT_URLBASE))
$(_RSYNCTREE_FLAG_TARGETS): _URLPATH=$(if $($(_T)_URLPATH),$($(_T)_URLPATH),$(_T))
$(_RSYNCTREE_FLAG_TARGETS): _URL=$(if $($(_T)_URL),$($(_T)_URL),$(_URLBASE)/$(_URLPATH))
$(_RSYNCTREE_FLAG_TARGETS):
$(_RSYNCTREE_FLAG_TARGETS): _MANIFESTFILE=$($(_T)_MANIFEST)
$(_RSYNCTREE_FLAG_TARGETS): _FILTERFILE=$($(_T)_FILTERFILE)
$(_RSYNCTREE_FLAG_TARGETS):
$(_RSYNCTREE_FLAG_TARGETS): _ARG_FILTER=$(if $(_FILTERFILE),--filter="merge $(_FILTERFILE)",)
$(_RSYNCTREE_FLAG_TARGETS): _ARG_FILESFROM=$(if $(_MANIFESTFILE),--files-from="$(BS_ARCH_TARGET_DIR)/$(notdir $(_MANIFESTFILE)).clean",)
$(_RSYNCTREE_FLAG_TARGETS): _EXTRA_ARGS=$(if $($(_T)_RSYNCARGS),$($(_T)_RSYNCARGS),$(RSYNCTREE_DEFAULT_ARGS))
$(_RSYNCTREE_FLAG_TARGETS):
$(_RSYNCTREE_FLAG_TARGETS): _FETCH_CMD=$(if $(_PKGFILE_REMOTE),$(BIN_CURL) --insecure --fail --silent -o $(_PKGFILE_DOWNLOADED) $(_PKGFILE_REMOTE),)
$(_RSYNCTREE_FLAG_TARGETS): _INSTPKG=$(if $(_FETCH_CMD),$(_PKGFILE_DOWNLOADED),$(_PKGFILE))
$(_RSYNCTREE_FLAG_TARGETS): _CLEANUP_CMD=$(if $(_FETCH_CMD),$(BIN_RM) -f $(_PKGFILE_DOWNLOADED),)
$(_RSYNCTREE_FLAG_TARGETS): _CMD_FIX_FILESFROM=$(if $(_MANIFESTFILE),$(BIN_CAT) $(_MANIFESTFILE) | $(BIN_SED) '/^#.*/d' > $(BS_ARCH_TARGET_DIR)/$(notdir $(_MANIFESTFILE)).clean,)
$(_RSYNCTREE_FLAG_TARGETS): 
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)     Rsynctree target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Rsynctree Target                    : $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Rsynctree URL                       : $(_URL)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Rsynctree URL Base (target)         : $(_URLBASE)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Rsynctree URL Path (target)         : $(_URLPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Rsynctree URL Base (global)         : $(RSYNCTREE_URLBASE)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Rsynctree Manifest File             : $(_MANIFESTFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Rsynctree Filter File               : $(_FILTERFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Rsynctree Destination Dir           : $(_TO)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Rsynctree Flag Target               : $(_FLAG_TARGET)")
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_MKDIR) -p $(_TO)
	$(BS_CMDPREFIX_VERBOSE1) $(_CMD_FIX_FILESFROM)
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_RSYNC) -azH -vv $(_EXTRA_ARGS) $(_ARG_FILTER) $(_ARG_FILESFROM) $(_URL) $(_TO)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_FLAG_TARGET)




#
# Targz  targets
#

PACKAGING_FUNC_GET_TARGZ_REALTARGET=$(PACKAGE_RELEASE_DIR)/$(if $($(1)_DEST),$($(1)_DEST),$(1).tgz)
#PACKAGING_FUNC_GET_TARGZ_REALTARGET=$(if $($(1)_DEST),$($(1)_DEST),$(call _func_get_target_platform,$(1).tgz)/$(1).tgz)
#PACKAGING_FUNC_GET_TARGZ_REALTARGET=$(if $($(1)_DEST),$($(1)_DEST),$(call _func_get_target_dir,$(1).tgz)/$(1).tgz)
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

# Artificially make all archive targets (tgz/zip/epm) depend on all packaging targets so nothing is missed.
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
_TARGZ_DEP_%: _ALL_FILES=$(strip $(_MANIFEST_FILES) $(_RAW_FILES))
_TARGZ_DEP_%: _CWD_DIR=$(if $($*_CWD),$(if $(_ALL_FILES),,$($*_CWD)))
_TARGZ_DEP_%:
_TARGZ_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for targz target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_TARGZ_FLAG_TARGET): $(_MANIFEST) $(_MANIFEST_FILES) $(_RAW_FILES) $(_CWD_DIR)" >> $(_TARGZ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_TARGZ_FLAG_TARGET): $(_MKDIR_TARGETS)" >> $(_TARGZ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_TARGZ_FLAG_TARGET): $(_PACKAGEDIR_FLAG_TARGETS)" >> $(_TARGZ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_TARGZ_FLAG_TARGET): $(_PACKAGEFILE_FLAG_TARGETS)" >> $(_TARGZ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_TARGZ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_TARGZ_REAL_TARGET): $(_TARGZ_FLAG_TARGET)" >> $(_TARGZ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_TARGZ_DEPEND_FILE)


#
# We touch the real file again after the flag target because the
# dependancy rules have the real target depend on the flag.
# This is done so make file users can reference the _DEST
# in the _DEPS of other targets and have it work right.
#
# The logic of the _CWD_DIR is that we will just package up the whole CWD if
# and only if  1) it was specified (since the default CWD is the object 
# dir), and 2) nothing else was specified
#
# "size" is calculated for BSD tgz packages, and is padded at 150%
# Why be complicated like this (from older makefile), use du's -c (grand total) option.
# _MY_SIZE_CMD=$(BIN_EXPR) 3 \/ 2 \* \( `$(BIN_DU) -sk $(_TAR_FILES) | $(BIN_AWK) '{print $$1}' | $(BIN_TR) '\r\n' '  ' | $(BIN_SED) 's/ *$$//' | $(BIN_SED) 's/  */ \+ /g'` \)
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
$(_TARGZ_FLAG_TARGETS): _SPECIFIED_FILES=$(strip $(_MANIFEST_FILES) $(_RAW_FILES))
$(_TARGZ_FLAG_TARGETS): _CWD_DIR=$(if $($(_T)_CWD),$(if $(_SPECIFIED_FILES),,.))
$(_TARGZ_FLAG_TARGETS): _TAR_FILES=$(strip $(_SPECIFIED_FILES) $(_CWD_DIR))
$(_TARGZ_FLAG_TARGETS): 
$(_TARGZ_FLAG_TARGETS): _MY_SIZE_CMD=$(BIN_EXPR) `$(BIN_DU) -skc $(_TAR_FILES) | $(BIN_TAIL) -1 | $(BIN_AWK) '{print $$1}'` \* 1024 \* 3 / 2
$(_TARGZ_FLAG_TARGETS): _SIZE_CMD=$(if $(filter 1,$($(_T)_DO_BSDSIZE)),$(_MY_SIZE_CMD),)
$(_TARGZ_FLAG_TARGETS):
$(_TARGZ_FLAG_TARGETS): _APPTYPE_CMD=$(if $($(_T)_DO_BSDAPPTYPE),$(BIN_ECHO) $($(_T)_DO_BSDAPPTYPE),)
$(_TARGZ_FLAG_TARGETS):
$(_TARGZ_FLAG_TARGETS): _VERSION_CMD=$(if $($(_T)_DO_BSDVERSION),$(BIN_ECHO) $($(_T)_DO_BSDVERSION),)
$(_TARGZ_FLAG_TARGETS):
$(_TARGZ_FLAG_TARGETS): _PLATFORM_CMD=$(if $(filter 1,$($(_T)_DO_BSDPLATFORM)),$(BIN_SYSCTL) -n kern.ostype,)
$(_TARGZ_FLAG_TARGETS):
$(_TARGZ_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Creating TARGZ_TARGET $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Target Archive File           : $(_TARGZ_REAL_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Flag Target File              : $(_TARGZ_FLAG_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Creation Manifest     : $(_MANIFEST)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Relative CWD          : $(_CWD)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Files (Raw)           : $(_RAW_FILES)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Files (From Manifest) : $(_MANIFEST_FILES)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_TARGZ_REAL_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_TARGZ_REAL_TARGET))
	$(BS_CMDPREFIX_VERBOSE2) $(if $(_APPTYPE_CMD),($(BIN_CD) $(_CWD) && $(_APPTYPE_CMD) > apptype),)
	$(BS_CMDPREFIX_VERBOSE2) $(if $(_VERSION_CMD),($(BIN_CD) $(_CWD) && $(_VERSION_CMD) > version),)
	$(BS_CMDPREFIX_VERBOSE2) $(if $(_PLATFORM_CMD),($(BIN_CD) $(_CWD) && $(_PLATFORM_CMD) > platform),)
	$(BS_CMDPREFIX_VERBOSE2) $(if $(_SIZE_CMD),($(BIN_CD) $(_CWD) && $(_SIZE_CMD) > size),)
	$(BS_CMDPREFIX_VERBOSE2) ($(BIN_CD) $(_CWD) && $(BIN_TAR) -cvf - $(_TAR_FILES) ) | $(BIN_GZIP) -v9 > $(_TARGZ_REAL_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_TARGZ_FLAG_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_TARGZ_REAL_TARGET)

# Force packagaging to be done before archiving.
#packaging_targz: packaging_packagefile
#packaging_targz: packaging_packagedir
#packaging_targz: packaging_mkdir
#packaging_targz: $(_MKDIR_TARGETS)
#packaging_targz: $(_PACKAGEDIR_FLAG_TARGETS)
#packaging_targz: $(_PACKAGEFILE_FLAG_TARGETS)
packaging_targz: $(_TARGZ_FLAG_TARGETS)


#
# Zip depend targets
#

PACKAGING_FUNC_GET_ZIP_REALTARGET=$(PACKAGE_RELEASE_DIR)/$(if $($(1)_DEST),$($(1)_DEST),$(1).zip)
#PACKAGING_FUNC_GET_ZIP_REALTARGET=$(if $($(1)_DEST),$($(1)_DEST),$(call _func_get_target_platform,$(1).zip)/$(1).zip)
#PACKAGING_FUNC_GET_ZIP_REALTARGET=$(if $($(1)_DEST),$($(1)_DEST),$(call _func_get_target_dir,$(1).zip)/$(1).zip)
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


# Artificially make all archive targets (tgz/zip/epm) depend on all packaging targets so nothing is missed.
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
_ZIP_DEP_%: _ALL_FILES=$(strip $(_MANIFEST_FILES) $(_RAW_FILES))
_ZIP_DEP_%: _CWD_DIR=$(if $($*_CWD),$(if $(_ALL_FILES),,$($*_CWD)))
_ZIP_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for zip target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ZIP_FLAG_TARGET): $(_MANIFEST) $(_MANIFEST_FILES) $(_RAW_FILES) $(_CWD_DIR)" >> $(_ZIP_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ZIP_FLAG_TARGET): $(_MKDIR_TARGETS)" >> $(_ZIP_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ZIP_FLAG_TARGET): $(_PACKAGEDIR_FLAG_TARGETS)" >> $(_ZIP_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_ZIP_FLAG_TARGET): $(_PACKAGEFILE_FLAG_TARGETS)" >> $(_ZIP_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_ZIP_DEPEND_FILE)
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
#
# The logic of the _CWD_DIR is that we will just package up the whole CWD if
# and only if  1) it was specified (since the default CWD is the object 
# dir), and 2) nothing else was specified
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
$(_ZIP_FLAG_TARGETS): _ALL_FILES=$(strip $(_MANIFEST_FILES) $(_RAW_FILES))
$(_ZIP_FLAG_TARGETS): _CWD_DIR=$(if $($(_T)_CWD),$(if $(_ALL_FILES),,.))
$(_ZIP_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Creating ZIP_TARGET $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Target Archive File           : $(_ZIP_REAL_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Flag Target File              : $(_ZIP_FLAG_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Creation Manifest     : $(_MANIFEST)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Relative CWD          : $(_CWD)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Files (Raw)           : $(_RAW_FILES)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Archive Files (From Manifest) : $(_MANIFEST_FILES)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_ZIP_REAL_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_ZIP_REAL_TARGET))
	$(BS_CMDPREFIX_VERBOSE2) ($(BIN_CD) $(_CWD) && $(BIN_ZIP) -r - $(_CWD_DIR) $(_RAW_FILES) $(_MANIFEST_FILES) ) > $(_ZIP_REAL_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_ZIP_FLAG_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_ZIP_REAL_TARGET)



# Force packagaging to be done before archiving.
#packaging_zip: packaging_packagefile
#packaging_zip: packaging_packagedir
#packaging_zip: packaging_mkdir
#packaging_targz: $(_MKDIR_TARGETS)
#packaging_targz: $(_PACKAGEDIR_FLAG_TARGETS)
#packaging_targz: $(_PACKAGEFILE_FLAG_TARGETS)
packaging_zip: $(_ZIP_FLAG_TARGETS)




#
# Package file depend targets
#
_PKG_ROOT=$(if $($(1)_ROOT),$($(1)_ROOT),$(PACKAGE_TARGET_DIR))
_PKG_DEST=$(if $($(1)_DEST),$($(1)_DEST),$(1))
PACKAGING_FUNC_GET_PACKAGEFILE_REALTARGET=$(call _PKG_ROOT,$(1))/$(call _PKG_DEST,$(1))
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
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for package file target $(*)")
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
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_TEST) ! -r $(_PACKAGEFILE_REAL_TARGET) -o -f $(_PACKAGEFILE_REAL_TARGET) || ($(BIN_ECHO) "$(BS_ERROR_PREFIX) $(_PACKAGEFILE_REAL_TARGET) must be a regular file" && $(BIN_FALSE) )
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
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for package dir target $(*)")
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
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_TEST) ! -r $(_PACKAGEDIR_REAL_TARGET) -o -d $(_PACKAGEDIR_REAL_TARGET) || ($(BIN_ECHO) "$(BS_ERROR_PREFIX) $(_PACKAGEDIR_REAL_TARGET) must be a directory"  && $(BIN_FALSE) )
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_TEST) -d $(_FROM) || ($(BIN_ECHO) "$(BS_ERROR_PREFIX) $(_FROM) must be a directory"  && $(BIN_FALSE) )
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(_PACKAGEDIR_REAL_TARGET)
	$(BS_CMDPREFIX_VERBOSE2) ($(BIN_CD) $(_FROM) && $(BIN_TAR) cf - . ) | ( $(BIN_CD) $(_PACKAGEDIR_REAL_TARGET) && $(BIN_TAR) xvpf - )
	$(BS_CMDPREFIX_VERBOSE2) $(_SCRUB_RM) `$(foreach scrub,$(_SCRUB),$(BIN_FIND) $(_PACKAGEDIR_REAL_TARGET) -name $(scrub) -print ; )`
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_PACKAGEDIR_FLAG_TARGET)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_PACKAGEDIR_REAL_TARGET)

packaging_packagedir: $(_PACKAGEDIR_FLAG_TARGETS)



#
# Mkdir targets
#

PACKAGING_FUNC_GET_MKDIR_TARGET=$(PACKAGE_TARGET_DIR)/$(if $($(1)_DEST),$($(1)_DEST),$(1))
_MKDIR_TARGETS=$(foreach t,$(MKDIR_TARGETS),$(call PACKAGING_FUNC_GET_MKDIR_TARGET,$(t)))


ifneq ($(strip $(MKDIR_TARGETS)),)

package_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) cleaning package module MKDIR_TARGETS")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_MKDIR_TARGETS)

endif

$(_MKDIR_TARGETS):
$(_MKDIR_TARGETS): _T=$(notdir $(@))
$(_MKDIR_TARGETS): _MKDIR_TARGET=$(call PACKAGING_FUNC_GET_MKDIR_TARGET,$(_T))
$(_MKDIR_TARGETS): 
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Mkdir Target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Target Path                   : $(_MKDIR_TARGET)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(_MKDIR_TARGET)

packaging_mkdir: $(_MKDIR_TARGETS)



#
# hook module rules into build system
#

info:: packaging_info

man:: packaging_man

depends:: _PACKAGEFILE_DEP_PREP $(_PACKAGEFILE_DEP_GENERATION_TARGETS)
depends:: _PACKAGEDIR_DEP_PREP $(_PACKAGEDIR_DEP_GENERATION_TARGETS)
depends:: _ISO_DEP_PREP $(_ISO_DEP_GENERATION_TARGETS)
depends:: _TARGZ_DEP_PREP $(_TARGZ_DEP_GENERATION_TARGETS)
depends:: _ZIP_DEP_PREP $(_ZIP_DEP_GENERATION_TARGETS)
depends:: _EPM_DEP_PREP $(_EPM_DEP_GENERATION_TARGETS)
depends:: _RSYNCTREE_DEP_PREP $(_RSYNCTREE_DEP_GENERATION_TARGETS)

pretarget::

target::

posttarget:: packaging_packagefile
posttarget:: packaging_packagedir
posttarget:: packaging_mkdir
posttarget:: packaging_iso
posttarget:: packaging_targz
posttarget:: packaging_zip
posttarget:: packaging_epm

clean:: package_clean

nuke:: package_nuke

.PHONY:: packaging_info packaging_man


