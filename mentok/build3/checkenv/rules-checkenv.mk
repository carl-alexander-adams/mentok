#
# Module rules
#

#
# Link in arch specific rules
#
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_12).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_11).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_10).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_9).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_8).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_7).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_6).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_5).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/checkenv/rules-checkenv-$(BS_PLATFORM_ARCH_FULL).mk

checkenv_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Check Environment Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_BSCATMAN) $(BS_ROOT)/checkenv/checkenv.html

checkenv_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Check Environment Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_CHECKENV_YUM                                   $(BIN_CHECKENV_YUM)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) CKOSPKG_TARGETS                               $(CKOSPKG_TARGETS)")


checkenv_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning checkenv targets")




#
# hook module rules into build system.
#


info:: checkenv_info

man:: checkenv_man

clean:: checkenv_clean

depends:: 

pretarget::

target::

posttarget::

.PHONY:: checkenv_info checkenv_man checkenv_clean

