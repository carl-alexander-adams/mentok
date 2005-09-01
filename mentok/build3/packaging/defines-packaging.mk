ifeq ($(PACKAGE_ROOT),)
PACKAGE_ROOT=$(COMPONENT_ROOT)/package$(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG)))
endif

ifeq ($(PACKAGE_TARGET_DIR),)
PACKAGE_TARGET_DIR=$(PACKAGE_ROOT)/built/$(call _func_get_target_platform,$(PROJECT))
endif


ifeq ($(PACKAGE_RELEASE_DIR),)
PACKAGE_RELEASE_DIR=$(PACKAGE_ROOT)/release/$(call _func_get_target_platform,$(PROJECT))
endif

