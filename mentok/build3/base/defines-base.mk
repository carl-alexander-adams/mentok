#
# The version of build3/project mentok itself.
#
BS_REVMAJOR=3
BS_REVMINOR=9
BS_REVPATCH=0

#
# Macros needed for bootstrapping the base of the build system.
#
ifeq ($(BIN_PLATFORMUTIL),)
BIN_PLATFORMUTIL=$(BS_ROOT)/util/plat.pl
endif

ifeq ($(BIN_SHADOWTREE),)
BIN_SHADOWTREE=$(BS_ROOT)/util/shadowtree.pl
endif


_platformutil_output:=$(shell $(BIN_PLATFORMUTIL) -a -d ' ')

export BS_OS_HOSTNAME:=$(word 1,$(_platformutil_output))
export BS_OS_NAME:=$(word 2,$(_platformutil_output))
export BS_OS_REVMAJOR:=$(word 3,$(_platformutil_output))
export BS_OS_REVMINOR:=$(word 4,$(_platformutil_output))
export BS_OS_REVPATCH:=$(word 5,$(_platformutil_output))
export BS_OS_RUNTIMENAME:=$(word 6,$(_platformutil_output))
export BS_OS_RUNTIMEREVMAJOR:=$(word 7,$(_platformutil_output))
export BS_OS_RUNTIMEREVMINOR:=$(word 8,$(_platformutil_output))
export BS_OS_RUNTIMEREVPATCH:=$(word 9,$(_platformutil_output))
export BS_OS_MACHINETYPE:=$(word 10,$(_platformutil_output))
export BS_OS_MACHINEPROC:=$(word 11,$(_platformutil_output))
export BS_OS_MACHINEINSTSET:=$(word 12,$(_platformutil_output))



#
# Functions to munge the OS/runtime details into platform strings for the sake
# of modules that provide this info in make defines over determining them
# from the build machine environment. Cross compliers need to do this.
#
# args: OS name, OS rev major, OS rev minor, OS rev patch
bs_FUNC_GEN_OS_FULL=$(strip $(1))-$(strip $(2))$(if $(strip $(3)),.$(strip $(3)))$(if $(strip $(4)),.$(strip $(4)))

# args: OS name, OS rev major, OS rev minor
bs_FUNC_GEN_OS_FALLBACK_1=$(strip $(1))-$(strip $(2))$(if $(strip $(3)),.$(strip $(3)))

# args: OS name, OS rev major
bs_FUNC_GEN_OS_FALLBACK_2=$(strip $(1))-$(strip $(2))

# args: OS name
bs_FUNC_GEN_OS_FALLBACK_3=$(strip $(1))


# args: runtime name, runtime rev major, runtime rev minor, runtime rev patch
bs_FUNC_GEN_RUNTIME_FULL=$(strip $(1))$(if $(strip $(2)),-$(strip $(2)))$(if $(strip $(3)),.$(strip $(3)))$(if $(strip $(4)),.$(strip $(4)))

# args: runtime name, runtime rev major, runtime rev minor
bs_FUNC_GEN_RUNTIME_FALLBACK_1=$(strip $(1))$(if $(strip $(2)),-$(strip $(2)))$(if $(strip $(3)),.$(strip $(3)))

# args: runtime name, runtime rev major
bs_FUNC_GEN_RUNTIME_FALLBACK_2=$(strip $(1))$(if $(strip $(2)),-$(strip $(2)))

# args: runtime name
bs_FUNC_GEN_RUNTIME_FALLBACK_3=$(strip $(1))


# Args for all BS_FUNC_GEN_PLATFORM_* functions:
#  (1)OS name 
#  (2)OS major
#  (3)OS minor
#  (4)OS patch
#  (5)machine instruciton set
#  (6)machine type
#  (7)runtime name
#  (8)runtime major
#  (9)runtime minor
#  (10)runtime patch

# Original Build3 fallback list
# BS_FUNC_GEN_PLATFORM_FULL=$(call bs_FUNC_GEN_OS_FULL, $(1), $(2), $(3), $(4))-$(call bs_FUNC_GEN_RUNTIME_FULL, $(7), $(8), $(9), $(10))-$(strip $(5))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_1=$(call bs_FUNC_GEN_OS_FULL, $(1), $(2), $(3), $(4))-$(call bs_FUNC_GEN_RUNTIME_FALLBACK_1, $(7), $(8), $(9))-$(strip $(5))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_2=$(call bs_FUNC_GEN_OS_FALLBACK_1, $(1), $(2), $(3))-$(call bs_FUNC_GEN_RUNTIME_FULL, $(7), $(8), $(9), $(10))-$(strip $(5))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_3=$(call bs_FUNC_GEN_OS_FALLBACK_1, $(1), $(2), $(3))-$(call bs_FUNC_GEN_RUNTIME_FALLBACK_1, $(7), $(8), $(9))-$(strip $(5))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_4=$(call bs_FUNC_GEN_OS_FALLBACK_1, $(1), $(2), $(3))-$(call bs_FUNC_GEN_RUNTIME_FALLBACK_2, $(7), $(8))-$(strip $(5))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_5=$(call bs_FUNC_GEN_OS_FALLBACK_3, $(1))-$(call bs_FUNC_GEN_RUNTIME_FALLBACK_1, $(7), $(8), $(9))-$(strip $(5))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_6=$(call bs_FUNC_GEN_OS_FALLBACK_3, $(1))-$(call bs_FUNC_GEN_RUNTIME_FALLBACK_2, $(7), $(8))-$(strip $(5))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_7=$(call bs_FUNC_GEN_OS_FALLBACK_3, $(1))-$(call bs_FUNC_GEN_RUNTIME_FALLBACK_3, $(7))-$(strip $(5))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_8=$(call bs_FUNC_GEN_OS_FALLBACK_1, $(1), $(2), $(3))-$(strip $(5))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_9=$(call bs_FUNC_GEN_OS_FALLBACK_3, $(1))-$(strip $(5))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_10=$(call bs_FUNC_GEN_OS_FALLBACK_3, $(1))-$(call bs_FUNC_GEN_RUNTIME_FALLBACK_2, $(7), $(8))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_11=$(call bs_FUNC_GEN_OS_FALLBACK_3, $(1))-$(call bs_FUNC_GEN_RUNTIME_FALLBACK_3, $(7))
# 
# BS_FUNC_GEN_PLATFORM_FALLBACK_12=$(call bs_FUNC_GEN_OS_FALLBACK_3, $(1))


# Simplified build3 platform fallback list for nCircle (because FreeBSD-FreeBSD looks silly, and for everything that isn't kernel code it's the runtime that matters.)
BS_FUNC_GEN_PLATFORM_FULL=$(call bs_FUNC_GEN_RUNTIME_FULL, $(7), $(8), $(9), $(10))-$(strip $(5))

BS_FUNC_GEN_PLATFORM_FALLBACK_1=$(call bs_FUNC_GEN_RUNTIME_FALLBACK_1, $(7), $(8), $(9))-$(strip $(5))

BS_FUNC_GEN_PLATFORM_FALLBACK_2=$(call bs_FUNC_GEN_RUNTIME_FALLBACK_2, $(7), $(8))-$(strip $(5))

BS_FUNC_GEN_PLATFORM_FALLBACK_3=$(call bs_FUNC_GEN_RUNTIME_FALLBACK_3, $(7))-$(strip $(5))

BS_FUNC_GEN_PLATFORM_FALLBACK_4=$(call bs_FUNC_GEN_RUNTIME_FALLBACK_3, $(7))

BS_FUNC_GEN_PLATFORM_FALLBACK_5=

BS_FUNC_GEN_PLATFORM_FALLBACK_6=

BS_FUNC_GEN_PLATFORM_FALLBACK_7=$(call bs_FUNC_GEN_OS_FULL, $(1), $(2), $(3), $(4))-$(strip $(5))

BS_FUNC_GEN_PLATFORM_FALLBACK_8=$(call bs_FUNC_GEN_OS_FALLBACK_1, $(1), $(2), $(3))-$(strip $(5))

BS_FUNC_GEN_PLATFORM_FALLBACK_9=$(call bs_FUNC_GEN_OS_FALLBACK_2, $(1), $(2))-$(strip $(5))

BS_FUNC_GEN_PLATFORM_FALLBACK_10=$(call bs_FUNC_GEN_OS_FALLBACK_3, $(1))-$(strip $(5))

BS_FUNC_GEN_PLATFORM_FALLBACK_11=$(call bs_FUNC_GEN_OS_FALLBACK_3, $(1))-$(strip $(5))

BS_FUNC_GEN_PLATFORM_FALLBACK_12=$(call bs_FUNC_GEN_OS_FALLBACK_3, $(1))




BS_PLATFORM_NOARCH=noarch

BS_PLATFORM_ARCH_FULL=$(call BS_FUNC_GEN_PLATFORM_FULL,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_1=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_1,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_2=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_2,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_3=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_3,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_4=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_4,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_5=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_5,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_6=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_6,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_7=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_7,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_8=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_8,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_9=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_9,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_10=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_10,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_11=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_11,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))
BS_PLATFORM_ARCH_FALLBACK_12=$(call BS_FUNC_GEN_PLATFORM_FALLBACK_12,\
	$(BS_OS_NAME),\
	$(BS_OS_REVMAJOR),\
	$(BS_OS_REVMINOR),\
	$(BS_OS_REVPATCH),\
	$(BS_OS_MACHINEINSTSET),\
	$(BS_OS_MACHINETYPE),\
	$(BS_OS_RUNTIMENAME),\
	$(BS_OS_RUNTIMEREVMAJOR),\
	$(BS_OS_RUNTIMEREVMINOR),\
	$(BS_OS_RUNTIMEREVPATCH))

BS_PLATFORM_ARCH_LIST= \
	$(BS_PLATFORM_ARCH_FULL) \
	$(BS_PLATFORM_ARCH_FALLBACK_1) \
	$(BS_PLATFORM_ARCH_FALLBACK_2) \
	$(BS_PLATFORM_ARCH_FALLBACK_3) \
	$(BS_PLATFORM_ARCH_FALLBACK_4) \
	$(BS_PLATFORM_ARCH_FALLBACK_5) \
	$(BS_PLATFORM_ARCH_FALLBACK_6) \
	$(BS_PLATFORM_ARCH_FALLBACK_7) \
	$(BS_PLATFORM_ARCH_FALLBACK_8) \
	$(BS_PLATFORM_ARCH_FALLBACK_9) \
	$(BS_PLATFORM_ARCH_FALLBACK_10) \
	$(BS_PLATFORM_ARCH_FALLBACK_11) \
	$(BS_PLATFORM_ARCH_FALLBACK_12)

#
# include platform specific base macros
#
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_12).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_11).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_10).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_9).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_8).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_7).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_6).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_5).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/base/defines-base-$(BS_PLATFORM_ARCH_FULL).mk

#
# Base module step 2.. some general build environment macros and common utilities
#

#
# Bin Programs & scripts
#
ifeq ($(BIN_COMPONENTUTIL),)
BIN_COMPONENTUTIL=$(BIN_PERL) $(BS_ROOT)/util/component-desc-util.pl
endif

ifeq ($(BIN_STATUS_MSG),)
BIN_STATUS_MSG=$(BIN_PERL) $(BS_ROOT)/util/status-msg.pl
endif

#
# Info / Control macros.
#
BS_INFO_PREFIX="+ "
BS_WARN_PREFIX="\*\* "
BS_ERROR_PREFIX="\*\*\* ERROR "


BS_ROOT_TARGET_DIR=BUILDTARGETS$(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG)))

BS_FUNC_GEN_TARGET_DIR=$(BS_ROOT_TARGET_DIR)/$(strip $(1))

BS_ARCH_TARGET_DIR=$(call BS_FUNC_GEN_TARGET_DIR, $(BS_PLATFORM_ARCH_FULL))
export BS_ARCH_TARGET_DIR
BS_NOARCH_TARGET_DIR=$(call BS_FUNC_GEN_TARGET_DIR, $(BS_PLATFORM_NOARCH))
export BS_NOARCH_TARGET_DIR

BS_CURRENT_SRCDIR_ABSPATH=$(shell $(BIN_PWD))
export BS_CURRENT_SRCDIR_ABSPATH

BS_ARCH_TARGET_DIR_ABSPATH=$(BS_CURRENT_SRCDIR_ABSPATH)/$(BS_ARCH_TARGET_DIR)
export BS_ARCH_TARGET_DIR_ABSPATH
BS_NOARCH_TARGET_DIR_ABSPATH=$(BS_CURRENT_SRCDIR_ABSPATH)/$(BS_NOARCH_TARGET_DIR)
export BS_NOARCH_TARGET_DIR_ABSPATH



ifeq ($(BS_ROOT_ABSPATH),)
BS_ROOT_ABSPATH:=$(shell $(BIN_CD) $(BS_ROOT) && $(BIN_PWD))
endif
export BS_ROOT_ABSPATH

ifeq ($(COMPONENT_ROOT_ABSPATH),)
COMPONENT_ROOT_ABSPATH:=$(shell $(BIN_CD) $(COMPONENT_ROOT) && $(BIN_PWD))
endif
export COMPONENT_ROOT_ABSPATH

ifeq ($(BS_DATE_YEAR),)
BS_DATE_YEAR:=$(shell $(BIN_DATE) +%Y)
endif
export BS_DATE_YEAR

ifeq ($(BS_DATE_MONTH),)
BS_DATE_MONTH:=$(shell $(BIN_DATE) +%m)
endif
export BS_DATE_MONTH

ifeq ($(BS_DATE_DAY),)
BS_DATE_DAY:=$(shell $(BIN_DATE) +%d)
endif
export BS_DATE_DAY

ifeq ($(BS_DATE_DAYOFYEAR),)
BS_DATE_DAYOFYEAR:=$(shell $(BIN_DATE) +%j)
endif
export BS_DATE_DAYOFYEAR

ifeq ($(BS_DATE_HOUR),)
BS_DATE_HOUR:=$(shell $(BIN_DATE) +%H)
endif
export BS_DATE_HOUR

ifeq ($(BS_DATE_MINUTE),)
BS_DATE_MINUTE:=$(shell $(BIN_DATE) +%M)
endif
export BS_DATE_MINUTE

ifeq ($(BS_DATE_SECOND),)
BS_DATE_SECOND:=$(shell $(BIN_DATE) +%S)
endif
export BS_DATE_SECOND

ifeq ($(BS_DATE_UNIXSECOND),)
BS_DATE_UNIXSECOND:=$(shell $(BIN_DATE) +%s)
endif
export BS_DATE_UNIXSECOND

ifeq ($(BS_DATE_UNIXNANOSECOND),)
BS_DATE_UNIXNANOSECOND:=$(shell $(BIN_DATE) +%N)
endif
export BS_DATE_UNIXNANOSECOND

# "Day of year" might have two leading zeros
# We also have to be careful to avoid empty string results
# bs_FUNC_STRIP_LEADING_ZEROS=$(shell $(BIN_ECHO) $1 | $(BIN_SED) 's/^0*//')
bs_FUNC_STRIP_LEADING_2_ZEROS=$(patsubst 0%,%,$(patsubst 0%,%,$1))
bs_FUNC_STRIP_LEADING_1_ZEROS=$(patsubst 0%,%,$1)
export BS_DATE_MONTH_NOPAD:=$(call bs_FUNC_STRIP_LEADING_1_ZEROS, $(BS_DATE_MONTH))
export BS_DATE_DAY_NOPAD:=$(call bs_FUNC_STRIP_LEADING_1_ZEROS, $(BS_DATE_DAY))
export BS_DATE_DAYOFYEAR_NOPAD:=$(call bs_FUNC_STRIP_LEADING_2_ZEROS, $(BS_DATE_DAYOFYEAR))
export BS_DATE_HOUR_NOPAD:=$(call bs_FUNC_STRIP_LEADING_1_ZEROS, $(BS_DATE_HOUR))
export BS_DATE_MINUTE_NOPAD:=$(call bs_FUNC_STRIP_LEADING_1_ZEROS, $(BS_DATE_MINUTE))
export BS_DATE_SECOND_NOPAD:=$(call bs_FUNC_STRIP_LEADING_1_ZEROS, $(BS_DATE_SECOND))
# Nanosecond needs padding to make sense as a decimal float
# export BS_DATE_NANOSECOND_NOPAD:=$(BS_DATE_NANOSECOND)

ifeq ($(BS_USERNAME),)
BS_USERNAME:=$(shell $(BIN_WHOAMI))
endif
export BS_USERNAME
ifeq ($(BS_VERBOSE),)
BS_VERBOSE=0
endif
export BS_VERBOSE


# The build system verbose macro is used to toggle the verbosity of
# the build system as a whole.
ifeq ($(BS_VERBOSE),3)
BS_CMDPREFIX_VERBOSE0=
BS_CMDPREFIX_VERBOSE1=
BS_CMDPREFIX_VERBOSE2=
BS_CMDPREFIX_VERBOSE3=
BS_FUNC_ECHO_VERBOSE0=echo $1
BS_FUNC_ECHO_VERBOSE1=echo $1
BS_FUNC_ECHO_VERBOSE2=echo $1
BS_FUNC_ECHO_VERBOSE3=echo $1
else
ifeq ($(BS_VERBOSE),2)
BS_CMDPREFIX_VERBOSE0=
BS_CMDPREFIX_VERBOSE1=
BS_CMDPREFIX_VERBOSE2=
BS_CMDPREFIX_VERBOSE3=@
BS_FUNC_ECHO_VERBOSE0=echo $1
BS_FUNC_ECHO_VERBOSE1=echo $1
BS_FUNC_ECHO_VERBOSE2=echo $1
BS_FUNC_ECHO_VERBOSE3=
else
ifeq ($(BS_VERBOSE),1)
BS_CMDPREFIX_VERBOSE0=
BS_CMDPREFIX_VERBOSE1=
BS_CMDPREFIX_VERBOSE2=@
BS_CMDPREFIX_VERBOSE3=@
BS_FUNC_ECHO_VERBOSE0=echo $1
BS_FUNC_ECHO_VERBOSE1=echo $1
BS_FUNC_ECHO_VERBOSE2=
BS_FUNC_ECHO_VERBOSE3=
else
# BS_VERBOSE == 0
BS_CMDPREFIX_VERBOSE0=
BS_CMDPREFIX_VERBOSE1=@
BS_CMDPREFIX_VERBOSE2=@
BS_CMDPREFIX_VERBOSE3=@
BS_FUNC_ECHO_VERBOSE0=echo $1
BS_FUNC_ECHO_VERBOSE1=
BS_FUNC_ECHO_VERBOSE2=
BS_FUNC_ECHO_VERBOSE3=
endif
endif
endif
