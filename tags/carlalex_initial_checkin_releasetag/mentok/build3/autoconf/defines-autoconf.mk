#
# include platform specific autoconf macros
#
-include $(BS_ROOT)/autoconf/defines-autoconf-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/autoconf/defines-autoconf-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/autoconf/defines-autoconf-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/autoconf/defines-autoconf-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/autoconf/defines-autoconf-$(BS_PLATFORM_ARCH_FULL).mk

