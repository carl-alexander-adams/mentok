#
# Module functions.
#

COMPONENT_FUNC_GET_IMPORT_NOARCH_FLAGTARGET=$(COMPONENT_IMPORT_NOARCH_TARGET_DIR)/component_descriptors/$(1)_REV_$(if $($(1)_REV),$($(1)_REV),-UNSPECIFIED-).xml
COMPONENT_FUNC_GET_IMPORT_ARCH_FLAGTARGET=$(COMPONENT_IMPORT_ARCH_TARGET_DIR)/component_descriptors/$(1)_REV_$(if $($(1)_REV),$($(1)_REV),-UNSPECIFIED-).xml


#
# Figure out from the maze of compatibility platforms and vtags where we actually want to
# import a component from. Args are the per-comnent IMPORT_NOARCH_TARGET, REV, VTAG, and DISTROOT.
#
# FROM_PATH=$(call _IMPORT_FUNC_COMPUTE_IMPORT_NOARCH_FROMPATH_DEFAULT, $(_TARGET),$(_REV),$(_VTAG),$(_DISTROOT)))
#

_IMPORT_FUNC_COMPUTE_IMPORT_NOARCH_FROMPATH_DEFAULT=$(word 1,\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_NOARCH)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_NOARCH))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_1)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_2)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_3)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_4)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_1)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_2)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_3)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_4)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_1))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_2))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_3))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_4))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_1))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_2))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_3))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_4)))


#
# Figure out from the maze of compatibility platforms and vtags where we actually want to
# import a component from. Args are the per-comnent IMPORT_NOARCH_TARGET, REV, VTAG, and DISTROOT.
#
# FROM_PATH=$(call _IMPORT_FUNC_COMPUTE_IMPORT_ARCH_FROMPATH_DEFAULT, $(_TARGET),$(_REV),$(_VTAG),$(_DISTROOT)))
#

_IMPORT_FUNC_COMPUTE_IMPORT_ARCH_FROMPATH_DEFAULT=$(word 1,\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_1)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_2)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_3)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_4)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_1)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_2)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_3)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_4)$(if $(strip $(3)),-$(strip $(3))))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_1))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_2))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_3))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_FALLBACK_4))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_1))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_2))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_3))\
	$(wildcard $(4)/$(1)/$(2)/$(BS_PLATFORM_ARCH_LEGACYFALLBACK_4)))


#
# Module rules
#
component_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Component Module Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_BSCATMAN) $(BS_ROOT)/component/component.html

component_info:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Component Module Macro Settings"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) COMPONENT_DISTROOT                                 $(COMPONENT_DISTROOT)"
	@echo "$(BS_INFO_PREFIX) COMPONENT_DIST_COMPATIBILITY_PLATFORMS             $(COMPONENT_DIST_COMPATIBILITY_PLATFORMS)"
	@echo "$(BS_INFO_PREFIX) COMPONENT_DIST_COMPATIBILITY_PLATFORMS_AND_VTAG    $(COMPONENT_DIST_COMPATIBILITY_PLATFORMS_AND_VTAG)"

	@echo "$(BS_INFO_PREFIX) COMPONENT_IMPORT_TARGET_ROOT                       $(COMPONENT_IMPORT_TARGET_ROOT)"
	@echo "$(BS_INFO_PREFIX) COMPONENT_IMPORT_ARCH_TARGET_DIR                   $(COMPONENT_IMPORT_ARCH_TARGET_DIR)"
	@echo "$(BS_INFO_PREFIX) COMPONENT_IMPORT_NOARCH_TARGET_DIR                 $(COMPONENT_IMPORT_NOARCH_TARGET_DIR)"
	@echo "$(BS_INFO_PREFIX) COMPONENT_DISTTAG                                  $(COMPONENT_DISTTAG)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) IMPORT_ARCH_TARGETS                                $(IMPORT_ARCH_TARGETS)"
	@echo "$(BS_INFO_PREFIX) IMPORT_NOARCH_TARGETS                              $(IMPORT_NOARCH_TARGETS)"
	@echo "$(BS_INFO_PREFIX) DIST_TARGETS                                       $(DIST_TARGETS)"
	@echo "$(BS_INFO_PREFIX) EXPORT_DESC_TARGETS                                $(EXPORT_DESC_TARGETS)"


# We delibriatly do not remove import targets during a clean
# wait for nukes do do that.
component_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning import/dist targets"
	@echo "$(BS_INFO_PREFIX)  Nothing to do. Build a \"nuke\" to delete imports."

component_nuke::
	@echo "$(BS_INFO_PREFIX) Nuking import and dist targets"





#
# Import targets
#

_IMPORT_NOARCH_TARGETS=$(IMPORT_NOARCH_TARGETS)
_IMPORT_NOARCH_DEP_GENERATION_TARGETS=$(addprefix _IMPORT_NOARCH_DEP_,$(IMPORT_NOARCH_TARGETS))
#_IMPORT_NOARCH_DEPEND_FILE=$(COMPONENT_IMPORT_NOARCH_TARGET_DIR)/component_depend_import_noarch.mk
_IMPORT_NOARCH_DEPEND_FILE=$(BS_NOARCH_TARGET_DIR)/component_depend_import_noarch.mk
_IMPORT_NOARCH_DESC_TARGETS=$(foreach t,$(IMPORT_NOARCH_TARGETS),$(call COMPONENT_FUNC_GET_IMPORT_NOARCH_FLAGTARGET,$(t)))



_IMPORT_ARCH_TARGETS=$(IMPORT_ARCH_TARGETS)
_IMPORT_ARCH_DEP_GENERATION_TARGETS=$(addprefix _IMPORT_ARCH_DEP_,$(IMPORT_ARCH_TARGETS))
#_IMPORT_ARCH_DEPEND_FILE=$(COMPONENT_IMPORT_ARCH_TARGET_DIR)/component_depend_import_arch.mk
_IMPORT_ARCH_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/component_depend_import_arch.mk
_IMPORT_ARCH_DESC_TARGETS=$(foreach t,$(IMPORT_ARCH_TARGETS),$(call COMPONENT_FUNC_GET_IMPORT_ARCH_FLAGTARGET,$(t)))




ifneq ($(strip $(IMPORT_ARCH_TARGETS)),)
-include $(_IMPORT_ARCH_DEPEND_FILE)

component_nuke::
	@echo "$(BS_INFO_PREFIX) Nuking architecture specific import targets"
	$(BIN_RM) -rf $(COMPONENT_IMPORT_ARCH_TARGET_DIR)
endif

ifneq ($(strip $(IMPORT_NOARCH_TARGETS)),)
-include $(_IMPORT_NOARCH_DEPEND_FILE)

component_nuke::
	@echo "$(BS_INFO_PREFIX) Nuking architecture neutral import targets"
	$(BIN_RM) -rf $(COMPONENT_IMPORT_NOARCH_TARGET_DIR)
endif




$(_IMPORT_ARCH_DEPEND_FILE): _IMPORT_ARCH_DEP_PREP $(_IMPORT_ARCH_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _IMPORT_ARCH_DEP_PREP $(_IMPORT_ARCH_DEP_GENERATION_TARGETS)


$(_IMPORT_NOARCH_DEPEND_FILE): _IMPORT_NOARCH_DEP_PREP $(_IMPORT_NOARCH_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _IMPORT_NOARCH_DEP_PREP $(_IMPORT_NOARCH_DEP_GENERATION_TARGETS)


_IMPORT_ARCH_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_IMPORT_ARCH_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_IMPORT_ARCH_DEPEND_FILE))
	$(BIN_MKDIR) -p $(COMPONENT_IMPORT_ARCH_TARGET_DIR)/component_descriptors
	echo "##" > $(_IMPORT_ARCH_DEPEND_FILE)
	echo "## Auto generated depend file for import targets" >> $(_IMPORT_ARCH_DEPEND_FILE)
	echo "##" >> $(_IMPORT_ARCH_DEPEND_FILE)

_IMPORT_NOARCH_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_IMPORT_NOARCH_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_IMPORT_NOARCH_DEPEND_FILE))
	$(BIN_MKDIR) -p $(COMPONENT_IMPORT_NOARCH_TARGET_DIR)/component_descriptors
	echo "##" > $(_IMPORT_NOARCH_DEPEND_FILE)
	echo "## Auto generated depend file for import targets" >> $(_IMPORT_NOARCH_DEPEND_FILE)
	echo "##" >> $(_IMPORT_NOARCH_DEPEND_FILE)
	echo "_DESC_TARGETS $(_IMPORT_NOARCH_DESC_TARGETS)"

_IMPORT_ARCH_DEP_%:
_IMPORT_ARCH_DEP_%: _IMPORT_T=$(*)
_IMPORT_ARCH_DEP_%: _REV=$(if $($*_REV),$($*_REV),-UNSPECIFIED-)
_IMPORT_ARCH_DEP_%: _DESC=$(COMPONENT_IMPORT_ARCH_TARGET_DIR)/component_descriptors/$(_IMPORT_T)_REV_$(_REV)
_IMPORT_ARCH_DEP_%: _VTAG=$(if $($*_VTAG),$($*_VTAG),$(BS_VTAG))
_IMPORT_ARCH_DEP_%: 
_IMPORT_ARCH_DEP_%: _TO=$(if $($*_TO),$($*_TO),$(COMPONENT_IMPORT_ARCH_TARGET_DIR))
_IMPORT_ARCH_DEP_%: _DISTROOT=$(if $($*_DISTROOT),$($*_DISTROOT),$(COMPONENT_DISTROOT))
_IMPORT_ARCH_DEP_%:
_IMPORT_ARCH_DEP_%: _FROM_FROM=$($*_FROM)
_IMPORT_ARCH_DEP_%: _FROM_DEFAULT=$(call _IMPORT_FUNC_COMPUTE_IMPORT_ARCH_FROMPATH_DEFAULT,$(_IMPORT_T),$(_REV),$(_VTAG),$(_DISTROOT)) 
_IMPORT_ARCH_DEP_%:
_IMPORT_ARCH_DEP_%: _FROM_AUTO=$(if $(_FROM_FROM),$(_FROM_FROM),$(_FROM_DEFAULT))
_IMPORT_ARCH_DEP_%:
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for import target $(*) "
	@echo "## import target: $(_IMPORT_T)" >> $(_IMPORT_ARCH_DEPEND_FILE)
	@echo "$(_DESC): $(_FROM_AUTO)" >> $(_IMPORT_ARCH_DEPEND_FILE)
	@echo "" >> $(_IMPORT_ARCH_DEPEND_FILE)
	$(BIN_MKDIR) -p $(COMPONENT_IMPORT_ARCH_TARGET_DIR)/component_descriptors


#
# Noarch targets need to fall back onto importing from arch dirs for backwards
# compatibility with the distroot.
#
_IMPORT_NOARCH_DEP_%:
_IMPORT_NOARCH_DEP_%: _IMPORT_T=$(*)
_IMPORT_NOARCH_DEP_%: _REV=$(if $($*_REV),$($*_REV),-UNSPECIFIED-)
_IMPORT_NOARCH_DEP_%: _DESC=$(COMPONENT_IMPORT_NOARCH_TARGET_DIR)/component_descriptors/$(_IMPORT_T)_REV_$(_REV)
_IMPORT_NOARCH_DEP_%: _VTAG=$(if $($*_VTAG),$($*_VTAG),$(BS_VTAG))
_IMPORT_NOARCH_DEP_%: 
_IMPORT_NOARCH_DEP_%: _TO=$(if $($*_TO),$($*_TO),$(COMPONENT_IMPORT_NOARCH_TARGET_DIR))
_IMPORT_NOARCH_DEP_%: _DISTROOT=$(if $($*_DISTROOT),$($*_DISTROOT),$(COMPONENT_DISTROOT))
_IMPORT_NOARCH_DEP_%:
_IMPORT_NOARCH_DEP_%: _FROM_FROM=$($*_FROM)
_IMPORT_NOARCH_DEP_%: _FROM_DEFAULT=$(call _IMPORT_FUNC_COMPUTE_IMPORT_NOARCH_FROMPATH_DEFAULT,$(_IMPORT_T),$(_REV),$(_VTAG),$(_DISTROOT)) 
_IMPORT_NOARCH_DEP_%:
_IMPORT_NOARCH_DEP_%: _FROM_AUTO=$(if $(_FROM_FROM),$(_FROM_FROM),$(_FROM_DEFAULT))
_IMPORT_NOARCH_DEP_%:
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for import target $(*) "
	@echo "## import target:  $(_IMPORT_T)" >> $(_IMPORT_NOARCH_DEPEND_FILE)
	@echo "$(_DESC): $(_FROM_AUTO)" >> $(_IMPORT_NOARCH_DEPEND_FILE)
	@echo "" >> $(_IMPORT_NOARCH_DEPEND_FILE)
	$(BIN_MKDIR) -p $(COMPONENT_IMPORT_NOARCH_TARGET_DIR)/component_descriptors





# XXX Play around with shadowtree to do import as symlinks.



$(_IMPORT_ARCH_DESC_TARGETS): 
$(_IMPORT_ARCH_DESC_TARGETS): _T=$(word 1,$(subst _REV_, ,$(notdir $@)))
$(_IMPORT_ARCH_DESC_TARGETS): _DESC=$@
$(_IMPORT_ARCH_DESC_TARGETS): _DESC_DIR=$(dir $@)
$(_IMPORT_ARCH_DESC_TARGETS): _REV=$(if $($(_T)_REV),$($(_T)_REV),-UNSPECIFIED-)
$(_IMPORT_ARCH_DESC_TARGETS): _TO=$(if $($(_T)_TO),$($(_T)_TO),$(COMPONENT_IMPORT_ARCH_TARGET_DIR))
$(_IMPORT_ARCH_DESC_TARGETS): _DISTROOT=$(if $($(_T)_DISTROOT),$($(_T)_DISTROOT),$(COMPONENT_DISTROOT))
$(_IMPORT_ARCH_DESC_TARGETS): _VTAG=$(if $($(_T)_VTAG),$($(_T)_VTAG),$(BS_VTAG))
$(_IMPORT_ARCH_DESC_TARGETS): 
$(_IMPORT_ARCH_DESC_TARGETS): _FROM_FROM=$($(_T)_FROM)
$(_IMPORT_ARCH_DESC_TARGETS): _FROM_DEFAULT=$(call _IMPORT_FUNC_COMPUTE_IMPORT_ARCH_FROMPATH_DEFAULT,$(_T),$(_REV),$(_VTAG),$(_DISTROOT)) 
$(_IMPORT_ARCH_DESC_TARGETS): _FROM_AUTO=$(strip $(if $(_FROM_FROM),$(_FROM_FROM),$(_FROM_DEFAULT)))
$(_IMPORT_ARCH_DESC_TARGETS):
$(_IMPORT_ARCH_DESC_TARGETS): _SAFETY_CMD=$(if $(_FROM_AUTO),,@echo "$(BS_ERROR_PREFIX) Import not found in component repository" ; $(BIN_FALSE))
$(_IMPORT_ARCH_DESC_TARGETS): _IMPORT_DESC=$(wildcard $(_FROM_AUTO)/component.xml)
$(_IMPORT_ARCH_DESC_TARGETS): _COMPONENTUTIL_ARGS=$(if $(_IMPORT_DESC),\
                                     -I -f $(_FROM_AUTO)/component.xml,\
                                     -D -p $(BS_PLATFORM_ARCH_FULL) -c $(_T) -r $(_REV) -a'Imported Component did not provide a component.xml file. This stub was auto generated by the importing rules.')
$(_IMPORT_ARCH_DESC_TARGETS): 
	@echo "$(BS_INFO_PREFIX) Importing architecture specific target $(_T)"
	@echo "$(BS_INFO_PREFIX)     Target Name               : $(_T)"
	@echo "$(BS_INFO_PREFIX)     Import Revision Name      : $(_REV)"
	@echo "$(BS_INFO_PREFIX)     Import Descriptor File    : $(_DESC)"
	@echo "$(BS_INFO_PREFIX)     Import To Directory       : $(_TO)"
	@echo "$(BS_INFO_PREFIX)     Importing From Directory  : $(_FROM_AUTO)"
	$(BIN_MKDIR) -p $(_DESC_DIR)
	$(BIN_MKDIR) -p $(_TO)
	$(_SAFETY_CMD)
	$(BIN_CP) -R $(_FROM_AUTO)/* $(_TO)
	$(BIN_COMPONENTUTIL) -o $(_DESC) -i $(_FROM_AUTO) $(_COMPONENTUTIL_ARGS)


$(_IMPORT_NOARCH_DESC_TARGETS): 
$(_IMPORT_NOARCH_DESC_TARGETS): _T=$(word 1,$(subst _REV_, ,$(notdir $@)))
$(_IMPORT_NOARCH_DESC_TARGETS): _DESC=$@
$(_IMPORT_NOARCH_DESC_TARGETS): _DESC_DIR=$(dir $@)
$(_IMPORT_NOARCH_DESC_TARGETS): _REV=$(if $($(_T)_REV),$($(_T)_REV),-UNSPECIFIED-)
$(_IMPORT_NOARCH_DESC_TARGETS): _TO=$(if $($(_T)_TO),$($(_T)_TO),$(COMPONENT_IMPORT_NOARCH_TARGET_DIR))
$(_IMPORT_NOARCH_DESC_TARGETS): _DISTROOT=$(if $($(_T)_DISTROOT),$($(_T)_DISTROOT),$(COMPONENT_DISTROOT))
$(_IMPORT_NOARCH_DESC_TARGETS): _VTAG=$(if $($(_T)_VTAG),$($(_T)_VTAG),$(BS_VTAG))
$(_IMPORT_NOARCH_DESC_TARGETS): 
$(_IMPORT_NOARCH_DESC_TARGETS): _FROM_FROM=$($(_T)_FROM)
$(_IMPORT_NOARCH_DESC_TARGETS): _FROM_DEFAULT=$(call _IMPORT_FUNC_COMPUTE_IMPORT_NOARCH_FROMPATH_DEFAULT,$(_T),$(_REV),$(_VTAG),$(_DISTROOT)) 
$(_IMPORT_NOARCH_DESC_TARGETS): _FROM_AUTO=$(strip $(if $(_FROM_FROM),$(_FROM_FROM),$(_FROM_DEFAULT)))
$(_IMPORT_NOARCH_DESC_TARGETS):
$(_IMPORT_NOARCH_DESC_TARGETS): _SAFETY_CMD=$(if $(_FROM_AUTO),,@echo "$(BS_ERROR_PREFIX) Import not found in component repository (dist area)" ; $(BIN_FALSE))
$(_IMPORT_NOARCH_DESC_TARGETS): _IMPORT_DESC=$(wildcard $(_FROM_AUTO)/component.xml)
$(_IMPORT_NOARCH_DESC_TARGETS): _COMPONENTUTIL_ARGS=$(if $(_IMPORT_DESC),\
                                     -I -f $(_FROM_AUTO)/component.xml,\
                                     -D -p $(BS_PLATFORM_NOARCH) -c $(_T) -r $(_REV) -a'Imported Component did not provide a component.xml file; This stub was auto generated by the importing rules.')
$(_IMPORT_NOARCH_DESC_TARGETS): 
$(_IMPORT_NOARCH_DESC_TARGETS): 
$(_IMPORT_NOARCH_DESC_TARGETS): 
	@echo "$(BS_INFO_PREFIX) Importing architecture neutral target $(_T)"
	@echo "$(BS_INFO_PREFIX)     Target Name               : $(_T)"
	@echo "$(BS_INFO_PREFIX)     Import Revision Name      : $(_REV)"
	@echo "$(BS_INFO_PREFIX)     Import Descriptor File    : $(_DESC)"
	@echo "$(BS_INFO_PREFIX)     Import To Directory       : $(_TO)"
	@echo "$(BS_INFO_PREFIX)     Importing From Directory  : $(_FROM_AUTO)"
	$(BIN_MKDIR) -p $(_DESC_DIR)
	$(BIN_MKDIR) -p $(_TO)
	$(_SAFETY_CMD)
	$(BIN_CP) -R $(_FROM_AUTO)/* $(_TO)
	$(BIN_RM) -f $(_TO)/component.xml
	$(BIN_COMPONENTUTIL) -o $(_DESC) -i $(_FROM_AUTO) $(_COMPONENTUTIL_ARGS)


#
# Dist targets - create components for others to import
#

_EXPORT_DESC_TARGETS=$(foreach d,$(addprefix $(BS_ARCH_TARGET_DIR)/,$(DIST_TARGETS)),$(d).xml) $(foreach d,$(addprefix $(BS_ARCH_TARGET_DIR)/,$(EXPORT_DESC_TARGETS)),$(d).xml)

_DIST_TARGETS=$(addprefix _PHONY_DIST_/,$(DIST_TARGETS))



$(_EXPORT_DESC_TARGETS):
$(_EXPORT_DESC_TARGETS):
$(_EXPORT_DESC_TARGETS): _DESC=$(@)
$(_EXPORT_DESC_TARGETS): _T=$(notdir $(@:%.xml=%))
$(_EXPORT_DESC_TARGETS): _REV=$(if $($(_T)_REV),$($(_T)_REV),$(BS_DATE_YEAR)-$(BS_DATE_MONTH)-$(BS_DATE_DAY))$(if $(COMPONENT_DISTTAG),_$(COMPONENT_DISTTAG),)
$(_EXPORT_DESC_TARGETS): _DISTROOT=$(if $($(_T)_DISTROOT),$($(_T)_DISTROOT),$(COMPONENT_DISTROOT))
$(_EXPORT_DESC_TARGETS): _PLATFORM=$(if $($(_T)_PLATFORM),$($(_T)_PLATFORM),$(BS_PLATFORM_ARCH_FULL))
$(_EXPORT_DESC_TARGETS): _PLATFORM_AND_VTAG=$(_PLATFORM)$(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG)))
$(_EXPORT_DESC_TARGETS): _PLATFORMLINKS_TMP=$(if $($(_T)_PLATFORMLINKS),$($(_T)_PLATFORMLINKS),)
$(_EXPORT_DESC_TARGETS): _PLATFORMLINKS=$(sort $(filter-out $(_PLATFORM_AND_VTAG), $(_PLATFORMLINKS_TMP)))
$(_EXPORT_DESC_TARGETS): _TO_DEFAULT=$(_DISTROOT)/$(_T)/$(_REV)/$(_PLATFORM_AND_VTAG)
$(_EXPORT_DESC_TARGETS): _TO=$(if $($(_T)_TO),$($(_T)_TO),$(_TO_DEFAULT))
$(_EXPORT_DESC_TARGETS): _FROM=$(if $($(_T)_FROM),$($(_T)_FROM),./)
$(_EXPORT_DESC_TARGETS): _COMMENT=$(if $($(_T)_COMMENT),$($(_T)_COMMENT),$(_T) component DIST created at $(BS_DATE_YEAR)-$(BS_DATE_MONTH)-$(BS_DATE_DAY) $(BS_DATE_HOUR):$(BS_DATE_MINUTE):$(BS_DATE_SECOND) on $(BS_OS_HOSTNAME))
$(_EXPORT_DESC_TARGETS): _IMPORT_DESCS=$(strip $(wildcard $(COMPONENT_IMPORT_ARCH_TARGET_DIR)/component_descriptors/*.xml) $(wildcard $(COMPONENT_IMPORT_NOARCH_TARGET_DIR)/component_descriptors/*.xml))
$(_EXPORT_DESC_TARGETS): 
$(_EXPORT_DESC_TARGETS): _PLATFORMLINKS_FLAGS=$(if $(_PLATFORMLINKS),-m'$(_PLATFORMLINKS)',)
$(_EXPORT_DESC_TARGETS): _IMPORT_DESCS_FLAGS=$(if $(_IMPORT_DESCS),-l'$(_IMPORT_DESCS)',)
$(_EXPORT_DESC_TARGETS): _VARIANT_FLAGS=$(if $(BS_VTAG),-v'$(BS_VTAG)',)
$(_EXPORT_DESC_TARGETS): 
	@echo "$(BS_INFO_PREFIX) Generating Component Descriptor $(_T)"
	@echo "$(BS_INFO_PREFIX)   Target              : $(_T)"
	@echo "$(BS_INFO_PREFIX)   Component Descriptor     : $(_DESC)"
	@echo "$(BS_INFO_PREFIX)   Component Rev            : $(_REV)"
	@echo "$(BS_INFO_PREFIX)   Component Platform       : $(_PLATFORM)"
	@echo "$(BS_INFO_PREFIX)   Component Platform Links : $(_PLATFORMLINKS)"
	@echo "$(BS_INFO_PREFIX)   Component DISTROOT       : $(_DISTROOT)"
	@echo "$(BS_INFO_PREFIX)   Component TO Directory   : $(_TO)"
	@echo "$(BS_INFO_PREFIX)   Component FROM Directory : $(_FROM)"
	@echo "$(BS_INFO_PREFIX)   Component Variant Tag    : $(BS_VTAG)"
	$(BIN_COMPONENTUTIL) -o $(_DESC) -D -c $(_T) -r $(_REV) -p $(_PLATFORM) -d $(_TO) -a'$(_COMMENT)' $(_PLATFORMLINKS_FLAGS) $(_VARIANT_FLAGS) $(_IMPORT_DESCS_FLAGS)


$(_DIST_TARGETS):
$(_DIST_TARGETS):
$(_DIST_TARGETS): _T=$(notdir $(@))
$(_DIST_TARGETS): _DESC=$(BS_ARCH_TARGET_DIR)/$(_T).xml
$(_DIST_TARGETS): _REV=$(if $($(_T)_REV),$($(_T)_REV),$(BS_DATE_YEAR)-$(BS_DATE_MONTH)-$(BS_DATE_DAY))$(if $(COMPONENT_DISTTAG),_$(COMPONENT_DISTTAG),)
$(_DIST_TARGETS): _DISTROOT=$(if $($(_T)_DISTROOT),$($(_T)_DISTROOT),$(COMPONENT_DISTROOT))
$(_DIST_TARGETS): _PLATFORM=$(if $($(_T)_PLATFORM),$($(_T)_PLATFORM),$(BS_PLATFORM_ARCH_FULL))
$(_DIST_TARGETS): _PLATFORM_AND_VTAG=$(_PLATFORM)$(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG)))
$(_DIST_TARGETS): _PLATFORMLINKS_TMP=$(if $($(_T)_PLATFORMLINKS),$($(_T)_PLATFORMLINKS),)
$(_DIST_TARGETS): _PLATFORMLINKS=$(sort $(filter-out $(_PLATFORM_AND_VTAG), $(_PLATFORMLINKS_TMP)))
$(_DIST_TARGETS): _TO_DEFAULT=$(_DISTROOT)/$(_T)/$(_REV)/$(_PLATFORM_AND_VTAG)
$(_DIST_TARGETS): _TO=$(if $($(_T)_TO),$($(_T)_TO),$(_TO_DEFAULT))
$(_DIST_TARGETS): _LINK_TO=$(notdir $(_TO))
$(_DIST_TARGETS): _FROM=$(if $($(_T)_FROM),$($(_T)_FROM),./)
$(_DIST_TARGETS): 
$(_DIST_TARGETS): _ARCH_REEXPORT=$(filter $(IMPORT_ARCH_TARGETS), $($(_T)_REEXPORT))
$(_DIST_TARGETS): _ARCH_REEXPORT_FROMS=$(foreach reex,$(_ARCH_REEXPORT),$(if $($(reex)_FROM),$($(reex)_FROM),$(call _IMPORT_FUNC_COMPUTE_IMPORT_ARCH_FROMPATH_DEFAULT,$(reex),$($(reex)_REV),$(if $($(reex)_VTAG),$($(reex)_VTAG),$(BS_VTAG)),$(if $($(reex)_DISTROOT),$($(reex)_DISTROOT),$(COMPONENT_DISTROOT)))))
$(_DIST_TARGETS): 
$(_DIST_TARGETS): _NOARCH_REEXPORT=$(filter $(IMPORT_NOARCH_TARGETS), $($(_T)_REEXPORT))
$(_DIST_TARGETS): _NOARCH_REEXPORT_FROMS=$(foreach reex,$(_NOARCH_REEXPORT),$(if $($(reex)_FROM),$($(reex)_FROM),$(call _IMPORT_FUNC_COMPUTE_IMPORT_NOARCH_FROMPATH_DEFAULT,$(reex),$($(reex)_REV),$(if $($(reex)_VTAG),$($(reex)_VTAG),$(BS_VTAG)),$(if $($(reex)_DISTROOT),$($(reex)_DISTROOT),$(COMPONENT_DISTROOT)))))
$(_DIST_TARGETS): 
	@echo "$(BS_INFO_PREFIX) Pushing Dist Target $(_T)"
	@echo "$(BS_INFO_PREFIX)   Dist Target                     : $(_T)"
	@echo "$(BS_INFO_PREFIX)   Component Descriptor            : $(_DESC)"
	@echo "$(BS_INFO_PREFIX)   Component Rev                   : $(_REV)"
	@echo "$(BS_INFO_PREFIX)   Component Platform              : $(_PLATFORM)"
	@echo "$(BS_INFO_PREFIX)   Component Platform Links        : $(_PLATFORMLINKS)"
	@echo "$(BS_INFO_PREFIX)   Component DISTROOT              : $(_DISTROOT)"
	@echo "$(BS_INFO_PREFIX)   Component TO Directory          : $(_TO)"
	@echo "$(BS_INFO_PREFIX)   Component FROM Directory        : $(_FROM)"
	@echo "$(BS_INFO_PREFIX)   Component Variant Tag           : $(BS_VTAG)"
	@echo "$(BS_INFO_PREFIX)   Re-Exported Arch Components:    : $(_ARCH_REEXPORT)"
	@echo "$(BS_INFO_PREFIX)   Re-Exported NoArch Components:  : $(_NOARCH_REEXPORT)"
	$(BIN_RM) -rf $(_TO)
	$(BIN_MKDIR) -p $(_TO)
	$(BIN_CP) -R $(_FROM)/* $(_TO)
	$(foreach reex_dir,$(_ARCH_REEXPORT_FROMS),$(BIN_CP) -R $(reex_dir)/* $(_TO) &&) $(BIN_TRUE)
	$(foreach reex_dir,$(_NOARCH_REEXPORT_FROMS),$(BIN_CP) -R $(reex_dir)/* $(_TO) &&) $(BIN_TRUE)
	$(foreach link,$(_PLATFORMLINKS), $(BIN_CD) $(_TO)/.. && $(BIN_RM) -f $(link) && $(BIN_LN) -s $(_LINK_TO) $(link)  ;)
	$(BIN_CP) $(_DESC) $(_TO)/component.xml


#
# We got lazy, and this isn't a pattern target. I'm not sure there really is call to make
# this a full blown pattern target that can archive an arbitrary slice of the repository
# that is independant from the IMPORT pattern targets.
#
$(BS_ARCH_TARGET_DIR)/imported_components_arch.tar.gz:
$(BS_ARCH_TARGET_DIR)/imported_components_arch.tar.gz: _ARCH_DIST_FROMS=$(foreach import,$(IMPORT_ARCH_TARGETS),$(if $($(import)_FROM),$($(import)_FROM),$(call _IMPORT_FUNC_COMPUTE_IMPORT_ARCH_FROMPATH_DEFAULT,$(import),$($(import)_REV),$(if $($(import)_VTAG),$($(import)_VTAG),$(BS_VTAG)),$(if $($(import)_DISTROOT),$($(import)_DISTROOT),$(COMPONENT_DISTROOT)))))
$(BS_ARCH_TARGET_DIR)/imported_components_arch.tar.gz:
	@echo "$(BS_INFO_PREFIX)   Shadowing Arch Components from the following locations: $(_ARCH_DIST_FROMS)"
	$(if $(strip $(_ARCH_DIST_FROMS)),$(BIN_TAR) cvhf - $(_ARCH_DIST_FROMS) | $(BIN_GZIP) -v9 > $@,$(BIN_TOUCH) $@)

$(BS_NOARCH_TARGET_DIR)/imported_components_noarch.tar.gz:
$(BS_NOARCH_TARGET_DIR)/imported_components_noarch.tar.gz: _NOARCH_DIST_FROMS=$(foreach import,$(IMPORT_NOARCH_TARGETS),$(if $($(import)_FROM),$($(import)_FROM),$(call _IMPORT_FUNC_COMPUTE_IMPORT_NOARCH_FROMPATH_DEFAULT,$(import),$($(import)_REV),$(if $($(import)_VTAG),$($(import)_VTAG),$(BS_VTAG)),$(if $($(import)_DISTROOT),$($(import)_DISTROOT),$(COMPONENT_DISTROOT)))))
$(BS_NOARCH_TARGET_DIR)/imported_components_noarch.tar.gz:
	@echo "$(BS_INFO_PREFIX)   Shadowing NoArch Components from the following locations: $(_NOARCH_DIST_FROMS)"
	$(if $(strip $(_NOARCH_DIST_FROMS)),$(BIN_TAR) cvhf - $(_NOARCH_DIST_FROMS) | $(BIN_GZIP) -v9 > $@,$(BIN_TOUCH) $@)


component_import: $(_IMPORT_ARCH_DESC_TARGETS) $(_IMPORT_NOARCH_DESC_TARGETS)

component_desc: $(_EXPORT_DESC_TARGETS)

component_dist: $(_EXPORT_DESC_TARGETS)
component_dist: $(_DIST_TARGETS)

component_shadow_arch: $(BS_ARCH_TARGET_DIR)/imported_components_arch.tar.gz
component_shadow_noarch: $(BS_NOARCH_TARGET_DIR)/imported_components_noarch.tar.gz

component_shadow: component_shadow_arch component_shadow_noarch


#
# hook module rules into build system.
#


info:: component_info

man:: component_man

clean:: component_clean

nuke:: component_nuke

depends:: _IMPORT_ARCH_DEP_PREP $(_IMPORT_ARCH_DEP_GENERATION_TARGETS)
depends:: _IMPORT_NOARCH_DEP_PREP $(_IMPORT_NOARCH_DEP_GENERATION_TARGETS)

pretarget::

target:: component_import

posttarget:: component_desc
posttarget:: component_dist

.PHONY:: component_info component_man component_dist component_desc $(_EXPORT_DESC_TARGETS) $(_DIST_TARGETS)

