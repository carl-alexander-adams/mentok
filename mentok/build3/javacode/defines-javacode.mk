#
# include platform specific native code macros
#
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_4).mk
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_3).mk
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_2).mk
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_1).mk
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FULL).mk



ifeq ($(JC_JAVASRCROOT),)
JC_JAVASRCROOT=$(COMPONENT_ROOT)/java
endif

ifeq ($(JC_CLASSPATH),)
JC_CLASSPATH=$(JC_JAVASRCROOT):$(JC_JAVAHOME)/jre/lib/rt.jar:$(JC_JAVACCZIP)
endif
