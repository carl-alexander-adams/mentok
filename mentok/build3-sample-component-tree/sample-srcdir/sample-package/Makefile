COMPONENT_ROOT=../..
BS_ROOT=$(COMPONENT_ROOT)/../build3

include $(BS_ROOT)/defines.mk


#
# The resulting package isn't really useful, just shows how you can use the target options
#

moof_pkg_target=moof-tar1.tar.gz

PACKAGE_TARGETS=foo-pkg1 $(moof_pkg_target)
TARGZ_TARGETS=moof-tar1


foo-pkg1_FROM=$(COMPONENT_ROOT)/sample-srcdir
#foo-pkg1_DEST=$(PROJECT)
foo-pkg1_SCRUB=CVS

moof-tar1_FILES=foo-pkg1
moof-tar1_CWD=$(PACKAGE_TARGET_DIR)

#$(moof_pkg_target)_FROM=$(BS_ARCH_TARGET_DIR)/moof-tar1.tar.gz # This is the default
$(moof_pkg_target)_DEST=moof-tarball-package-dir/


include $(BS_ROOT)/rules.mk
