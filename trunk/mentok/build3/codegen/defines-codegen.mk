-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_12).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_11).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_10).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_9).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_8).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_7).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_6).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_5).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/codegen/defines-codegen-$(BS_PLATFORM_ARCH_FULL).mk


ifeq ($(BIN_KVPBUILDER),)
BIN_KVPBUILDER=$(BS_ROOT)/codegen/kvptemplate.pl
endif

ifeq ($(FLAGS_KVPBUILDER),)
FLAGS_KVPBUILDER=
endif

