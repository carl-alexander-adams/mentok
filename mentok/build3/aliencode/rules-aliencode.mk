#
# Module rules
#
aliencode_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Alien Code Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_BSCATMAN) $(BS_ROOT)/aliencode/aliencode.html

aliencode_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Alien Code Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) AC_BUILD_BIN                               $(AC_BUILD_BIN)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) AC_BUILD_FLAGS                             $(AC_BUILD_FLAGS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) AC_CLEAN_FLAGS                             $(AC_CLEAN_FLAGS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) AC_BUILD_TARGETS                           $(AC_BUILD_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) AC_INTERMEDIATE_TARGETS                    $(AC_INTERMEDIATE_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) AC_TREE_ROOT                               $(AC_TREE_ROOT)")

# Haven't figured out how to use intermediate targets in a sensible way.


$(AC_BUILD_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) -- Building $@")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CD) $(AC_TREE_ROOT) && $(AC_BUILD_BIN) $(AC_BUILD_FLAGS)
.PHONY:: $(AC_BUILD_TARGETS)

# Couple of empty defines so the chaining rules don't come up short
# when there are no ac_targets to mess with.

aliencode_clean::
aliencode_nuke::

ifneq ($(strip($AC_BUILD_TARGETS)),)

aliencode_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning alien code targets...")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CD) $(AC_TREE_ROOT) && $(AC_CLEAN_BIN) $(AC_CLEAN_FLAGS)

aliencode_nuke::

endif



aliencode: $(AC_BUILD_TARGETS)


#
# module rules into build system
#

info:: aliencode_info

man:: aliencode_man

pretarget::

target:: aliencode

posttarget::

clean:: aliencode_clean

depends::

.PHONY:: aliencode_info aliencode_man aliencode_clean aliencode
