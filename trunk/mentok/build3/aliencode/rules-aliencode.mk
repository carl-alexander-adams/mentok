#
# Module rules
#
aliencode_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Alien Code Module Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_BSCATMAN) $(BS_ROOT)/aliencode/aliencode.html

aliencode_info:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Alien Code Module Macro Settings"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) AC_BUILD_BIN                               $(AC_BUILD_BIN)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) AC_BUILD_FLAGS                             $(AC_BUILD_FLAGS)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) AC_CLEAN_FLAGS                             $(AC_CLEAN_FLAGS)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) AC_BUILD_TARGETS                           $(AC_BUILD_TARGETS)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) AC_INTERMEDIATE_TARGETS                    $(AC_INTERMEDIATE_TARGETS)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) AC_TREE_ROOT                               $(AC_TREE_ROOT)"

# Haven't figured out how to use intermediate targets in a sensible way.


$(AC_BUILD_TARGETS):
	@echo "$(BS_INFO_PREFIX) -- Building $@"
	@$(BIN_CD) $(AC_TREE_ROOT) && $(AC_BUILD_BIN) $(AC_BUILD_FLAGS)

# Couple of empty defines so the chaining rules don't come up short
# when there are no ac_targets to mess with.

aliencode_clean::
aliencode_nuke::

ifneq ($(strip($AC_BUILD_TARGETS)),)

aliencode_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning alien code targets..."
	@$(BIN_CD) $(AC_TREE_ROOT) && $(AC_CLEAN_BIN) $(AC_CLEAN_FLAGS)

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

.PHONY:: aliencode_info aliencode_man aliencode_clean


