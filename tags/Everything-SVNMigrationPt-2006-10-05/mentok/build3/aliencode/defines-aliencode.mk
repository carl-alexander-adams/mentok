ifeq ($(AC_BUILD_BIN),)
	AC_BUILD_BIN=$(MAKE)
endif

ifeq ($(AC_CLEAN_BIN),)
	AC_CLEAN_BIN=$(AC_BUILD_BIN)
endif

ifeq ($(AC_CLEAN_FLAGS),)
	AC_CLEAN_FLAGS=clean
endif
