COMPONENT_ROOT=../..
BS_ROOT=$(COMPONENT_ROOT)/../build3

include $(BS_ROOT)/defines.mk

# This is an old convention. There is no real reason import targets
# cannot be directly included in any individual makefile if desired.
# Note: this is not to say that putting import targets into a seperate
# make file that is included by other Makefiles is a bad thing, on the
# contrary this can be quite usefle depeind on your tree structure since
# the import rules always import things into the COMPONENT_ROOT/
include imports.mk

SUBDIR_TARGETS=

EXPORT_DESC_TARGETS=test_descriptor

DIST_TARGETS=foo

# DISTROOT/<target>/<target_REV>COMPONENT_DISTTAG/<target_PLATFORM>/

foo_FROM=/home/carlalex/eng-home/src/blackbird-trunk/src/bbi/cmi/stdio
#foo_TO=/tmp/foo/bar/some-other-path
foo_DISTROOT=/tmp/testdist
foo_DISTNAME=moof
foo_SCRUB=CVS BUILDTARGETS\*
foo_PLATFORM=$(BS_PLATFORM_NOARCH)
foo_PLATFORMLINKS=fake-platform
foo_REV=3.1
foo_COMMENT=build system 3.0 test component
# Note: this is probably a dumb thing to do in a real make file...
# the two platforms of the one component would clobber
# each other. If you wanted to roll up a multi-platform component
# to dist, you should stage the merge of plarforms with package rules,
# then dist your package dir.
foo_REEXPORT=mhnet mhnet-crossplatform


#COMPONENT_DISTTAG=test_dist_tag



include $(BS_ROOT)/rules.mk

target::
	@$(BIN_ECHO) "import dir for mhnet                : $(call COMPONENT_FUNC_IMPORT_COMPUTE_TARGETDIR,mhnet)"
	@$(BIN_ECHO) "import dir for mhnet-crossplatform  : $(call COMPONENT_FUNC_IMPORT_COMPUTE_TARGETDIR,mhnet-crossplatform)"
	@$(BIN_ECHO) "import dir for blackbird-mh         : $(call COMPONENT_FUNC_IMPORT_COMPUTE_TARGETDIR,blackbird-mh)"
	@$(BIN_ECHO) "import dir for boguscomp1           : $(call COMPONENT_FUNC_IMPORT_COMPUTE_TARGETDIR,boguscomp1)"
	@$(BIN_ECHO) "import dir for boguscomp2           : $(call COMPONENT_FUNC_IMPORT_COMPUTE_TARGETDIR,boguscomp2)"
