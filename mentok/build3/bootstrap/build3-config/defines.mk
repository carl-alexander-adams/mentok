# Component wide defines file

# Component wide defaults overriding those built into the 
# build system should also be set here. for example...
# FLAGS_CC = -fPIC -D_REENTRANT


include $(COMPONENT_ROOT)/build3-config/buildnum.mk

BUILDSTAMP_NAME=$(PROJECT)
BUILDSTAMP_REVISION_MAJOR=$(VERSION_MAJOR)
BUILDSTAMP_REVISION_MINOR=$(VERSION_MINOR)
BUILDSTAMP_REVISION_PATCH=$(VERSION_PATCH)

# This populates the revision string with a value 
# that looks like the string used by the old build system.
BUILDSTAMP_REVISION_STRING=$(PRODUCTNUM)-$(BS_DATE_YEAR)$(BS_DATE_MONTH)$(BS_DATE_DAY)$(BS_DATE_HOUR)$(BS_DATE_MINUTE)$(BS_DATE_SECOND)-$(NC_CONTROL_DEBUG)$(NC_CONTROL_STRIP)$(if $(BS_VTAG),-$(BS_VTAG))

# Default flags someone might want to set.
FLAGS_CC = -D_REENTRANT -I$(COMPONENT_IMPORT_ARCH_TARGET_DIR)/include

# This is how you would force a build number to be linked into all "final" targes.
FLAGS_AR_LIB_LOADLIBS+=$(COMPONENT_ROOT)/buildnum/$(BS_ARCH_TARGET_DIR)/buildnum.o
FLAGS_LD_SHLIB_LOADLIBS+=$(COMPONENT_ROOT)/buildnum/$(BS_ARCH_TARGET_DIR)/buildnum.o
FLAGS_LD_EXE_LOADLIBS+=$(COMPONENT_ROOT)/buildnum/$(BS_ARCH_TARGET_DIR)/buildnum.o


# Layer in per-product per-OS defines...
-include $(COMPONENT_ROOT)/build3-config/defines-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(COMPONENT_ROOT)/build3-config/defines-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(COMPONENT_ROOT)/build3-config/defines-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(COMPONENT_ROOT)/build3-config/defines-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(COMPONENT_ROOT)/build3-config/defines-$(BS_PLATFORM_ARCH_FULL).mk

