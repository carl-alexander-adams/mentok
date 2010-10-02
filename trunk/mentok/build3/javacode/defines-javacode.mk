#
# include platform specific native code macros
#
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_12).mk
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_11).mk
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_10).mk
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_9).mk
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_8).mk
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_7).mk
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_6).mk
-include $(BS_ROOT)/javacode/defines-javacode-$(BS_PLATFORM_ARCH_FALLBACK_5).mk
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

# Export these so the binaries always have them?
# export JAVA_HOME=$(JC_JAVAHOME)
# export CLASSPATH=$(JC_JAVASRCROOT)
