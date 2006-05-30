



#
# Figure out from the maze of compatibility platforms and vtags where we actually want to
# import a component from. These functions all take one arg, the name of a pattern
# target as it appears in IMPORT_TARGETS, EXPORT_DESC_TARGETS, or DIST_TARGETS.
#
# Functions that do not start with a leeding "_" are considered public,
# and may be used by point makefiles.
#
_IMPORT_FUNC_COMPUTE_PLATFORMLIST=$(strip $(if $($(1)_PLATFORM),$($(1)_PLATFORM),$(COMPONENT_DEFAULT_PLATFORM_LIST)))
_IMPORT_FUNC_COMPUTE_VTAG=$(strip $(if $($(1)_VTAG),$($(1)_VTAG),$(BS_VTAG)))
_IMPORT_FUNC_COMPUTE_REV=$(strip $(if $($(1)_REV),$($(1)_REV),-UNSPECIFIED-))
_IMPORT_FUNC_COMPUTE_DISTROOT=$(strip $(if $($(1)_DISTROOT),$($(1)_DISTROOT),$(COMPONENT_DISTROOT)))
_IMPORT_FUNC_COMPUTE_DISTNAME=$(strip $(if $($(1)_DISTNAME),$($(1)_DISTNAME),$(1)))

_IMPORT_FUNC_COMPUTE_FROMPATH=$(strip $(if $($(1)_FROM),$($(1)_FROM),\
	$(word 1,\
		$(foreach platform,$(call _IMPORT_FUNC_COMPUTE_PLATFORMLIST,$(1)),$(wildcard $(call _IMPORT_FUNC_COMPUTE_DISTROOT,$(1))/$(call _IMPORT_FUNC_COMPUTE_DISTNAME,$(1))/$(call _IMPORT_FUNC_COMPUTE_REV,$(1))/$(platform)$(if $(call _IMPORT_FUNC_COMPUTE_VTAG,$(1)),-$(call _IMPORT_FUNC_COMPUTE_VTAG,$(1))) ))\
		$(foreach platform,$(call _IMPORT_FUNC_COMPUTE_PLATFORMLIST,$(1)),$(wildcard $(call _IMPORT_FUNC_COMPUTE_DISTROOT,$(1))/$(call _IMPORT_FUNC_COMPUTE_DISTNAME,$(1))/$(call _IMPORT_FUNC_COMPUTE_REV,$(1))/$(platform))))))

_IMPORT_FUNC_COMPUTE_TARGETDIR_WITH_KNOWN_COMPONENT_WORKER=$(strip $(if $($(1)_TO),$($(1)_TO),$(subst $(call _IMPORT_FUNC_COMPUTE_DISTROOT,$(1)),$(COMPONENT_IMPORT_TARGET_ROOT),$(call _IMPORT_FUNC_COMPUTE_FROMPATH,$(1)))))

_IMPORT_FUNC_COMPUTE_TARGETDIR_WITH_KNOWN_COMPONENT=$(if $(strip $(call _IMPORT_FUNC_COMPUTE_TARGETDIR_WITH_KNOWN_COMPONENT_WORKER,$(strip $(1)))),$(strip $(call _IMPORT_FUNC_COMPUTE_TARGETDIR_WITH_KNOWN_COMPONENT_WORKER,$(strip $(1)))),_CANT_FIND_COMPONENT_$(1))

_IMPORT_FUNC_COMPUTE_TARGETDIR=$(if $(strip $(findstring $(1),$(IMPORT_TARGETS))),$(call _IMPORT_FUNC_COMPUTE_TARGETDIR_WITH_KNOWN_COMPONENT,$(1)),_UNKNOWN_COMPONENT_$(strip $(1)))

_IMPORT_FUNC_COMPUTE_DESCFILE=$(call _IMPORT_FUNC_COMPUTE_TARGETDIR,$(1))/$(1)-component.xml

# Public accessor to internal function with a name consistant with 
# build3's external naming (i.e., it uses a prefix identifying
# the build3 module that owns it)
COMPONENT_FUNC_IMPORT_COMPUTE_TARGETDIR=$(call _IMPORT_FUNC_COMPUTE_TARGETDIR,$(1))

_EXPORTDESC_FUNC_COMPUTE_REV=$(strip $(if $($(1)_REV),$($(1)_REV),$(BS_DATE_YEAR)-$(BS_DATE_MONTH)-$(BS_DATE_DAY))$(if $(COMPONENT_DISTTAG),_$(COMPONENT_DISTTAG),))
_EXPORTDESC_FUNC_COMPUTE_DISTROOT=$(call _IMPORT_FUNC_COMPUTE_DISTROOT,$(1))
_EXPORTDESC_FUNC_COMPUTE_DISTNAME=$(call _IMPORT_FUNC_COMPUTE_DISTNAME,$(1))
_EXPORTDESC_FUNC_COMPUTE_PLATFORMLIST=$(call _IMPORT_FUNC_COMPUTE_PLATFORMLIST,$(1))

_DIST_FUNC_COMPUTE_REV=$(call _EXPORTDESC_FUNC_COMPUTE_REV,$(1))
_DIST_FUNC_COMPUTE_DISTROOT=$(call _EXPORTDESC_FUNC_COMPUTE_DISTROOT,$(1))
_DIST_FUNC_COMPUTE_DISTNAME=$(call _EXPORTDESC_FUNC_COMPUTE_DISTNAME,$(1))
_DIST_FUNC_COMPUTE_PLATFORMLIST=$(call _EXPORTDESC_FUNC_COMPUTE_PLATFORMLIST,$(1))

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
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_DISTROOT                                 $(COMPONENT_DISTROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_DEFAULT_PLATFORM_LIST                    $(COMPONENT_DEFAULT_PLATFORM_LIST)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_DIST_COMPATIBILITY_PLATFORMS             $(COMPONENT_DIST_COMPATIBILITY_PLATFORMS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_DIST_COMPATIBILITY_PLATFORMS_AND_VTAG    $(COMPONENT_DIST_COMPATIBILITY_PLATFORMS_AND_VTAG)")

	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_IMPORT_TARGET_ROOT                       $(COMPONENT_IMPORT_TARGET_ROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_DISTTAG                                  $(COMPONENT_DISTTAG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) IMPORT_TARGETS                                     $(IMPORT_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) DIST_TARGETS                                       $(DIST_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) EXPORT_DESC_TARGETS                                $(EXPORT_DESC_TARGETS)")


# We delibriatly do not remove import targets during a clean
# wait for nukes do do that.
component_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning import/dist targets. - Nothing to do. Build a \"nuke\" to delete imports.")

component_nuke::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Nuking import and dist targets")





#
# Import targets
#

_IMPORT_TARGETS=$(IMPORT_TARGETS)
_IMPORT_DEP_GENERATION_TARGETS=$(addprefix _IMPORT_DEP_,$(IMPORT_TARGETS))
_IMPORT_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/component_depend_import.mk
_IMPORT_DESC_TARGETS=$(foreach t,$(IMPORT_TARGETS),$(call _IMPORT_FUNC_COMPUTE_DESCFILE,$(t)))



ifneq ($(strip $(IMPORT_TARGETS)),)
-include $(_IMPORT_DEPEND_FILE)

component_nuke::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Nuking import targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(COMPONENT_IMPORT_TARGET_ROOT)
endif



$(_IMPORT_DEPEND_FILE): _IMPORT_DEP_PREP $(_IMPORT_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _IMPORT_DEP_PREP $(_IMPORT_DEP_GENERATION_TARGETS)


_IMPORT_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_IMPORT_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_IMPORT_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_IMPORT_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for import targets" >> $(_IMPORT_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_IMPORT_DEPEND_FILE)



_IMPORT_DEP_%:
_IMPORT_DEP_%: _IMPORT_T=$(*)
_IMPORT_DEP_%: _FROMPATH=$(call _IMPORT_FUNC_COMPUTE_FROMPATH,$(_IMPORT_T))
_IMPORT_DEP_%: _DESC=$(call _IMPORT_FUNC_COMPUTE_DESCFILE,$(_IMPORT_T))
_IMPORT_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for import target $(*) ")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## import target:  $(_IMPORT_T)" >> $(_IMPORT_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_DESC): $(_FROMPATH)" >> $(_IMPORT_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_IMPORT_DEPEND_FILE)




#
# The component descriptor file is used as a flag target for the import of a dir.
#
$(_IMPORT_DESC_TARGETS): 
$(_IMPORT_DESC_TARGETS): # strip down the /import/target/dir/<component-name>-component.xml to just <component name>
$(_IMPORT_DESC_TARGETS): _T=$(strip $(word 1,$(subst -component.xml,,$(notdir $@))))
$(_IMPORT_DESC_TARGETS):
$(_IMPORT_DESC_TARGETS): _DESC=$@
$(_IMPORT_DESC_TARGETS): 
$(_IMPORT_DESC_TARGETS): _TO=$(call _IMPORT_FUNC_COMPUTE_TARGETDIR,$(_T))
$(_IMPORT_DESC_TARGETS): _FROMPATH=$(call _IMPORT_FUNC_COMPUTE_FROMPATH,$(_T))
$(_IMPORT_DESC_TARGETS):
$(_IMPORT_DESC_TARGETS): _DISTNAME=$(call _IMPORT_FUNC_COMPUTE_DISTNAME,$(_T))
$(_IMPORT_DESC_TARGETS): _PLATFORMLIST=$(call _IMPORT_FUNC_COMPUTE_PLATFORMLIST,$(_T))
$(_IMPORT_DESC_TARGETS): _VTAG=$(call _IMPORT_FUNC_COMPUTE_VTAG,$(_T))
$(_IMPORT_DESC_TARGETS): _REV=$(call _IMPORT_FUNC_COMPUTE_REV,$(_T))
$(_IMPORT_DESC_TARGETS): _DISTROOT=$(call _IMPORT_FUNC_COMPUTE_DISTROOT,$(_T))
$(_IMPORT_DESC_TARGETS):
$(_IMPORT_DESC_TARGETS): _SAFETY_CMD=$(if $(_FROMPATH),,$(BIN_ECHO) "$(BS_ERROR_PREFIX) Import not found in component repository (dist area)" && $(BIN_FALSE))
$(_IMPORT_DESC_TARGETS): _DESC_FROM_DIST=$(wildcard $(_FROMPATH)/component.xml)
$(_IMPORT_DESC_TARGETS): _COMPONENTUTIL_ARGS=$(if $(_DESC_FROM_DIST),\
                              -I -f $(_DESC_FROM_DIST),\
                              -D -c $(_T) -r $(_REV) -a'Imported Component did not provide a component.xml file. This stub was auto generated by the importing rules.')
$(_IMPORT_DESC_TARGETS):
$(_IMPORT_DESC_TARGETS): 
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Importing target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Import Target Name                   : $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)       Component Dist Name                : $(_DISTNAME)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)       Component Version                  : $(_REV)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)       Component VTAG                     : $(_VTAG)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)       Component DISTROOT                 : $(_DISTROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)       Component Platform List            : $(_PLATFORMLIST)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)       Component Descriptor File          : $(_DESC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)       Component Import Target Directory  : $(_TO)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)       Component Import From Directory    : $(_FROMPATH)")
	$(BS_CMDPREFIX_VERBOSE2) $(_SAFETY_CMD)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(_TO)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CP) -R $(_FROMPATH)/* $(_TO)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_TO)/component.xml
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_COMPONENTUTIL) -o $(_DESC) -i $(_FROMPATH) $(_COMPONENTUTIL_ARGS)


#
# Dist targets - create components for others to import
#

_EXPORT_DESC_TARGETS=$(foreach d,$(addprefix $(BS_ARCH_TARGET_DIR)/,$(DIST_TARGETS)),$(d).xml) $(foreach d,$(addprefix $(BS_ARCH_TARGET_DIR)/,$(EXPORT_DESC_TARGETS)),$(d).xml)

_DIST_TARGETS=$(addprefix _PHONY_DIST_/,$(DIST_TARGETS))



$(_EXPORT_DESC_TARGETS):
$(_EXPORT_DESC_TARGETS):
$(_EXPORT_DESC_TARGETS): _EXPORTDESC=$(@)
$(_EXPORT_DESC_TARGETS): _T=$(notdir $(@:%.xml=%))
$(_EXPORT_DESC_TARGETS): _DISTROOT=$(call _EXPORTDESC_FUNC_COMPUTE_DISTROOT,$(_T))
$(_EXPORT_DESC_TARGETS): _DISTNAME=$(call _EXPORTDESC_FUNC_COMPUTE_DISTNAME,$(_T))
$(_EXPORT_DESC_TARGETS): _REV=$(call _EXPORTDESC_FUNC_COMPUTE_REV,$(_T))
$(_EXPORT_DESC_TARGETS):
$(_EXPORT_DESC_TARGETS): _PLATFORM=$(strip $(word 1,$(call _EXPORTDESC_FUNC_COMPUTE_PLATFORMLIST,$(_T))))
$(_EXPORT_DESC_TARGETS): _PLATFORM_AND_VTAG=$(_PLATFORM)$(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG)))
$(_EXPORT_DESC_TARGETS): _PLATFORMLINKS_TMP=$(if $($(_T)_PLATFORMLINKS),$($(_T)_PLATFORMLINKS),)
$(_EXPORT_DESC_TARGETS): _PLATFORMLINKS=$(sort $(filter-out $(_PLATFORM_AND_VTAG), $(_PLATFORMLINKS_TMP)))
$(_EXPORT_DESC_TARGETS):
$(_EXPORT_DESC_TARGETS): _TO_DEFAULT=$(_DISTROOT)/$(_DISTNAME)/$(_REV)/$(_PLATFORM_AND_VTAG)
$(_EXPORT_DESC_TARGETS): _TO=$(if $($(_T)_TO),$($(_T)_TO),$(_TO_DEFAULT))
$(_EXPORT_DESC_TARGETS): _FROM=$(if $($(_T)_FROM),$($(_T)_FROM),./)
$(_EXPORT_DESC_TARGETS): _COMMENT=$(if $($(_T)_COMMENT),$($(_T)_COMMENT),$(_T) component DIST created at $(BS_DATE_YEAR)-$(BS_DATE_MONTH)-$(BS_DATE_DAY) $(BS_DATE_HOUR):$(BS_DATE_MINUTE):$(BS_DATE_SECOND) on $(BS_OS_HOSTNAME))
$(_EXPORT_DESC_TARGETS): _IMPORT_DESCS=$(strip $(foreach import,$(IMPORT_TARGETS),$(call _IMPORT_FUNC_COMPUTE_DESCFILE,$(import))))
$(_EXPORT_DESC_TARGETS): 
$(_EXPORT_DESC_TARGETS): _PLATFORMLINKS_FLAGS=$(if $(_PLATFORMLINKS),-m'$(_PLATFORMLINKS)',)
$(_EXPORT_DESC_TARGETS): _IMPORT_DESCS_FLAGS=$(if $(_IMPORT_DESCS),-l'$(_IMPORT_DESCS)',)
$(_EXPORT_DESC_TARGETS): _VARIANT_FLAGS=$(if $(BS_VTAG),-v'$(BS_VTAG)',)
$(_EXPORT_DESC_TARGETS): 
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Generating Component Descriptor $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Target              : $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Descriptor     : $(_EXPORTDESC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Rev            : $(_REV)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Platform       : $(_PLATFORM)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Platform Links : $(_PLATFORMLINKS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component DISTROOT       : $(_DISTROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component TO Directory   : $(_TO)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component FROM Directory : $(_FROM)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Variant Tag    : $(BS_VTAG)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_COMPONENTUTIL) -o $(_EXPORTDESC) -D -c $(_DISTNAME) -r $(_REV) -p $(_PLATFORM) -d $(_TO) -a'$(_COMMENT)' $(_PLATFORMLINKS_FLAGS) $(_VARIANT_FLAGS) $(_IMPORT_DESCS_FLAGS)


$(_DIST_TARGETS):
$(_DIST_TARGETS):
$(_DIST_TARGETS): _T=$(notdir $(@))
$(_DIST_TARGETS): _EXPORTDESC=$(BS_ARCH_TARGET_DIR)/$(_T).xml
$(_DIST_TARGETS):
$(_DIST_TARGETS): _DISTROOT=$(call _DIST_FUNC_COMPUTE_DISTROOT,$(_T))
$(_DIST_TARGETS): _DISTNAME=$(call _DIST_FUNC_COMPUTE_DISTNAME,$(_T))
$(_DIST_TARGETS):
$(_DIST_TARGETS): _REV=$(call _DIST_FUNC_COMPUTE_REV,$(_T))
$(_DIST_TARGETS): _REVLINKS=$(sort $(filter-out $(_REV),$($(_T)_REVLINKS)))
$(_DIST_TARGETS): _REV_LINK_TO=$(_REV)
$(_DIST_TARGETS):
$(_DIST_TARGETS): _PLATFORM=$(strip $(word 1,$(call _DIST_FUNC_COMPUTE_PLATFORMLIST,$(_T))))
$(_DIST_TARGETS): _PLATFORM_AND_VTAG=$(_PLATFORM)$(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG)))
$(_DIST_TARGETS): _PLATFORMLINKS_TMP=$(if $($(_T)_PLATFORMLINKS),$($(_T)_PLATFORMLINKS),)
$(_DIST_TARGETS): _PLATFORMLINKS=$(sort $(filter-out $(_PLATFORM_AND_VTAG), $(_PLATFORMLINKS_TMP)))
$(_DIST_TARGETS):
$(_DIST_TARGETS): _TO_DEFAULT=$(_DISTROOT)/$(_DISTNAME)/$(_REV)/$(_PLATFORM_AND_VTAG)
$(_DIST_TARGETS): _TO=$(if $($(_T)_TO),$($(_T)_TO),$(_TO_DEFAULT))
$(_DIST_TARGETS): _PLAT_LINK_TO=$(notdir $(_TO))
$(_DIST_TARGETS): _FROM=$(if $($(_T)_FROM),$($(_T)_FROM),./)
$(_DIST_TARGETS): 
$(_DIST_TARGETS): _SCRUB=$(if $($(_T)_SCRUB),$($(_T)_SCRUB),)
$(_DIST_TARGETS): _SCRUB_RM=$(if $(_SCRUB),$(BIN_RM) -rf,$(BIN_TRUE))
$(_DIST_TARGETS): 
$(_DIST_TARGETS): _REEXPORT=$($(_T)_REEXPORT)
$(_DIST_TARGETS): _REEXPORT_FROMS=$(foreach reex,$(_REEXPORT),$(call _IMPORT_FUNC_COMPUTE_FROMPATH,$(reex)))
$(_DIST_TARGETS): 
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Pushing Dist Target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Dist Target                     : $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Dist Name             : $(_DISTNAME)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Descriptor            : $(_EXPORTDESC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Rev                   : $(_REV)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Rev Links             : $(_REV_LINKS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Platform              : $(_PLATFORM)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Platform Links        : $(_PLATFORMLINKS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component DISTROOT              : $(_DISTROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component TO Directory          : $(_TO)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component FROM Directory        : $(_FROM)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Component Scrub                 : $(_SCRUB)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Variant Tag                     : $(BS_VTAG)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)   Re-Exported Components:         : $(_REEXPORT)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_TO)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(_TO)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CP) -R $(_FROM)/* $(_TO)
	$(BS_CMDPREFIX_VERBOSE2) $(foreach reex_dir,$(_REEXPORT_FROMS),$(BIN_CP) -R $(reex_dir)/* $(_TO) &&) $(BIN_TRUE)
	$(BS_CMDPREFIX_VERBOSE2) $(foreach platlink,$(_PLATFORMLINKS), $(BIN_CD) $(_TO)/.. && $(BIN_RM) -f $(platlink) && $(BIN_LN) -s $(_PLAT_LINK_TO) $(platlink)  ;)
	$(BS_CMDPREFIX_VERBOSE2) $(foreach revlink,$(_REVLINKS), $(BIN_CD) $(_TO)/../.. && $(BIN_RM) -f $(revlink) && $(BIN_LN) -s $(_REV_LINK_TO) $(revlink)  ;)
	$(BS_CMDPREFIX_VERBOSE2) $(_SCRUB_RM) `$(foreach scrub,$(_SCRUB),$(BIN_FIND) $(_TO) -name $(scrub) -print ; )`
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CP) $(_EXPORTDESC) $(_TO)/component.xml


# We got lazy, and this isn't a pattern target. I'm not sure there really is call to make
# this a full blown pattern target that can archive an arbitrary slice of the repository
# that is independant from the IMPORT pattern targets.
#
$(BS_ARCH_TARGET_DIR)/imported_components.tar.gz:
$(BS_ARCH_TARGET_DIR)/imported_components.tar.gz: _DIST_FROMS=$(foreach import,$(IMPORT_TARGETS),$(call _IMPORT_FUNC_COMPUTE_FROMPATH,$(import)))
$(BS_ARCH_TARGET_DIR)/imported_components.tar.gz:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Shadowing Arch Components from the following locations: $(_ARCH_DIST_FROMS)")
	$(if $(strip $(_DIST_FROMS)),$(BIN_TAR) cvhf - $(_DIST_FROMS) | $(BIN_GZIP) -v9 > $@,$(BIN_TOUCH) $@)

component_shadow: $(BS_ARCH_TARGET_DIR)/imported_components.tar.gz

component_import: $(_IMPORT_DESC_TARGETS)

component_desc: $(_EXPORT_DESC_TARGETS)

component_dist: $(_EXPORT_DESC_TARGETS)
component_dist: $(_DIST_TARGETS)

#
# hook module rules into build system.
#


info:: component_info

man:: component_man

clean:: component_clean

nuke:: component_nuke

depends:: _IMPORT_DEP_PREP $(_IMPORT_DEP_GENERATION_TARGETS)

pretarget::

target:: component_import

posttarget:: component_desc
posttarget:: component_dist

.PHONY:: component_info component_man component_dist component_desc $(_EXPORT_DESC_TARGETS) $(_DIST_TARGETS)

