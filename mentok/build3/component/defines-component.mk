ifeq ($(COMPONENT_DISTROOT),)
COMPONENT_DISTROOT=/h/component_server/dist
endif

ifeq ($(COMPONENT_IMPORT_TARGET_ROOT),)
COMPONENT_IMPORT_TARGET_ROOT=$(COMPONENT_ROOT)/components$(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG)))
endif

ifeq ($(COMPONENT_IMPORT_ARCH_TARGET_DIR),)
COMPONENT_IMPORT_ARCH_TARGET_DIR=$(COMPONENT_IMPORT_TARGET_ROOT)/$(BS_PLATFORM_ARCH_FULL)
endif

ifeq ($(COMPONENT_IMPORT_NOARCH_TARGET_DIR),)
COMPONENT_IMPORT_NOARCH_TARGET_DIR=$(COMPONENT_IMPORT_TARGET_ROOT)/$(BS_PLATFORM_NOARCH)
endif

ifeq ($(COMPONENT_DIST_COMPATIBILITY_PLATFORMS),)
COMPONENT_DIST_COMPATIBILITY_PLATFORMS=$(BS_PLATFORM_ARCH_FULL) \
$(BS_PLATFORM_ARCH_FALLBACK_1) \
$(BS_PLATFORM_ARCH_FALLBACK_2) \
$(BS_PLATFORM_ARCH_FALLBACK_5) \
$(BS_PLATFORM_ARCH_FALLBACK_6) \
$(BS_PLATFORM_ARCH_FALLBACK_7) \
$(BS_PLATFORM_ARCH_LEGACYFALLBACK_1) \
$(BS_PLATFORM_ARCH_LEGACYFALLBACK_2) \
$(BS_PLATFORM_ARCH_LEGACYFALLBACK_3) \
$(BS_PLATFORM_ARCH_LEGACYFALLBACK_4)
endif

ifeq ($(COMPONENT_DIST_COMPATIBILITY_PLATFORMS_AND_VTAG),)
COMPONENT_DIST_COMPATIBILITY_PLATFORMS_AND_VTAG=$(addsuffix $(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG))),$(COMPONENT_DIST_COMPATIBILITY_PLATFORMS))
endif
