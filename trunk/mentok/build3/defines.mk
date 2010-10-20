include $(COMPONENT_ROOT)/build3-config/predefines.mk

include $(BS_ROOT)/base/defines-base.mk
include $(BS_ROOT)/recursion/defines-recursion.mk
include $(BS_ROOT)/config/defines-config.mk
include $(BS_ROOT)/checkenv/defines-checkenv.mk
include $(BS_ROOT)/codegen/defines-codegen.mk
include $(BS_ROOT)/nativecode/defines-nativecode.mk
include $(BS_ROOT)/component/defines-component.mk
# include $(BS_ROOT)/aliencode/defines-aliencode.mk
include $(BS_ROOT)/javacode/defines-javacode.mk
include $(BS_ROOT)/pythoncode/defines-pythoncode.mk
include $(BS_ROOT)/flex/defines-flex.mk
include $(BS_ROOT)/packaging/defines-packaging.mk
include $(BS_ROOT)/release-engineering/defines-release-engineering.mk
include $(BS_ROOT)/doc/defines-doc.mk
include $(BS_ROOT)/xmlmd/defines-xmlmd.mk
include $(BS_ROOT)/perforce/defines-perforce.mk

include $(BS_ROOT)/branch-globals.mk

include $(COMPONENT_ROOT)/build3-config/postdefines.mk

