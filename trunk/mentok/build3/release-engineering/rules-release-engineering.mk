#
# Module rules
#
releaseeng_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Release Engineering Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_BSCATMAN) $(BS_ROOT)/release-engineering/release-engineering.html

releaseeng_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Release Engineering Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) DISTTAG                             $(DISTTAG)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) STRIP                               $(STRIP)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) DEBUG                               $(DEBUG)")


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
# These end up being the user friendly targets used by most developers.
#
all: target

package: base_force_manual_depends
package: recursion_subdirs
package: target
package: packaging_epm
package: packaging_iso
package: packaging_zip
package: packaging_targz
package: packaging_mkdir
package: packaging_packagefile
package: packaging_packagedir

dist: package
dist: component_dist

#imports: base_force_manual_depends
#imports: recursion_subdirs
#imports: component_import

#import: imports

#
# Docs are build targets managed in parallel to the main binary targets.
#
doc: doc_doxygen
doc: recursion_subdirs


# This is the same.
# depends::
