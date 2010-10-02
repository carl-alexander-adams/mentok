#
# include platform specific native code macros
#
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_12).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_11).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_10).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_9).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_8).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_7).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_6).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_5).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/pythoncode/defines-pythoncode-$(BS_PLATFORM_ARCH_FULL).mk


ifeq ($(PYTHONCODE_PYC_EXEC_STUB),)
PYTHONCODE_PYC_EXEC_STUB=$(BS_ROOT)/pythoncode/pyc_exec_stub
endif
