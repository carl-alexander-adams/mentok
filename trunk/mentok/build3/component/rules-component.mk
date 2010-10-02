#
# Module rules
#
component_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Component Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_BSCATMAN) $(BS_ROOT)/component/component.html

component_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Component Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_DEPOTURL_IMPORT                          $(COMPONENT_DEPOTURL_IMPORT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_DEPOTURL_DIST                            $(COMPONENT_DEPOTURL_DIST)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_IMPORT_ROOT                              $(COMPONENT_IMPORT_ROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_IMPORT_ROOT_ABSPATH                      $(COMPONENT_IMPORT_ROOT_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_IMPORT_DIR                               $(COMPONENT_IMPORT_DIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_IMPORT_DIR_ABSPATH                       $(COMPONENT_IMPORT_DIR_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) IMPORTRPM_TARGETS                                  $(IMPORTRPM_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BULKDIST_TARGETS                                   $(BULKDIST_TARGETS)")


# We delibriatly do not remove import targets during a clean
# wait for nukes do do that.
component_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning import/dist targets. - Nothing to do. Build a \"nuke\" to delete imports.")

component_nuke::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Nuking ImportRPM targets")
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_RM) -rf $(COMPONENT_IMPORT_ROOT)




#
# ImportRPM targets - import and unpack an RPM
#
COMPONENT_FUNC_GET_IMPORTRPM_FLAGTARGET=$(BS_ARCH_TARGET_DIR)/component_flags_importrpm/$(1)
_IMPORTRPM_FLAG_TARGETS=$(foreach t,$(IMPORTRPM_TARGETS),$(call COMPONENT_FUNC_GET_IMPORTRPM_FLAGTARGET,$(t)))
_IMPORTRPM_DEP_GENERATION_TARGETS=$(addprefix _IMPORTRPM_DEP_,$(IMPORTRPM_TARGETS))
_IMPORTRPM_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/component_depend_importrpm.mk

ifneq ($(strip $(IMPORTRPM_TARGETS)),)
-include $(_IMPORTRPM_DEPEND_FILE)
endif


$(_IMPORTRPM_DEPEND_FILE): _IMPORTRPM_DEP_PREP $(_IMPORTRPM_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _IMPORTRPM_DEP_PREP $(_IMPORTRPM_DEP_GENERATION_TARGETS)


_IMPORTRPM_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_IMPORTRPM_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_IMPORTRPM_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(BS_ARCH_TARGET_DIR)/component_flags_importrpm
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_IMPORTRPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for ImportRPM targets" >> $(_IMPORTRPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_IMPORTRPM_DEPEND_FILE)



#
# Since imports "from" may be a URL, we cannot have proper dependency on the import package.
# 
_IMPORTRPM_DEP_%:
_IMPORTRPM_DEP_%: _IMPORTRPM_T=$(*)
_IMPORTRPM_DEP_%: _IMPORTRPM_FLAG_TARGET=$(call COMPONENT_FUNC_GET_IMPORTRPM_FLAGTARGET,$*)
_IMPORTRPM_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for ImportRPM target $(*) ")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## ImportRPM target:  $(_IMPORTRPM_T)" >> $(_IMPORTRPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_IMPORTRPM_FLAG_TARGET): " >> $(_IMPORTRPM_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_IMPORTRPM_DEPEND_FILE)



# RPM seems to have some pretty bad URL fetching code. use curl to fetch RPM.
# --prefix is conditional on user != 'root' because if root rpm will chroot() (Maybe we should shift to rpm2cpio?)
$(_IMPORTRPM_FLAG_TARGETS): 
$(_IMPORTRPM_FLAG_TARGETS): _T=$(notdir $@)
$(_IMPORTRPM_FLAG_TARGETS):
$(_IMPORTRPM_FLAG_TARGETS): _FLAG_TARGET=$(@)
$(_IMPORTRPM_FLAG_TARGETS):
$(_IMPORTRPM_FLAG_TARGETS): _TO=$(if $($(_T)_TO),$($(_T)_TO),$(COMPONENT_IMPORT_DIR_ABSPATH))
$(_IMPORTRPM_FLAG_TARGETS):
$(_IMPORTRPM_FLAG_TARGETS): _DEPOTURL=$(if $($(_T)_DEPOTURL),$($(_T)_DEPOTURL),$(COMPONENT_DEPOTURL_IMPORT))
$(_IMPORTRPM_FLAG_TARGETS): _PKGFILE=$(if $($(_T)_PKGFILE),$($(_T)_PKGFILE),$(_DEPOTURL)/$(_T))
$(_IMPORTRPM_FLAG_TARGETS):
$(_IMPORTRPM_FLAG_TARGETS): _PKGFILE_REMOTE=$(filter http:% https:% ftp:%,$(_PKGFILE))
$(_IMPORTRPM_FLAG_TARGETS): _PKGFILE_BASENAME=$(notdir $(_PKGFILE))
$(_IMPORTRPM_FLAG_TARGETS): _PKGFILE_DOWNLOADED=$(if $(_PKGFILE_REMOTE),$(BS_ARCH_TARGET_DIR)/$(_PKGFILE_BASENAME),)
$(_IMPORTRPM_FLAG_TARGETS):
$(_IMPORTRPM_FLAG_TARGETS): _FETCH_CMD=$(if $(_PKGFILE_REMOTE),$(BIN_CURL) --insecure --fail --silent -o $(_PKGFILE_DOWNLOADED) $(_PKGFILE_REMOTE),)
$(_IMPORTRPM_FLAG_TARGETS): _INSTPKG=$(if $(_FETCH_CMD),$(_PKGFILE_DOWNLOADED),$(_PKGFILE))
$(_IMPORTRPM_FLAG_TARGETS): _CLEANUP_CMD=$(if $(_FETCH_CMD),$(BIN_RM) -f $(_PKGFILE_DOWNLOADED),)
$(_IMPORTRPM_FLAG_TARGETS):
$(_IMPORTRPM_FLAG_TARGETS): _PREFIX_ARG=$(if $(filter root,$(BS_USERNAME)),,--prefix $(_TO))
$(_IMPORTRPM_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Importing ImportRPM target $(_T) from $(_PKGFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     ImportRPM Target                    : $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     ImportRPM Package File              : $(_PKGFILE)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     ImportRPM Depot                     : $(_DEPOTURL)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     ImportRPM Package File (Remote)     : $(_PKGFILE_REMOTE)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     ImportRPM Package File (Downloaded) : $(_PKGFILE_DOWNLOADED)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     ImportRPM Destination Dir           : $(_TO)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     ImportRPM Flag Target               : $(_FLAG_TARGET)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(_TO)/.rpmdb
	$(BS_CMDPREFIX_VERBOSE1) $(_FETCH_CMD)
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_RPM) --nouser --nogroup --nodeps --nopost --notriggers --root $(_TO)  --dbpath .rpmdb  $(_PREFIX_ARG)  -hiv $(_INSTPKG)
	$(BS_CMDPREFIX_VERBOSE2) $(_CLEANUP_CMD)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_FLAG_TARGET)




#
# Bulk Dist targets - export package files from a manifest to the dist area for others to import.
#

COMPONENT_FUNC_GET_BULKDIST_FLAGTARGET=$(BS_ARCH_TARGET_DIR)/component_flags_bulkdist/$(1)
_BULKDIST_FLAG_TARGETS=$(foreach t,$(BULKDIST_TARGETS),$(call COMPONENT_FUNC_GET_BULKDIST_FLAGTARGET,$(t)))
_BULKDIST_DEP_GENERATION_TARGETS=$(addprefix _BULKDIST_DEP_,$(BULKDIST_TARGETS))
_BULKDIST_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/component_depend_bulkdist.mk

ifneq ($(strip $(BULKDIST_TARGETS)),)
-include $(_BULKDIST_DEPEND_FILE)

component_nuke::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cannot nuke bulkdist targets")
endif


$(_BULKDIST_DEPEND_FILE): _BULKDIST_DEP_PREP $(_BULKDIST_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _BULKDIST_DEP_PREP $(_BULKDIST_DEP_GENERATION_TARGETS)

_BULKDIST_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_BULKDIST_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_BULKDIST_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(BS_ARCH_TARGET_DIR)/component_flags_bulkdist
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_BULKDIST_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for bulkdist targets" >> $(_BULKDIST_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_BULKDIST_DEPEND_FILE)


# XXX Manifest might not be build at "make depends" time (e.g. if it's the result of a "EPM_TARGETS").
# So we cannot add it to the depends.  Since we don't permit distribution to be clean-able
# or re-doable, we can sorta get away with this, but it's not ideal.
_BULKDIST_DEP_%:
_BULKDIST_DEP_%: _BULKDIST_T=$(*)
_BULKDIST_DEP_%:
_BULKDIST_DEP_%: _BULKDIST_FLAG_TARGET=$(call COMPONENT_FUNC_GET_BULKDIST_FLAGTARGET,$*)
_BULKDIST_DEP_%: _MANIFEST=$(if $($*_MANIFEST),$($*_MANIFEST),$*.manifest)
_BULKDIST_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for bulk dist target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_BULKDIST_FLAG_TARGET): $(_MANIFEST)" >> $(_BULKDIST_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_BULKDIST_DEPEND_FILE)


$(_BULKDIST_FLAG_TARGETS):
$(_BULKDIST_FLAG_TARGETS): _T=$(notdir $(@))
$(_BULKDIST_FLAG_TARGETS):
$(_BULKDIST_FLAG_TARGETS): _FLAG_TARGET=$(@)
$(_BULKDIST_FLAG_TARGETS):
$(_BULKDIST_FLAG_TARGETS): _MANIFEST=$(if $($(_T)_MANIFEST),$($(_T)_MANIFEST),$(_T).manifest)
$(_BULKDIST_FLAG_TARGETS): _MANIFEST_FILES=$(strip $(shell $(BIN_CAT) $(_MANIFEST) | $(BIN_SED) 's?#.*??' | $(BIN_SED) 's?^[ 	]*$$??' | $(BIN_SED) 's?^[^/]?$(BS_ARCH_TARGET_DIR)/?'))
$(_BULKDIST_FLAG_TARGETS):
$(_BULKDIST_FLAG_TARGETS): _DEPOTURL=$(if $($(_T)_DEPOTURL),$($(_T)_DEPOTURL),$(COMPONENT_DEPOTURL_DIST))
$(_BULKDIST_FLAG_TARGETS):
$(_BULKDIST_FLAG_TARGETS): _IS_FTP=$(strip $(filter ftp:%,$(_DEPOTURL)))
$(_BULKDIST_FLAG_TARGETS): _FLAGS=$(if $(_IS_FTP),--ftp-ssl-reqd,)
$(_BULKDIST_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Distributing Bulk Target $(_T) ($(notdir $(_MANIFEST_FILES)))")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Manifest File                  : $(_MANIFEST)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Manifest Contents              : $(_MANIFEST_FILES)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Depot URL                      : $(_DEPOTURL)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Extra CURL FLags               : $(_FLAGS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Flag Target                    : $(_FLAG_TARGET)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TEST) -n "$(_MANIFEST_FILES)" || ($(BIN_ECHO) "$(BS_ERROR_PREFIX) Manifest file \"$(_MANIFEST)\" must not be empty" && $(BIN_FALSE))
	$(BS_CMDPREFIX_VERBOSE0) $(foreach upload_file,$(notdir $(_MANIFEST_FILES)),(\
		($(BIN_CURL) $(_FLAGS) --insecure --fail --netrc --silent --head $(_DEPOTURL)/$(upload_file) > /dev/null ; $(BIN_TEST) $$? -ne 0)\
		|| ($(BIN_ECHO) "$(BS_WARN_PREFIX) WARNING: '$(_DEPOTURL)/$(upload_file)' already exists on depot server.  Overwrite not permitted."  && $(BIN_TOUCH) $(_FLAG_TARGET)) \
		)\
	&& ) $(BIN_TRUE)
	$(BS_CMDPREFIX_VERBOSE1) $(foreach upload_file,$(_MANIFEST_FILES),\
		( $(BIN_TEST) -f $(_FLAG_TARGET) || $(BIN_CURL) $(_FLAGS) --insecure --fail --netrc  --upload-file $(upload_file) $(_DEPOTURL)/$(notdir $(upload_file)) ) \
		&&) $(BIN_TRUE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_FLAG_TARGET)



component_import: $(_IMPORTRPM_FLAG_TARGETS)

component_dist: $(_BULKDIST_FLAG_TARGETS)



#
# hook module rules into build system.
#

info:: component_info

man:: component_man

clean:: component_clean

nuke:: component_nuke

depends:: _IMPORTRPM_DEP_PREP $(_IMPORTRPM_DEP_GENERATION_TARGETS)
depends:: _BULKDIST_DEP_PREP $(_BULKDIST_DEP_GENERATION_TARGETS)

pretarget::
#pretarget:: component_import

target::
#target:: component_import

posttarget:: component_dist

.PHONY:: component_info component_man component_dist $(_BULKDIST_FLAG_TARGETS) # $(_EXPORT_DESC_TARGETS) 

