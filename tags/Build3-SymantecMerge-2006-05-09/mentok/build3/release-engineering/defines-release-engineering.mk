ifneq ($(DISTTAG),)
COMPONENT_DISTTAG=$(DISTTAG)
endif

ifneq ($(STRIP),)
NC_CONTROL_STRIP=$(STRIP)
endif

ifneq ($(DEBUG),)
NC_CONTROL_DEBUG=$(DEBUG)
endif

