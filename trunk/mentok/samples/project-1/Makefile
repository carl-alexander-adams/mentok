# The root of the current project.
# This should be first in the Makefile, and should
# be defined in every make file in a "dot relative" path.
#
# This definition will be different in every Makefile
COMPONENT_ROOT=.

# The root of the build3 makefile system once it's
# been attached to the project.  This should
# almost always be $(COMPONENT_ROOT)/build3, and the
# Makefile in the $(COMPONENT_ROOT) should provide
# some custom rules for attaching a specific version
# of the makefile system to the project. ONLY this
# top level Makefile should contain these bootstrapping rules.
#
# Corrollary: the $(COMPONENT_ROOT)/build3 directory SHOULD NOT
# be under the revsion control of the project using it. only
# $(COMPONENT_ROOT)/build3-config belongs in the project's
# revision control system.
#
# This definition is expected to be the same in every Makefile.
BS_ROOT=$(COMPONENT_ROOT)/build3

# The principle definition file for the build3 makefile system.
# This should always be near the top of your Makefile.  The
# core build3 system will take care of pulling in project defines
# in the $(COMPONENT_ROOT)/build3-config directory.
include $(BS_ROOT)/defines.mk

# An ordered list of subdirectory targets.
# The build3 makefile system employs a depth first approach to
# compiling source code, and you should lay out your tree
# accrodingly.
SUBDIR_TARGETS=src # doc pkg


# The principle rules file for the build3 makefile system.
# This should always be near the bottome of your Makefile.  
# This file MUST be included before any custom rules you define
# in the local Makefile.  Failure to do this will override
# which targets make considers the default, and will likely
# result in unexpected behavior. The core build3 system will 
# take care of pulling in project rules in the 
# $(COMPONENT_ROOT)/build3-config directory.
include $(BS_ROOT)/rules.mk


#
# Custom Rules go here.
#

#
# Top level custom rules to bootstrap the build3 makefile
# system from rules in another Makefile. This works because
# Gnu make will look for a rule to create $(BS_ROOT)/defines.mk
# and $(BS_ROOT)/rules.mk when the includes (above) fail.
# 
$(BS_ROOT)/defines.mk: $(COMPONENT_ROOT)/build3-config/bootstrap.mk
	BS_ROOT=$(BS_ROOT) \
	COMPONENT_ROOT=$(COMPONENT_ROOT) \
	$(MAKE) -f $(COMPONENT_ROOT)/build3-config/bootstrap.mk all

$(BS_ROOT)/rules.mk: $(COMPONENT_ROOT)/build3-config/bootstrap.mk
	BS_ROOT=$(BS_ROOT) \
	COMPONENT_ROOT=$(COMPONENT_ROOT) \
	$(MAKE) -f $(COMPONENT_ROOT)/build3-config/bootstrap.mk all

nuke::
	BS_ROOT=$(BS_ROOT) \
	COMPONENT_ROOT=$(COMPONENT_ROOT) \
	$(MAKE) -f $(COMPONENT_ROOT)/build3-config/bootstrap.mk nuke

# Don't clean out the make system unless a nuke is requested.
#clean::
#	BS_ROOT=$(BS_ROOT) \
#	COMPONENT_ROOT=$(COMPONENT_ROOT) \
#	$(MAKE) -f $(COMPONENT_ROOT)/build3-config/bootstrap.mk clean

