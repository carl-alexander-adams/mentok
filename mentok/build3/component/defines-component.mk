ifeq ($(COMPONENT_DEPOTURL_IMPORT),)
# COMPONENT_DEPOTURL_IMPORT=http://readynas02.mycompany.com/depot/dev
COMPONENT_DEPOTURL_IMPORT=http://readynas02.mycompany.com/depot/dev/pkg
endif

ifeq ($(COMPONENT_DEPOTURL_DIST),)
# COMPONENT_DEPOTURL_DIST=ftp://readynas02.mycompany.com/depot/dev
COMPONENT_DEPOTURL_DIST=ftp://readynas02.mycompany.com/depot/dev/pkg
endif

ifeq ($(COMPONENT_IMPORT_ROOT),)
COMPONENT_IMPORT_ROOT=$(COMPONENT_ROOT)/IMPORTED_COMPONENTS$(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG)))
endif

ifeq ($(COMPONENT_IMPORT_ROOT_ABSPATH),)
COMPONENT_IMPORT_ROOT_ABSPATH=$(COMPONENT_ROOT_ABSPATH)/IMPORTED_COMPONENTS$(if $(strip $(BS_VTAG)),-$(strip $(BS_VTAG)))
endif

ifeq ($(COMPONENT_IMPORT_DIR),)
COMPONENT_IMPORT_DIR=$(COMPONENT_IMPORT_ROOT)/$(BS_PLATFORM_ARCH_FULL)
endif

ifeq ($(COMPONENT_IMPORT_DIR_ABSPATH),)
COMPONENT_IMPORT_DIR_ABSPATH=$(COMPONENT_IMPORT_ROOT_ABSPATH)/$(BS_PLATFORM_ARCH_FULL)
endif
