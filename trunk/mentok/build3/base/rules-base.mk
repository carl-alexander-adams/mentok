#
# Modules rules
#
base_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Base Module Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_BSCATMAN) $(BS_ROOT)/base/base.html

base_info:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Base Module Macro Settings"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) BS_ROOT                            $(BS_ROOT)"
	@echo "$(BS_INFO_PREFIX) COMPONENT_ROOT                     $(COMPONENT_ROOT)"
	@echo "$(BS_INFO_PREFIX) BS_VTAG                            $(BS_VTAG)"
	@echo "$(BS_INFO_PREFIX) BS_ROOT_TARGET_DIR                 $(BS_ROOT_TARGET_DIR)"
	@echo "$(BS_INFO_PREFIX) BS_ARCH_TARGET_DIR                 $(BS_ARCH_TARGET_DIR)"
	@echo "$(BS_INFO_PREFIX) BS_NOARCH_TARGET_DIR               $(BS_NOARCH_TARGET_DIR)"
	@echo "$(BS_INFO_PREFIX) BS_CURRENT_SRCDIR_ABSPATH          $(BS_CURRENT_SRCDIR_ABSPATH)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) BS_OS_HOSTNAME                     $(BS_OS_HOSTNAME)"
	@echo "$(BS_INFO_PREFIX) BS_OS_NAME                         $(BS_OS_NAME)"
	@echo "$(BS_INFO_PREFIX) BS_OS_REVMAJOR                     $(BS_OS_REVMAJOR)"
	@echo "$(BS_INFO_PREFIX) BS_OS_REVMINOR                     $(BS_OS_REVMINOR)"
	@echo "$(BS_INFO_PREFIX) BS_OS_REVPATCH                     $(BS_OS_REVPATCH)"
	@echo "$(BS_INFO_PREFIX) BS_OS_RUNTIME                      $(BS_OS_RUNTIME)"
	@echo "$(BS_INFO_PREFIX) BS_OS_MACHINETYPE                  $(BS_OS_MACHINETYPE)"
	@echo "$(BS_INFO_PREFIX) BS_OS_MACHINEPROC                  $(BS_OS_MACHINEPROC)"
	@echo "$(BS_INFO_PREFIX) BS_OS_MACHINEINSTSET               $(BS_OS_MACHINEINSTSET)"
	@echo "$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FULL              $(BS_PLATFORM_ARCH_FULL)"
	@echo "$(BS_INFO_PREFIX) BS_PLATFORM_NOARCH                 $(BS_PLATFORM_NOARCH)"
	@echo "$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_1        $(BS_PLATFORM_ARCH_FALLBACK_1)"
	@echo "$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_2        $(BS_PLATFORM_ARCH_FALLBACK_2)"
	@echo "$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_3        $(BS_PLATFORM_ARCH_FALLBACK_3)"
	@echo "$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_4        $(BS_PLATFORM_ARCH_FALLBACK_4)"
	@echo "$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_LEGACYFALLBACK_1  $(BS_PLATFORM_ARCH_LEGACYFALLBACK_1)"
	@echo "$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_LEGACYFALLBACK_2  $(BS_PLATFORM_ARCH_LEGACYFALLBACK_2)"
	@echo "$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_LEGACYFALLBACK_3  $(BS_PLATFORM_ARCH_LEGACYFALLBACK_3)"
	@echo "$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_LEGACYFALLBACK_4  $(BS_PLATFORM_ARCH_LEGACYFALLBACK_4)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) BS_DATE_YEAR                       $(BS_DATE_YEAR)"
	@echo "$(BS_INFO_PREFIX) BS_DATE_MONTH                      $(BS_DATE_MONTH)"
	@echo "$(BS_INFO_PREFIX) BS_DATE_DAY                        $(BS_DATE_DAY)"
	@echo "$(BS_INFO_PREFIX) BS_DATE_HOUR                       $(BS_DATE_HOUR)"
	@echo "$(BS_INFO_PREFIX) BS_DATE_MINUTE                     $(BS_DATE_MINUTE)"
	@echo "$(BS_INFO_PREFIX) BS_DATE_SECOND                     $(BS_DATE_SECOND)"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) BIN_CP                             $(BIN_CP)"
	@echo "$(BS_INFO_PREFIX) BIN_TAR                            $(BIN_TAR)"
	@echo "$(BS_INFO_PREFIX) BIN_LN                             $(BIN_LN)"
	@echo "$(BS_INFO_PREFIX) BIN_RM                             $(BIN_RM)"
	@echo "$(BS_INFO_PREFIX) BIN_TOUCH                          $(BIN_TOUCH)"
	@echo "$(BS_INFO_PREFIX) BIN_MKDIR                          $(BIN_MKDIR)"
	@echo "$(BS_INFO_PREFIX) BIN_CAT                            $(BIN_CAT)"
	@echo "$(BS_INFO_PREFIX) BIN_SED                            $(BIN_SED)"
	@echo "$(BS_INFO_PREFIX) BIN_AWK                            $(BIN_AWK)"
	@echo "$(BS_INFO_PREFIX) BIN_GREP                           $(BIN_GREP)"
	@echo "$(BS_INFO_PREFIX) BIN_GZIP                           $(BIN_GZIP)"
	@echo "$(BS_INFO_PREFIX) BIN_ZIP                            $(BIN_ZIP)"
	@echo "$(BS_INFO_PREFIX) BIN_CHOWN                          $(BIN_CHOWN)"
	@echo "$(BS_INFO_PREFIX) BIN_CHMOD                          $(BIN_CHMOD)"
	@echo "$(BS_INFO_PREFIX) BIN_SLEEP                          $(BIN_SLEEP)"
	@echo "$(BS_INFO_PREFIX) BIN_TRUE                           $(BIN_TRUE)"
	@echo "$(BS_INFO_PREFIX) BIN_FALSE                          $(BIN_FALSE)"
	@echo "$(BS_INFO_PREFIX) BIN_DATE                           $(BIN_DATE)"
	@echo "$(BS_INFO_PREFIX) BIN_LYNX                           $(BIN_LYNX)"
	@echo "$(BS_INFO_PREFIX) BIN_LINKS                          $(BIN_LINKS)"
	@echo "$(BS_INFO_PREFIX) BIN_CD                             $(BIN_CD)"
	@echo "$(BS_INFO_PREFIX) BIN_PWD                            $(BIN_PWD)"
	@echo "$(BS_INFO_PREFIX) BIN_FIND                           $(BIN_FIND)"
	@echo "$(BS_INFO_PREFIX) BIN_PERL                           $(BIN_PERL)"
	@echo "$(BS_INFO_PREFIX) BIN_COMPONENTUTIL                  $(BIN_COMPONENTUTIL)"
	@echo "$(BS_INFO_PREFIX) BIN_PLATFORMUTIL                   $(BIN_PLATFORMUTIL)"
	@echo "$(BS_INFO_PREFIX) BIN_BSCATMAN                       $(BIN_BSCATMAN)"

$(BS_ROOT_TARGET_DIR):
	$(BIN_MKDIR) -p $@

$(BS_NOARCH_TARGET_DIR): $(BS_ROOT_TARGET_DIR)
	$(BIN_MKDIR) -p $@

$(BS_ARCH_TARGET_DIR): $(BS_ROOT_TARGET_DIR)
	$(BIN_MKDIR) -p $@

base_targetdirs: $(BS_ROOT_TARGET_DIR) $(BS_NOARCH_TARGET_DIR) $(BS_ARCH_TARGET_DIR)

base_nuke:
	$(BIN_RM) -rf $(BS_ROOT_TARGET_DIR)

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

