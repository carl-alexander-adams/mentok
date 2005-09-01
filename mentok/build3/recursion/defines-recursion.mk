ifeq ($(BS_VERBOSE),3)
RECURSION_MAKE_FLAGS=
else
ifeq ($(BS_VERBOSE),2)
RECURSION_MAKE_FLAGS=
else
ifeq ($(BS_VERBOSE),1)
RECURSION_MAKE_FLAGS=
else
# BS_VERBOSE == 0
RECURSION_MAKE_FLAGS= --no-print-directory
endif
endif
endif
