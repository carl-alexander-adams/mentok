#
# CentOS rules for Check Environment.
#


#
# Ckeck OS Package targets
#

# We don't calculate dependencies for CKOSPKG_TARGETS.  The dependency would be the
# OS package system.  We assume that doesn't change lightly.

CHECKENV_FUNC_GET_CKOSPKG_FLAGTARGET=$(addprefix $(BS_ARCH_TARGET_DIR)/checkenv_flags_ckospkg/,$(1))

_CKOSPKG_FLAG_TARGETS=$(foreach t,$(CKOSPKG_TARGETS),$(call CHECKENV_FUNC_GET_CKOSPKG_FLAGTARGET,$(t)))


checkenv_ckospkg_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning os package check targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $(_CKOSPKG_FLAG_TARGETS)


# YUM makes this pretty easy.  "yum list installed ..." returns a shell error if no packages
# are found, and a shell success if they are.
$(_CKOSPKG_FLAG_TARGETS):
$(_CKOSPKG_FLAG_TARGETS): _T=$(notdir $(@))
$(_CKOSPKG_FLAG_TARGETS): _FLAG_TARGET=$(@)
$(_CKOSPKG_FLAG_TARGETS):
$(_CKOSPKG_FLAG_TARGETS): _NAME=$(if $($(_T)_NAME),$($(_T)_NAME),$(_T))
$(_CKOSPKG_FLAG_TARGETS): _VERSION=$(if $($(_T)_VERSION),$($(_T)_VERSION),)
$(_CKOSPKG_FLAG_TARGETS): _RELEASE=$(if $($(_T)_RELEASE),$($(_T)_RELEASE),)
$(_CKOSPKG_FLAG_TARGETS): _ARCH=$(if $($(_T)_ARCH),$($(_T)_ARCH),)
$(_CKOSPKG_FLAG_TARGETS):
$(_CKOSPKG_FLAG_TARGETS): _YUM_SPEC=$(_NAME)$(if $(_VERSION),-$(_VERSION),)$(if $(_RELEASE),-$(_RELEASE),)$(if $(_ARCH),.$(_ARCH),)
$(_CKOSPKG_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Checking for OS Package \"$(_T)\" version \"$(_VERSION)\" release \"$(_RELEASE)\" (CKOSPKG_TARGETS pattern target)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     Flag Target File              : $(_FLAG_TARGET)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     OS Package Name               : $(_NAME)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     OS Package Version            : $(_VERSION)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     OS Package Release            : $(_RELEASE)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     OS Package Architecture       : $(_ARCH)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)     YUM package spec              : $(_YUM_SPEC)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(BS_ARCH_TARGET_DIR)/checkenv_flags_ckospkg
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_CHECKENV_YUM) list installed $(_YUM_SPEC)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_FLAG_TARGET)

checkenv_ckospkg: $(_CKOSPKG_FLAG_TARGETS)



#
# Hook module targets into build3 global targets.
#
target:: checkenv_ckospkg

clean:: checkenv_ckospkg_clean
