-include $(BS_ROOT)/doc/defines-doc-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/doc/defines-doc-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/dco/defines-doc-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/doc/defines-doc-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/doc/defines-doc-$(BS_PLATFORM_ARCH_FULL).mk


ifeq ($(BIN_DOXYGEN),)
BIN_DOXYGEN=$(BIN_FALSE)
endif


ifeq ($(FLAGS_DOXYGEN),)
FLAGS_DOXYGEN=
endif


