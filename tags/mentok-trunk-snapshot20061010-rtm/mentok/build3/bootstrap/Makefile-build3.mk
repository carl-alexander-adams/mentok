#
# Stub Make file to get the new build system on unix hosts.
#
COMPONENT_ROOT=.
BS_ROOT=$(COMPONENT_ROOT)/build3

include $(COMPONENT_ROOT)/build3-config/build3-bootstrap.mk

all: $(BS_ROOT)

$(BS_ROOT): $(COMPONENT_ROOT)/build3-config/build3-bootstrap.mk
	rm -rf $(BS_ROOT)
	cp -R $(BS_BOOTSTRAP_SRC) $(BS_ROOT)

clean:
	rm -rf $(BS_ROOT)
