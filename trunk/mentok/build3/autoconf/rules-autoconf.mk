#
# Module rules
#
autoconf_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Autoconf Module Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_BSCATMAN) $(BS_ROOT)/autoconf/autoconf.html

autoconf_info:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Auto Module Macro Settings"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) BIN_AUTOCONF                           $(BIN_AUTOCONF)"
	@echo "$(BS_INFO_PREFIX) BIN_AUTOHEADER                         $(BIN_AUTOHEADER)"
	@echo "$(BS_INFO_PREFIX) AUTOCONF_AUXTOOLS_DIR                  $(AUTOCONF_AUXTOOLS_DIR)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) CONFIGH_TARGETS                        $(CONFIGH_TARGETS)"

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
	@echo "$(BS_INFO_PREFIX)  cleaning autoconf configh targets"
	$(BIN_RM) -f $(_CONFIGH_TARGETS)
endif


#$(_CONFIGH_DEPEND_FILE): _CONFIGH_DEP_PREP $(_CONFIGH_DEP_GENERATION_TARGETS)
#.INTERMEDIATE:: _CONFIGH_DEP_PREP $(_CONFIGH_DEP_GENERATION_TARGETS)


#_CONFIGH_DEP_PREP:
#	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_CONFIGH_DEPEND_FILE)"
#	$(BIN_MKDIR) -p $(dir $(_CONFIGH_DEPEND_FILE))
#	echo "##" > $(_CONFIGH_DEPEND_FILE)
#	echo "## Auto generated depend file for configh targets" >> $(_CONFIGH_DEPEND_FILE)
#	echo "##" >> $(_CONFIGH_DEPEND_FILE)


#_CONFIGH_DEP_%:
#_CONFIGH_DEP_%: _CONFIGH=$(BS_ARCH_TARGET_DIR)/$(*)
#_CONFIGH_DEP_%:
#_CONFIGH_DEP_%:
#	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for configh target $(*) "
#	@echo "## configh target: $(*)" >> $(_CONFIGH_DEPEND_FILE)
#	@echo "$(_CONFIGH): " >> $(_CONFIGH_DEPEND_FILE)
#	@echo "" >> $(_CONFIGH_DEPEND_FILE)



#
# Env variable that bridges our settings to our autoconf and autoheader
# boiler plate config.
#
buildsystem_autoconf_AUXTOOLS_DIR=$(AUTOCONF_AUXTOOLS_DIR)
export buildsystem_autoconf_AUXTOOLS_DIR

$(_CONFIGH_TARGETS):
$(_CONFIGH_TARGETS): _T=$(notdir $(@))
$(_CONFIGH_TARGETS):
$(_CONFIGH_TARGETS): _TMP_DIR=$(BS_ARCH_TARGET_DIR)/$(_T)-tmpdir
$(_CONFIGH_TARGETS): _INPUT_FILES= \
				$(BS_ROOT)/autoconf/autoconf/SOURCETREE \
				$(BS_ROOT)/autoconf/autoconf/acconfig.h \
				$(BS_ROOT)/autoconf/autoconf/aclocal.m4 \
				$(BS_ROOT)/autoconf/autoconf/configure.in \
				$(BS_ROOT)/autoconf/autoconf/install-sh \
				$(BS_ROOT)/autoconf/autoconf/rules.mk.in \
				$(BS_ROOT)/autoconf/autoconf/defines.mk.in
$(_CONFIGH_TARGETS): 
$(_CONFIGH_TARGETS):
	@echo
	@echo "$(BS_INFO_PREFIX)  Generating configh target $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                    :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                    :  $@"
	$(BIN_RM) -rf $(_TMP_DIR)
	$(BIN_MKDIR) -p $(_TMP_DIR)
	$(BIN_CP) $(_INPUT_FILES) $(_TMP_DIR)
	$(BIN_CD) $(_TMP_DIR) && $(BIN_AUTOHEADER)
	$(BIN_CD) $(_TMP_DIR) && $(BIN_AUTOCONF)
	$(BIN_CD) $(_TMP_DIR) && ./configure
	$(BIN_CP) $(_TMP_DIR)/config.h $@





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


