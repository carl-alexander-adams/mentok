#
# Module rules
#
recursion_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Recursion Module Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_BSCATMAN) $(BS_ROOT)/recursion/recursion.html

recursion_info:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Recursion Module Macro Settings"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) "
	@echo "$(BS_INFO_PREFIX) SUBDIR_TARGETS              $(SUBDIR_TARGETS)"
	@echo "$(BS_INFO_PREFIX) "


ifdef SUBDIR_TARGETS
$(SUBDIR_TARGETS):
	@echo "$(BS_INFO_PREFIX) --- Entering $@"
	$(MAKE) -C $@ $(MAKECMDGOALS)
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

