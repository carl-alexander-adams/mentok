COMPONENT_ROOT=..
BS_ROOT=$(COMPONENT_ROOT)/build3

include $(BS_ROOT)/defines.mk

DIST_TARGETS=$(PROJECT)

$(PROJECT)_FROM=$(PACKAGE_TARGET_DIR)/$(PROJECT)

include $(BS_ROOT)/rules.mk


# Make sure we always record our buils system version... 
# incase this xml got whacked by a "nuke" or something.
# This isn't needed for normal imports, but the build
# system is "special"
pretarget:: $(COMPONENT_IMPORT_NOARCH_TARGET_DIR)/component_descriptors/build3.xml

$(COMPONENT_IMPORT_NOARCH_TARGET_DIR)/component_descriptors/build3.xml:
	$(BIN_MKDIR) -p $(COMPONENT_IMPORT_NOARCH_TARGET_DIR)/component_descriptors
	$(BIN_CP) $(BS_ROOT)/component.xml $(COMPONENT_IMPORT_NOARCH_TARGET_DIR)/component_descriptors/build3.xml

