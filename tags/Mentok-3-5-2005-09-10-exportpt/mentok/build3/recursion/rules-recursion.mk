#
# Module rules
#
recursion_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Recursion Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) @$(BIN_BSCATMAN) $(BS_ROOT)/recursion/recursion.html

recursion_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Recursion Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) SUBDIR_TARGETS              $(SUBDIR_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")


ifdef SUBDIR_TARGETS
$(SUBDIR_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE3,"$(BS_INFO_PREFIX) --- Entering $@")
	$(BS_CMDPREFIX_VERBOSE2) $(MAKE) $(RECURSION_MAKE_FLAGS) -C $@ $(MAKECMDGOALS)
endif

recursion_subdirs: $(SUBDIR_TARGETS)

#
# hook module rules into build system
#

info:: recursion_info

man:: recursion_man

pretarget::

target::

posttarget::

.PHONY:: recursion_info recursion_man recursion_subdirs $(SUBDIR_TARGETS)

