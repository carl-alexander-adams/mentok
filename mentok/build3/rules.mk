
#
# Top root level rules. These are the targets
# that users are expected to request, and that
# buils system modules tie into.
#

# top level build slices make modules can auto hook into.
# we may want to consider expanding this notion into N number
# of slices at some point.

# the default...
default: target



# recursion slice to make other targets recursive - 
# This just hooks into the recursion module, but keeps the
# modular design intact.
recursion_subdirs: component_import
recursion:: recursion_subdirs

# slice intented for code generation, etc.
pretarget:: recursion

# slice intended for compiling the meat
target:: pretarget

# slice intended for packaging and whatnot.
posttarget:: target

# target intended for surgical cleanup
clean:: recursion 

# target intended for scorched earth cleanup.
nuke:: recursion

# target to force dependancy regeneration
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
# Coordinate how some modules play with each other
# this is specificly not a module requirement, since the
# use of one does not imply the use of the other.
#

component_dist: packaging_package




#
# Rules that are part of the root, not  part of any particular build
# system module.
#
man:: root_man

root_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_LYNX) -dump $(BS_ROOT)/buildsystem3.html

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
include $(BS_ROOT)/component/rules-component.mk
include $(BS_ROOT)/config/rules-config.mk
include $(BS_ROOT)/codegen/rules-codegen.mk
include $(BS_ROOT)/nativecode/rules-nativecode.mk
include $(BS_ROOT)/javacode/rules-javacode.mk
include $(BS_ROOT)/packaging/rules-packaging.mk
include $(BS_ROOT)/release-engineering/rules-release-engineering.mk
include $(BS_ROOT)/autoconf/rules-autoconf.mk
include $(BS_ROOT)/doc/rules-doc.mk
