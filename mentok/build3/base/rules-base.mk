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
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_ROOT_ABSPATH                    $(BS_ROOT_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_VERBOSE                         $(BS_VERBOSE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_ROOT                     $(COMPONENT_ROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) COMPONENT_ROOT_ABSPATH             $(COMPONENT_ROOT_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_VTAG                            $(BS_VTAG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_ROOT_TARGET_DIR                 $(BS_ROOT_TARGET_DIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_ARCH_TARGET_DIR   [ DEPRECATED - use the BS_FUNC_GEN_TARGET_DIR function ] $(BS_ARCH_TARGET_DIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_NOARCH_TARGET_DIR [ DEPRECATED - use the BS_FUNC_GEN_TARGET_DIR function ] $(BS_NOARCH_TARGET_DIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_ARCH_TARGET_DIR_ABSPATH         $(BS_ARCH_TARGET_DIR_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_NOARCH_TARGET_DIR_ABSPATH       $(BS_NOARCH_TARGET_DIR_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_CURRENT_SRCDIR_ABSPATH          $(BS_CURRENT_SRCDIR_ABSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_USERNAME                        $(BS_USERNAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_HOSTNAME                     $(BS_OS_HOSTNAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_NAME                         $(BS_OS_NAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_REVMAJOR                     $(BS_OS_REVMAJOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_REVMINOR                     $(BS_OS_REVMINOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_REVPATCH                     $(BS_OS_REVPATCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_RUNTIMENAME                  $(BS_OS_RUNTIMENAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_RUNTIMEREVMAJOR              $(BS_OS_RUNTIMEREVMAJOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_RUNTIMEREVMINOR              $(BS_OS_RUNTIMEREVMINOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_RUNTIMEREVPATCH              $(BS_OS_RUNTIMEREVPATCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_MACHINETYPE                  $(BS_OS_MACHINETYPE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_MACHINEPROC                  $(BS_OS_MACHINEPROC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_OS_MACHINEINSTSET               $(BS_OS_MACHINEINSTSET)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_NOARCH                 $(BS_PLATFORM_NOARCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FULL              $(BS_PLATFORM_ARCH_FULL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_1        $(BS_PLATFORM_ARCH_FALLBACK_1)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_2        $(BS_PLATFORM_ARCH_FALLBACK_2)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_3        $(BS_PLATFORM_ARCH_FALLBACK_3)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_4        $(BS_PLATFORM_ARCH_FALLBACK_4)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_5        $(BS_PLATFORM_ARCH_FALLBACK_5)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_6        $(BS_PLATFORM_ARCH_FALLBACK_6)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_7        $(BS_PLATFORM_ARCH_FALLBACK_7)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_8        $(BS_PLATFORM_ARCH_FALLBACK_8)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_9        $(BS_PLATFORM_ARCH_FALLBACK_9)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_10       $(BS_PLATFORM_ARCH_FALLBACK_10)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_11       $(BS_PLATFORM_ARCH_FALLBACK_11)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_FALLBACK_12       $(BS_PLATFORM_ARCH_FALLBACK_12)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_PLATFORM_ARCH_LIST              $(BS_PLATFORM_ARCH_LIST)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_YEAR                       $(BS_DATE_YEAR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_MONTH                      $(BS_DATE_MONTH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_MONTH_NOPAD                $(BS_DATE_MONTH_NOPAD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_DAY                        $(BS_DATE_DAY)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_DAY_NOPAD                  $(BS_DATE_DAY_NOPAD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_DAYOFYEAR                  $(BS_DATE_DAYOFYEAR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_DAYOFYEAR_NOPAD            $(BS_DATE_DAYOFYEAR_NOPAD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_HOUR                       $(BS_DATE_HOUR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_HOUR_NOPAD                 $(BS_DATE_HOUR_NOPAD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_MINUTE                     $(BS_DATE_MINUTE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_MINUTE_NOPAD               $(BS_DATE_MINUTE_NOPAD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_SECOND                     $(BS_DATE_SECOND)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_SECOND_NOPAD               $(BS_DATE_SECOND_NOPAD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_UNIXSECOND                 $(BS_DATE_UNIXSECOND)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BS_DATE_UNIXNANOSECOND             $(BS_DATE_UNIXNANOSECOND)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CP                             $(BIN_CP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_MV                             $(BIN_MV)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_TAR                            $(BIN_TAR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_LN                             $(BIN_LN)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_RM                             $(BIN_RM)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_LS                             $(BIN_LS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_TOUCH                          $(BIN_TOUCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_MKDIR                          $(BIN_MKDIR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CAT                            $(BIN_CAT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_SED                            $(BIN_SED)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_AWK                            $(BIN_AWK)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_GREP                           $(BIN_GREP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_GZIP                           $(BIN_GZIP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_BZIP2                          $(BIN_BZIP2)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_ZIP                            $(BIN_ZIP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_UNZIP                          $(BIN_UNZIP)")
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
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_PYTHON                         $(BIN_PYTHON)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_COMPONENTUTIL                  $(BIN_COMPONENTUTIL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_PLATFORMUTIL                   $(BIN_PLATFORMUTIL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_BSCATMAN                       $(BIN_BSCATMAN)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_SHADOWTREE                     $(BIN_SHADOWTREE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_SH                             $(BIN_SH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_PRINTF                         $(BIN_PRINTF)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_ECHO                           $(BIN_ECHO)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_TEST                           $(BIN_TEST)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_EXPR                           $(BIN_EXPR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_DU                             $(BIN_DU)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_TR                             $(BIN_TR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_TAIL                           $(BIN_TAIL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_SYSCTL                         $(BIN_SYSCTL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_EPM                            $(BIN_EPM)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_MKEPMLIST                      $(BIN_MKEPMLIST)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_RPM                            $(BIN_RPM)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_RPM2CPIO                       $(BIN_RPM2CPIO)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CPIO                           $(BIN_CPIO)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CURL                           $(BIN_CURL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_PHP                            $(BIN_PHP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_PHP_CONFIG                     $(BIN_PHP_CONFIG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_GPG                            $(BIN_GPG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_OPENSSL                        $(BIN_OPENSSL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_SSH                            $(BIN_SSH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_SSHKEYGEN                      $(BIN_SSHKEYGEN)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_PATCH                          $(BIN_PATCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_TEE                            $(BIN_TEE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_BASENAME                       $(BIN_BASENAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_DIRNAME                        $(BIN_DIRNAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_ICON                           $(BIN_ICON)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_ICONT                          $(BIN_ICONT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_ICONX                          $(BIN_ICONX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) LIBDIR_ICON                        $(LIBDIR_ICON)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CPIF                           $(BIN_CPIF)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_NOWEB                          $(BIN_NOWEB)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_NOTANGLE                       $(BIN_NOTANGLE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_XML2_CONFIG                    $(BIN_XML2_CONFIG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_MKISOFS                        $(BIN_MKISOFS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_IMPLANTISOMD5                  $(BIN_IMPLANTISOMD5)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_RSYNC                          $(BIN_RSYNC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CREATEREPO                     $(BIN_CREATEREPO)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_HEAD                           $(BIN_HEAD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_QEMU                           $(BIN_QEMU)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_QEMU_IMG                       $(BIN_QEMU_IMG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_QEMU_SYSTEMX8664               $(BIN_QEMU_SYSTEMX8664)")





$(BS_ROOT_TARGET_DIR):
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $@

$(BS_NOARCH_TARGET_DIR): $(BS_ROOT_TARGET_DIR)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $@

$(BS_ARCH_TARGET_DIR): $(BS_ROOT_TARGET_DIR)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $@

base_targetdirs: $(BS_ROOT_TARGET_DIR) $(BS_NOARCH_TARGET_DIR) $(BS_ARCH_TARGET_DIR)

base_test:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Running test programs...")

base_nuke: 
base_nuke: _NUKE_DIRS=$(shell $(BIN_FIND) $(COMPONENT_ROOT) -type d -name $(notdir $(BS_ROOT_TARGET_DIR)) -print)
base_nuke:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Nuking build dirs...")
	$(BS_CMDPREFIX_VERBOSE1) $(foreach dir, $(_NUKE_DIRS), $(BIN_RM) -rf $(dir) ;)


base_nukesub: 
base_nukesub: _NUKE_DIRS=$(shell $(BIN_FIND) $(BS_CURRENT_SRCDIR_ABSPATH) -type d -name $(notdir $(BS_ROOT_TARGET_DIR)) -print)
base_nukesub:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Nuking build dirs...")
	$(BS_CMDPREFIX_VERBOSE1) $(foreach dir, $(_NUKE_DIRS), $(BIN_RM) -rf $(dir) ;)


$(BS_ARCH_TARGET_DIR)/depends_was_manually_executed: $(BS_ARCH_TARGET_DIR)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $@

base_force_manual_depends:
	@$(call BS_FUNC_ECHO_VERBOSE1,"$(BS_INFO_PREFIX) Checking for manual '$(MAKE) depends'")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_TEST) -f $(BS_ARCH_TARGET_DIR)/depends_was_manually_executed || ($(BIN_ECHO) "$(BS_ERROR_PREFIX) '$(MAKE) depends' must be run first and must be run manually!  This target MUST NOT be combined with other $(MAKE) targets on the command line." && $(BIN_FALSE) )

#
# hook module rules into build system
#


info:: base_info

man:: base_man

pretarget:: base_targetdirs

target::

posttarget::

test:: base_test

clean::

nuke:: base_nuke

nukesub:: base_nukesub

# Record when "depends" was explicitly generated rather than implicitly generated.
depends:: $(BS_ARCH_TARGET_DIR)/depends_was_manually_executed

.PHONY:: base_info base_man base_nuke base_nukesub

# .SILENT:
