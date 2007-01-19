#
# include platform specific native code macros
#
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_12).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_11).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_10).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_9).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_8).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_7).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_6).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_5).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/nativecode/defines-nativecode-$(BS_PLATFORM_ARCH_FULL).mk

#
# Link in toolchain macros
#
include $(BS_ROOT)/nativecode/toolchains/defines.mk


#
# Controls - global defaults
#

# Default tool chain now controller per-platform
#ifeq ($(NC_CONTROL_TOOLCHAIN),)
#NC_CONTROL_TOOLCHAIN=GNU
#endif

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

ifeq ($(NC_CONTROL_NOASSERT),)
NC_CONTROL_NOASSERT=0
endif

ifeq ($(NC_CONTROL_REENTRANT),)
NC_CONTROL_REENTRANT=0
endif
