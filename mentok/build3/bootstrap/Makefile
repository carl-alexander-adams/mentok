#
# Sample top level make file.
#
COMPONENT_ROOT=.
BS_ROOT=$(COMPONENT_ROOT)/build3

include $(BS_ROOT)/defines.mk
include $(COMPONENT_ROOT)/imports.mk

SUBDIR_TARGETS=buildnum pkg

include $(BS_ROOT)/rules.mk

#
# Top level magic to auto-bootstrap.
#

$(BS_ROOT)/defines.mk: $(COMPONENT_ROOT)/Makefile-build3.mk
$(BS_ROOT)/defines.mk: $(COMPONENT_ROOT)/build3-config/build3-bootstrap.mk 
	$(MAKE) -f $(COMPONENT_ROOT)/Makefile-build3.mk all

$(BS_ROOT)/rules.mk: $(COMPONENT_ROOT)/Makefile-build3.mk
$(BS_ROOT)/rules.mk: $(COMPONENT_ROOT)/build3-config/build3-bootstrap.mk 
	$(MAKE) -f $(COMPONENT_ROOT)/Makefile-build3.mk all

nuke::
	$(MAKE) -f $(COMPONENT_ROOT)/Makefile-build3.mk clean

