#
# Module rules
#
releaseeng_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Release Engineering Module Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_BSCATMAN) $(BS_ROOT)/release-engineering/release-engineering.html

releaseeng_info:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Release Engineering Module Macro Settings"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) DISTTAG                             $(DISTTAG)"
	@echo "$(BS_INFO_PREFIX) STRIP                               $(STRIP)"
	@echo "$(BS_INFO_PREFIX) DEBUG                               $(DEBUG)"


#
# hook module rules into build system
#

info:: releaseeng_info

man:: releaseeng_man

pretarget::

target::

posttarget::

.PHONY:: releaseeng_info releaseeng_man


#
# Targets that release engineering automated build scripts expect to request.
#
all: target

package: recursion_subdirs
package: packaging_zip
package: packaging_targz
package: packaging_package

dist: recursion_subdirs
dist: component_dist

imports: recursion_subdirs
imports: component_import

#
# DOcs are build targets managed in parallel to the main binary targets.
#
doc: doc_doxygen



# This is the same.
# depends::
