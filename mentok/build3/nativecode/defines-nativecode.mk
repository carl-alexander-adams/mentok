#
# include platform specific native code macros
#
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FULL).mk


ifeq ($(NC_CONTROL_TOOLCHAIN),)
NC_CONTROL_TOOLCHAIN=GNU
endif

ifeq ($(NC_CONTROL_OPTIMIZE),)
NC_CONTROL_OPTIMIZE=1
endif

ifeq ($(NC_CONTROL_DEBUG),)
NC_CONTROL_DEBUG=0
endif

ifeq ($(NC_CONTROL_STRIP),)
NC_CONTROL_STRIP=1
endif

ifeq ($(NC_CONTROL_PROFILE),)
NC_CONTROL_PROFILE=0
endif

ifeq ($(NC_CONTROL_COV),)
NC_CONTROL_COV=0
endif
