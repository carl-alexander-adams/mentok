#
# include platform specific native code macros
#
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_12).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_11).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_10).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_9).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_8).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_7).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_6).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_5).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/packaging/defines-packaging-$(BS_PLATFORM_ARCH_FULL).mk



ifeq ($(PACKAGE_ROOT),)
PACKAGE_ROOT=$(COMPONENT_ROOT)/PACKAGE$(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG)))
endif

ifeq ($(PACKAGE_ROOT_ABSPATH),)
PACKAGE_ROOT_ABSPATH:=$(COMPONENT_ROOT_ABSPATH)/PACKAGE$(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG)))
endif
export PACKAGE_ROOT_ABSPATH

ifeq ($(PACKAGE_TARGET_DIR),)
PACKAGE_TARGET_DIR=$(PACKAGE_ROOT)/stage/$(call _func_get_target_platform,$(PROJECT))
endif

ifeq ($(PACKAGE_TARGET_DIR_ABSPATH),)
PACKAGE_TARGET_DIR_ABSPATH=$(PACKAGE_ROOT_ABSPATH)/stage/$(call _func_get_target_platform,$(PROJECT))
endif
export PACKAGE_TARGET_DIR_ABSPATH

ifeq ($(PACKAGE_RELEASE_DIR),)
PACKAGE_RELEASE_DIR=$(PACKAGE_ROOT)/release/$(call _func_get_target_platform,$(PROJECT))
endif

ifeq ($(PACKAGE_RELEASE_DIR_ABSPATH),)
PACKAGE_RELEASE_DIR_ABSPATH=$(PACKAGE_ROOT_ABSPATH)/release/$(call _func_get_target_platform,$(PROJECT))
endif
export PACKAGE_RELEASE_DIR_ABSPATH

ifeq ($(FLAGS_EPM),)
FLAGS_EPM=--software-dir /hive/etc
endif


# Always export the packaging vtag, since it's useful for packaging and should never vary accross makefiles.
export PACKAGE_VTAG
