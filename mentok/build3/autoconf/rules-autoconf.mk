#
# Module rules
#
autoconf_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Autoconf Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_BSCATMAN) $(BS_ROOT)/autoconf/autoconf.html

autoconf_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Auto Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_AUTOCONF                           $(BIN_AUTOCONF)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_AUTOHEADER                         $(BIN_AUTOHEADER)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) CONFIGH_TARGETS                        $(CONFIGH_TARGETS)")

autoconf_clean::

#
# Autoconf "config.h" file generation.
#

_CONFIGH_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(CONFIGH_TARGETS))


#
# config.h's don't depend on anything.
#
#_CONFIGH_DEP_GENERATION_TARGETS=$(addprefix _CONFIGH_DEP_,$(CONFIGH_TARGETS))
#_CONFIGH_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/autoconf_depend_configh.mk


ifneq ($(strip $(CONFIGH_TARGETS)),)
#-include $(_CONFIGH_DEPEND_FILE)

autoconf_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning autoconf configh targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_CONFIGH_TARGETS)
endif


#$(_CONFIGH_DEPEND_FILE): _CONFIGH_DEP_PREP $(_CONFIGH_DEP_GENERATION_TARGETS)
#.INTERMEDIATE:: _CONFIGH_DEP_PREP $(_CONFIGH_DEP_GENERATION_TARGETS)


#_CONFIGH_DEP_PREP:
#	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_CONFIGH_DEPEND_FILE)")
#	$(BIN_MKDIR) -p $(dir $(_CONFIGH_DEPEND_FILE))
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_CONFIGH_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for configh targets" >> $(_CONFIGH_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_CONFIGH_DEPEND_FILE)


#_CONFIGH_DEP_%:
#_CONFIGH_DEP_%: _CONFIGH=$(BS_ARCH_TARGET_DIR)/$(*)
#_CONFIGH_DEP_%:
#_CONFIGH_DEP_%:
#	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for configh target $(*)")
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## configh target: $(*)" >> $(_CONFIGH_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_CONFIGH): " >> $(_CONFIGH_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_CONFIGH_DEPEND_FILE)




$(_CONFIGH_TARGETS):
$(_CONFIGH_TARGETS): _T=$(notdir $(@))
$(_CONFIGH_TARGETS):
$(_CONFIGH_TARGETS): _TMP_DIR=$(BS_ARCH_TARGET_DIR)/$(_T)-tmpdir
$(_CONFIGH_TARGETS): _INPUT_FILES= \
				$(if $($(_T)_SOURCETREE_FROM),$($(_T)_SOURCETREE_FROM),$(BS_ROOT)/autoconf/autoconf/SOURCETREE) \
				$(if $($(_T)_ACCONFIG.H_FROM),$($(_T)_ACCONFIG.H_FROM),$(BS_ROOT)/autoconf/autoconf/acconfig.h) \
				$(if $($(_T)_ACLOCAL.M4_FROM),$($(_T)_ACLOCAL.M4_FROM),$(BS_ROOT)/autoconf/autoconf/aclocal.m4) \
				$(if $($(_T)_CONFIGURE.IN_FROM),$($(_T)_CONFIGURE.IN_FROM),$(BS_ROOT)/autoconf/autoconf/configure.in) \
				$(if $($(_T)_INSTALL-SH_FROM),$($(_T)_INSTALL-SH_FROM),$(BS_ROOT)/autoconf/autoconf/install-sh) \
				$(if $($(_T)_RULES.MK.IN_FROM),$($(_T)_RULES.MK.IN_FROM),$(BS_ROOT)/autoconf/autoconf/rules.mk.in) \
				$(if $($(_T)_DEFINES.MK.IN_FROM),$($(_T)_DEFINES.MK.IN_FROM),$(BS_ROOT)/autoconf/autoconf/defines.mk.in) \
				$(BIN_CONFIGGUESS) \
				$(BIN_CONFIGSUB)
$(_CONFIGH_TARGETS): 
$(_CONFIGH_TARGETS): 
$(_CONFIGH_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Generating configh target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                    :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File                    :  $@")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Input Files                    :  $(_INPUT_FILES)")
	$(BS_CMDPREFIX_VERBOSE2) $(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_TMP_DIR)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(_TMP_DIR)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CP) $(_INPUT_FILES) $(_TMP_DIR)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CD) $(_TMP_DIR) && $(BIN_AUTOHEADER)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CD) $(_TMP_DIR) && $(BIN_AUTOCONF)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CD) $(_TMP_DIR) && ./configure
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CP) $(_TMP_DIR)/config.h $@





autoconf_configh: $(_CONFIGH_TARGETS)


#
# hook module rules into build system
#

info:: autoconf_info

man:: autoconf_man

pretarget:: autoconf_configh

target::

posttarget::

#depends:: _CONFIGH_DEP_PREP $(_CONFIGH_DEP_GENERATION_TARGETS)

.PHONY:: autoconf_info autoconf_man


