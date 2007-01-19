#
# include global toolchain macros - these impact all toolchains
#
-include $(BS_ROOT)/nativecode/toolchains/global/defines.mk
-include $(BS_ROOT)/nativecode/toolchains/global/defines-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/nativecode/toolchains/global/defines-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/nativecode/toolchains/global/defines-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/nativecode/toolchains/global/defines-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/nativecode/toolchains/global/defines-$(BS_PLATFORM_ARCH_FULL).mk

#
# include vendor toolchain macros
#
-include $(BS_ROOT)/nativecode/toolchains/vendor/defines.mk
-include $(BS_ROOT)/nativecode/toolchains/vendor/defines-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/nativecode/toolchains/vendor/defines-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/nativecode/toolchains/vendor/defines-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/nativecode/toolchains/vendor/defines-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/nativecode/toolchains/vendor/defines-$(BS_PLATFORM_ARCH_FULL).mk

#
# include gnu toolchain macros
#
-include $(BS_ROOT)/nativecode/toolchains/gnu/defines.mk
-include $(BS_ROOT)/nativecode/toolchains/gnu/defines-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/nativecode/toolchains/gnu/defines-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/nativecode/toolchains/gnu/defines-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/nativecode/toolchains/gnu/defines-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/nativecode/toolchains/gnu/defines-$(BS_PLATFORM_ARCH_FULL).mk

#
# include purify toolchain macros
#
-include $(BS_ROOT)/nativecode/toolchains/purify/defines.mk
-include $(BS_ROOT)/nativecode/toolchains/purify/defines-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/nativecode/toolchains/purify/defines-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/nativecode/toolchains/purify/defines-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/nativecode/toolchains/purify/defines-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/nativecode/toolchains/purify/defines-$(BS_PLATFORM_ARCH_FULL).mk

#
# include kernel module toolchain macros
#
-include $(BS_ROOT)/nativecode/toolchains/kernmod/defines.mk
-include $(BS_ROOT)/nativecode/toolchains/kernmod/defines-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/nativecode/toolchains/kernmod/defines-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/nativecode/toolchains/kernmod/defines-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/nativecode/toolchains/kernmod/defines-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/nativecode/toolchains/kernmod/defines-$(BS_PLATFORM_ARCH_FULL).mk


#
# include Cavium MIPS 64 Linux cross compiler toolchain macros
#
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-linux/defines.mk
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-linux/defines-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-linux/defines-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-linux/defines-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-linux/defines-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-linux/defines-$(BS_PLATFORM_ARCH_FULL).mk

#
# include Cavium MIPS 64 Simple Executive cross compiler toolchain macros
#
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-simpleexecutive/defines.mk
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-simpleexecutive/defines-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-simpleexecutive/defines-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-simpleexecutive/defines-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-simpleexecutive/defines-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-simpleexecutive/defines-$(BS_PLATFORM_ARCH_FULL).mk

#
# include Alteon MIPS 64 Sun cross compiler toolchain macros
#
-include $(BS_ROOT)/nativecode/toolchains/xc-alteonmips64-sun/defines.mk
-include $(BS_ROOT)/nativecode/toolchains/xc-alteonmips64-sun/defines-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-alteonmips64-sun/defines-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-alteonmips64-sun/defines-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-alteonmips64-sun/defines-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-alteonmips64-sun/defines-$(BS_PLATFORM_ARCH_FULL).mk

#
# include Raza MIPS 64 Linux cross compiler toolchain macros
#
-include $(BS_ROOT)/nativecode/toolchains/xc-razamips64-linux/defines.mk
-include $(BS_ROOT)/nativecode/toolchains/xc-razamips64-linux/defines-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-razamips64-linux/defines-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-razamips64-linux/defines-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-razamips64-linux/defines-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/nativecode/toolchains/xc-razamips64-linux/defines-$(BS_PLATFORM_ARCH_FULL).mk

