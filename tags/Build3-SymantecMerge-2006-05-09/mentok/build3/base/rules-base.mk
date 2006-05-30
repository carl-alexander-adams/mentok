#
# Modules rules
#
base_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Base Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_BSCATMAN) $(BS_ROOT)/base/base.html

base_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Base Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Revision              $(BS_REVMAJOR).$(BS_REVMINOR).$(BS_REVPATCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_ROOT                            $(BS_ROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_VERBOSE                         $(BS_VERBOSE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_ROOT                     $(COMPONENT_ROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_ROOT_ABSPATH             $(COMPONENT_ROOT_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_VTAG                            $(BS_VTAG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_ROOT_TARGET_DIR                 $(BS_ROOT_TARGET_DIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_ARCH_TARGET_DIR   [ DEPRECATED - use the BS_FUNC_GEN_TARGET_DIR function ] $(BS_ARCH_TARGET_DIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_NOARCH_TARGET_DIR [ DEPRECATED - use the BS_FUNC_GEN_TARGET_DIR function ] $(BS_NOARCH_TARGET_DIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_CURRENT_SRCDIR_ABSPATH          $(BS_CURRENT_SRCDIR_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_HOSTNAME                     $(BS_OS_HOSTNAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_NAME                         $(BS_OS_NAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_REVMAJOR                     $(BS_OS_REVMAJOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_REVMINOR                     $(BS_OS_REVMINOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_REVPATCH                     $(BS_OS_REVPATCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_RUNTIMENAME                  $(BS_OS_RUNTIMENAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_RUNTIMEREVMAJOR              $(BS_OS_RUNTIMEREVMAJOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_RUNTIMEREVMINOR              $(BS_OS_RUNTIMEREVMINOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_RUNTIMEREVPATCH              $(BS_OS_RUNTIMEREVPATCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_RUNTIMEOLDNAME               $(BS_OS_RUNTIMEOLDNAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_MACHINETYPE                  $(BS_OS_MACHINETYPE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_MACHINEPROC                  $(BS_OS_MACHINEPROC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_MACHINEINSTSET               $(BS_OS_MACHINEINSTSET)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FULL              $(BS_PLATFORM_ARCH_FULL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_NOARCH                 $(BS_PLATFORM_NOARCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_1        $(BS_PLATFORM_ARCH_FALLBACK_1)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_2        $(BS_PLATFORM_ARCH_FALLBACK_2)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_3        $(BS_PLATFORM_ARCH_FALLBACK_3)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_4        $(BS_PLATFORM_ARCH_FALLBACK_4)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_5        $(BS_PLATFORM_ARCH_FALLBACK_5)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_6        $(BS_PLATFORM_ARCH_FALLBACK_6)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_7        $(BS_PLATFORM_ARCH_FALLBACK_7)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_LEGACYFALLBACK_1  $(BS_PLATFORM_ARCH_LEGACYFALLBACK_1)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_LEGACYFALLBACK_2  $(BS_PLATFORM_ARCH_LEGACYFALLBACK_2)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_LEGACYFALLBACK_3  $(BS_PLATFORM_ARCH_LEGACYFALLBACK_3)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_LEGACYFALLBACK_4  $(BS_PLATFORM_ARCH_LEGACYFALLBACK_4)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_LIST              $(BS_PLATFORM_ARCH_LIST)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_YEAR                       $(BS_DATE_YEAR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_MONTH                      $(BS_DATE_MONTH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_DAY                        $(BS_DATE_DAY)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_HOUR                       $(BS_DATE_HOUR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_MINUTE                     $(BS_DATE_MINUTE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_SECOND                     $(BS_DATE_SECOND)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CP                             $(BIN_CP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_MV                             $(BIN_MV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_TAR                            $(BIN_TAR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_LN                             $(BIN_LN)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_RM                             $(BIN_RM)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_TOUCH                          $(BIN_TOUCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_MKDIR                          $(BIN_MKDIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CAT                            $(BIN_CAT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_SED                            $(BIN_SED)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_AWK                            $(BIN_AWK)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_GREP                           $(BIN_GREP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_GZIP                           $(BIN_GZIP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_ZIP                            $(BIN_ZIP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CHOWN                          $(BIN_CHOWN)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CHMOD                          $(BIN_CHMOD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_SLEEP                          $(BIN_SLEEP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_TRUE                           $(BIN_TRUE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_FALSE                          $(BIN_FALSE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_DATE                           $(BIN_DATE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_LYNX                           $(BIN_LYNX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_LINKS                          $(BIN_LINKS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CD                             $(BIN_CD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_PWD                            $(BIN_PWD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_FIND                           $(BIN_FIND)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_PERL                           $(BIN_PERL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_COMPONENTUTIL                  $(BIN_COMPONENTUTIL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_PLATFORMUTIL                   $(BIN_PLATFORMUTIL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_BSCATMAN                       $(BIN_BSCATMAN)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_SHADOWTREE                     $(BIN_SHADOWTREE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_SH                             $(BIN_SH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_PRINTF                         $(BIN_PRINTF)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_ECHO                           $(BIN_ECHO)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_TEST                           $(BIN_TEST)")

$(BS_ROOT_TARGET_DIR):
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $@

$(BS_NOARCH_TARGET_DIR): $(BS_ROOT_TARGET_DIR)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $@

$(BS_ARCH_TARGET_DIR): $(BS_ROOT_TARGET_DIR)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $@

base_targetdirs: $(BS_ROOT_TARGET_DIR) $(BS_NOARCH_TARGET_DIR) $(BS_ARCH_TARGET_DIR)

base_nuke: 
base_nuke: _NUKE_DIRS=$(shell $(BIN_FIND) $(COMPONENT_ROOT) -type d -name $(notdir $(BS_ROOT_TARGET_DIR)) -print)
base_nuke:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Nuking build dirs...")
	$(BS_CMDPREFIX_VERBOSE0) $(foreach dir, $(_NUKE_DIRS), $(BIN_RM) -rf $(dir) ;)
#
# hook module rules into build system
#



info:: base_info

man:: base_man

pretarget:: base_targetdirs

target::

posttarget::

clean::

nuke:: base_nuke

.PHONY:: base_info base_man base_nuke

# .SILENT:
