ifeq ($(FLEX_HOME),)
FLEX_HOME=/usr/local/AdobeFlex-3.5
endif

ifeq ($(BIN_FLEX_MXMLC),)
BIN_FLEX_MXMLC=$(FLEX_HOME)/bin/mxmlc
endif

ifeq ($(FLAGS_MXMLC_SWF),)
FLAGS_MXMLC_SWF+=\
	-use-network=true \
	-incremental=false \
	-optimize=true
endif
