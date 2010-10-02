#
# include platform specific flex code macros
#
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_12).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_11).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_10).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_9).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_8).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_7).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_6).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_5).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/flex/defines-flex-$(BS_PLATFORM_ARCH_FULL).mk


#
# global defaults
#

# Default tool chain now controller per-platform
#ifeq ($(FLEX_CONTROL_XXX),)
#FLEX_CONTROL_XXXN=XXX
#endif

#
# Always export these.
#
export FLEX_HOME
