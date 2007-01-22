#
# Makefile to bootstrap the build system. Obviously, this cannot
# depend on rules inside the buildsystem. This Makefile
# expects to be called from the top level makefile, but that the
# top level make process will not do a chdir before calling this
# makefile, so that the curren working directory will be
# the $(COMPONENT_ROOT). All macros in this file are 
# defined (or not) accordingly.
#

# This would normally point to an absolute path - A shared file
# system with reference copies of the build system, a svn 
# repository path, etc.
# /Sample-Binary-Component-Repository/Build3/version-43/noarch
BS_BOOTSTRAP_SRC=../../build3


# These should be set by the caller.
# COMPONENT_ROOT=.
# BS_ROOT=$(COMPONENT_ROOT)/build3



#
# The actual rules to bootstrap the build system.
#

all: $(BS_ROOT)

$(BS_ROOT): $(BS_BOOTSTRAP_SRC)
	rm -rf $(BS_ROOT)
	cp -R $(BS_BOOTSTRAP_SRC) $(BS_ROOT)

clean:
	rm -rf $(BS_ROOT)

nuke: clean
