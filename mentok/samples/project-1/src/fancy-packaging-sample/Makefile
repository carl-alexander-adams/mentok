COMPONENT_ROOT=../..
BS_ROOT=$(COMPONENT_ROOT)/../build3

include $(BS_ROOT)/defines.mk


#
# The resulting package isn't really useful, just shows how you can use the target options
#

moof_pkg_target=moof-tar1.tar.gz

PACKAGEFILE_TARGETS=pkgfile1 pkgfile2 # $(moof_pkg_target)
PACKAGEDIR_TARGETS=pkgdir1 pkgdir2 pkgdir2overlay
#TARGZ_TARGETS=moof-tar1



# pkgfile1_FROM= /* default */
# pkgfile1_DEST= /* default */
# pkgfile1_PLATFORM= /* default */


pkgfile2_FROM=pkgfile2
# pkgfile2_DEST= /* default */
# pkgfile2_PLATFORM= /* default */

# pkgdir1_FROM= /* default */
# pkgdir1_DEST= /* default */
# pkgdir1_PLATFORM= /* default */
pkgdir1_SCRUB=CVS

pkgdir2_FROM=pkgdir2
# pkgdir2_DEST= /* default */
# pkgdir2_PLATFORM= /* default */
# pkgdir2_SCRUB= /* default */

pkgdir2overlay_FROM=pkgdir2overlay
pkgdir2overlay_DEST=pkgdir2
# pkgdir2overlay_PLATFORM= /* default */
pkgdir2overlay_SCRUB=CVS


foo-pkg1_FROM=$(COMPONENT_ROOT)/sample-srcdir
#foo-pkg1_DEST=$(PROJECT)
foo-pkg1_SCRUB=CVS

moof-tar1_FILES=foo-pkg1
moof-tar1_CWD=$(PACKAGE_TARGET_DIR)

#$(moof_pkg_target)_FROM=$(BS_ARCH_TARGET_DIR)/moof-tar1.tar.gz # This is the default
$(moof_pkg_target)_DEST=moof-tarball-package-dir/


include $(BS_ROOT)/rules.mk

#
# some dummy custom rules to create targets to package
# 

target:: $(BS_ARCH_TARGET_DIR)/pkgfile1
target:: $(BS_ARCH_TARGET_DIR)/pkgdir1

$(BS_ARCH_TARGET_DIR)/pkgfile1:
	$(BIN_RM) -f $(@)
	$(BIN_CP) pkgfile1 $(@)

$(BS_ARCH_TARGET_DIR)/pkgdir1:
	$(BIN_RM) -rf $(@)
	$(BIN_CP) -r pkgdir1 $(@)
