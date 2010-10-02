#
# Top root level rules. These are the targets
# that users are expected to request, and that
# buils system modules tie into.
#

#
# We currently hook base_force_manual_depends into most targets to
# force a manual "make depends" as the very first step.  THis is done
# because gnu make seems to have issues not full absorbing dependencies
# that are build in the fly with "-include depends.mk" 
#

# top level build slices make modules can auto hook into.
# we may want to consider expanding this notion into N number
# of slices at some point.

# the default...
default: target

# recursion slice to make other targets recursive - 
# This just hooks into the recursion module, but keeps the
# modular design intact.
recursion_subdirs:
recursion:: recursion_subdirs

# slice intented for code generation, etc.
pretarget:: base_force_manual_depends
pretarget:: recursion

# slice intended for compiling the meat
target:: pretarget

# slice intended for packaging and whatnot.
posttarget:: target

# slice intended to execute test code. Test code should be build during regular target phase.
# XXX TODO: should I have a more uniform TEST_TARGETS? TEST_EXE_TARGETS, TEST_CTEST_TARGETS, etc? Probably.
test:: target

# target intended for surgical cleanup
clean:: recursion 

# target intended for scorched earth cleanup. - This cleans the whole component.
nuke::

# target intended for scorched earth cleanup. - This cleans just the current sub-tree.
# XXX Maybe we should replace "clean" with this?
nukesub::

# target to force dependancy regeneration.
# also, force import before depends.
depends:: component_import
depends:: recursion

# target to dump out macro values
info::

# target to provide online help
man::

# make .PHONY a double colen rule build system wide
.PHONY::

# make .INTERMEDIATE a double colen rule build system wide
.INTERMEDIATE::




#
# Rules that are part of the root, not  part of any particular build
# system module.
#
man:: root_man

root_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_LYNX) -dump $(BS_ROOT)/buildsystem3.html

#
# Get base rules.
#
include $(BS_ROOT)/base/rules-base.mk

#
# Get the component rules
#
include $(COMPONENT_ROOT)/build3-config/rules.mk

#
# Get modules' rules.
#
include $(BS_ROOT)/recursion/rules-recursion.mk
include $(BS_ROOT)/config/rules-config.mk
include $(BS_ROOT)/checkenv/rules-checkenv.mk
include $(BS_ROOT)/codegen/rules-codegen.mk
include $(BS_ROOT)/nativecode/rules-nativecode.mk
include $(BS_ROOT)/component/rules-component.mk
# include $(BS_ROOT)/aliencode/rules-aliencode.mk
include $(BS_ROOT)/javacode/rules-javacode.mk
include $(BS_ROOT)/pythoncode/rules-pythoncode.mk
include $(BS_ROOT)/flex/rules-flex.mk
include $(BS_ROOT)/packaging/rules-packaging.mk
include $(BS_ROOT)/release-engineering/rules-release-engineering.mk
include $(BS_ROOT)/doc/rules-doc.mk
include $(BS_ROOT)/xmlmd/rules-xmlmd.mk
include $(BS_ROOT)/perforce/rules-perforce.mk

