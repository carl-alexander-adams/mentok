#
# include global toolchain rules - these impact all toolchains
#
include $(BS_ROOT)/nativecode/toolchains/global/rules.mk

#
# include vendor toolchain rules
#
include $(BS_ROOT)/nativecode/toolchains/vendor/rules.mk

#
# include gnu toolchain rules
#
include $(BS_ROOT)/nativecode/toolchains/gnu/rules.mk

#
# include purify toolchain rules
#
include $(BS_ROOT)/nativecode/toolchains/purify/rules.mk

#
# include kernel module toolchain rules
#
include $(BS_ROOT)/nativecode/toolchains/kernmod/rules.mk

#
# include Cavium MIPS 64 Linux cross compiler toolchain rules
#
# include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-linux/rules.mk

#
# include Cavium MIPS 64 Simple Executive cross compiler toolchain rules
#
# include $(BS_ROOT)/nativecode/toolchains/xc-caviummips64-simpleexecutive/rules.mk

#
# include Alteon MIPS 64 Sun cross compiler toolchain rules
#
# include $(BS_ROOT)/nativecode/toolchains/xc-alteonmips64-sun/rules.mk

#
# include Raza MIPS 64 Linux cross compiler toolchain rules
#
# include $(BS_ROOT)/nativecode/toolchains/xc-razamips64-linux/rules.mk

