COMPONENT_ROOT=.
BS_ROOT=$(COMPONENT_ROOT)/../build3

include $(BS_ROOT)/defines.mk

SUBDIR_TARGETS=

#
# For pushing self to binary component repository ('dist' area)
#
PACKAGE_TARGETS=build3-dist-package
DIST_TARGETS=$(PROJECT)

build3-dist-package_FROM=$(BS_ROOT)
build3-dist-package_DEST=build3-dist-package
build3-dist-package_SCRUB=CVS

$(PROJECT)_PLATFORM=$(BS_PLATFORM_NOARCH)
$(PROJECT)_PLATFORMLINKS=$(BS_PLATFORM_NOARCH)
#$(PROJECT)_FROM=$(call PACKAGE_FUNC_GET_PACKAGE_REALTARGET,build3-dist-package)
$(PROJECT)_FROM=$(PACKAGE_TARGET_DIR)/build3-dist-package

#
# For pushing self as open source tarball.
#

PACKAGE_TARGETS += \
	build3-publish-package1 \
	build3-publish-package2 \
	build3-publish-package3 \
	build3-publish-package4 \
	build3-publish-package5 \
	build3-publish-package6 \

publish_package_dest=build3-$(BS_DATE_YEAR)$(BS_DATE_MONTH)$(BS_DATE_DAY)
publish_package_scrub=CVS

build3-publish-package1_FROM=$(COMPONENT_ROOT)/../build3
build3-publish-package1_DEST=$(publish_package_dest)/build3
build3-publish-package1_SCRUB=$(publish_package_scrub)

build3-publish-package2_FROM=$(COMPONENT_ROOT)/../build3-sample-component-tree
build3-publish-package2_DEST=$(publish_package_dest)/build3-sample-component-tree
build3-publish-package2_SCRUB=$(publish_package_scrub)

build3-publish-package3_FROM=$(COMPONENT_ROOT)/../README
build3-publish-package3_DEST=$(publish_package_dest)/README
build3-publish-package3_SCRUB=$(publish_package_scrub)

build3-publish-package4_FROM=$(COMPONENT_ROOT)/../LICENSE
build3-publish-package4_DEST=$(publish_package_dest)/LICENSE
build3-publish-package4_SCRUB=$(publish_package_scrub)

build3-publish-package5_FROM=./Makefile
build3-publish-package5_DEST=$(publish_package_dest)/src/Makefile
build3-publish-package5_SCRUB=$(publish_package_scrub)

build3-publish-package6_FROM=./build3-config
build3-publish-package6_DEST=$(publish_package_dest)/src/build3-config
build3-publish-package6_SCRUB=$(publish_package_scrub)



#build3_publish_tarballname = build3-$(BS_DATE_YEAR)$(BS_DATE_MONTH)$(BS_DATE_DAY)
build3_publish_tarballname = $(publish_package_dest)
TARGZ_TARGETS += $(build3_publish_tarballname)
$(build3_publish_tarballname)_CWD = $(PACKAGE_TARGET_DIR)
$(build3_publish_tarballname)_FILES = \
	$(build3-publish-package1_DEST) \
	$(build3-publish-package2_DEST) \
	$(build3-publish-package3_DEST) \
	$(build3-publish-package4_DEST) \
	$(build3-publish-package5_DEST) \
	$(build3-publish-package6_DEST)

include $(BS_ROOT)/rules.mk
