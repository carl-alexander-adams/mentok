#
# include platform specific native code macros
#
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_12).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_11).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_10).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_9).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_8).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_7).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_6).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_5).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/perforce/defines-perforce-$(BS_PLATFORM_ARCH_FULL).mk

#
# Module functions.
#

# Shell pipelines bury error codes, so check result and use $(error).  we use nested calls to
# make sure we only invoke the shell command once since make functions don't really have
# local variables to receive the result.

# Debug to record how often shell command was invoked
#_p4_get_rev=$(shell $(BIN_ECHO) call-1 >>  /tmp/make.counter ; $(BIN_ECHO) call-1)
_p4_get_rev=$(strip $(shell $(BIN_PERFORCE_P4) changes -s submitted -m 1 '$(1)' | $(BIN_AWK) '{print $$2}'))
_p4_call_once_or_error=$(if $(1),$(1),$(error $(2)))
PERFORCE_FUNC_GET_LASTCHANGENUM=$(call _p4_call_once_or_error,$(call _p4_get_rev,$(1)),could not determine perforce version of "$(1)". (Perhaps a p4 login is required to refresh tickets, or P4PASSWD is not set?))


