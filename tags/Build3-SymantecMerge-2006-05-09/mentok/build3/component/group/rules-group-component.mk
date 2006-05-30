# BDIR targets for each enabled and disabled slave component
EN_BDIRS = $(addprefix $(BDIR)/,$(ENABLED_SLAVES))
DIS_BDIRS = $(addprefix $(BDIR)/,$(DISABLED_SLAVES))

# Keep an absolute-path version of the target directory for passing to foreign
# Makefiles
ABS_TARGET := $(BS_CURRENT_SRCDIR_ABSPATH)/$(BS_ARCH_TARGET_DIR)

# look inside our imports.mk in order to pick up our IMPORT_ARCH_TARGETS
include $(COMPONENT_ROOT)/imports.mk

# Absolute path to our component directory
ABS_COMPONENTS := $(BS_CURRENT_SRCDIR_ABSPATH)/$(COMPONENT_ROOT)/components/$(BS_PLATFORM_ARCH_FULL)

# This is what gets added to Makefiles to override where the slave components
# we build get imported into the other.  Of course not all slaves actually
# import all of these, but specifying unsed "xxx_FROM=" specifiers is harmless.
#
# We also intentionally poison the DISTROOT variables (for both build3 and
# build2) so any components that are imported by the slaves must come from
# us or an error will be generated
#
ALL_IMPORTS_FROM = \
	BS_BOOTSTRAP_SRC=$(BS_CURRENT_SRCDIR_ABSPATH)/$(COMPONENT_ROOT)/build3 \
	$(foreach t,$(IMPORT_ARCH_TARGETS),$(t)_FROM=$(ABS_COMPONENTS)/$(t)) \
	$(foreach t,$(ENABLED_SLAVES),$(t)_FROM=$(ABS_TARGET)/$(t)) \
	COMPONENT_DISTROOT=/non/existant/directory \
	DISTROOT=/non/existant/directory

target:: $(EN_BDIRS)

# This is the generic rule to build one slave.  Steps are:
#   1. Nuke anything that exists in our tree from a previous build
#   2. Call the slave's "make nuke" to clean its tree
#   3. Ask the slave to build itself, overriding any component imports to
#      come directly from our tree instead of /h/wopr/dist
#   4. Call the slave's "make package" to copy all of the slave's exports
#      into our tree.  Note that the make variable to override the package
#      directory is different between build2 (PKGDIR) and build3
#      (PACKAGE_TARGET_DIR).  We specify both in order to work on all slaves
#   5. Finally touch the built/TARGET file so make's dependency resolution
#      knows when this package was built
#
$(EN_BDIRS):
$(EN_BDIRS): _T=$(notdir $(@))
$(EN_BDIRS): _SLVDIR=$(COMPONENT_ROOT)/../$(_T)
$(EN_BDIRS): _PKGDST=$(ABS_TARGET)$(if $($(_T)_PKGSUBDIR),/$($(_T)_PKGSUBDIR),)
$(EN_BDIRS):
	$(BIN_MKDIR) -p $(BDIR)
	-$(RM) -rf $(ABS_TARGET)/$(_T)
	$(MAKE) -C $(_SLVDIR) nuke $(ALL_IMPORTS_FROM)
	$(MAKE) -C $(_SLVDIR) $(ALL_IMPORTS_FROM)
	$(MAKE) -C $(_SLVDIR) package \
		PACKAGE_TARGET_DIR=$(_PKGDST) \
		PKGDIR=$(_PKGDST)
	$(BIN_TOUCH) $@

# For each disabled slave, just touch the BDIR entry.  This will satisfy any
# dependencies on a disabled slave component.
#
$(DIS_BDIRS):
	$(BIN_MKDIR) -p $(BDIR)
	$(BIN_TOUCH) $@

# This just copies all of the files exported to us by our slave into our
# package.  Also, turns off the execute bit on .h files - several components
# seem to export them and that's a pet peeve of mine
#
package:
	-$(BIN_CHMOD) -x $(BS_ARCH_TARGET_DIR)/*/include/*.h
	$(BIN_MKDIR) -p $(PACKAGE_TARGET_DIR)/$(PROJECT)
	for p in $(ENABLED_SLAVES); do $(BIN_CP) -R $(BS_ARCH_TARGET_DIR)/$${p}/* $(PACKAGE_TARGET_DIR)/$(PROJECT)/; done

clean::
	-$(RM) -rf $(BDIR)
