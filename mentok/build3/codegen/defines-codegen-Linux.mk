ifeq ($(BIN_LEX),)
BIN_LEX=/usr/bin/flex
endif

ifeq ($(BIN_YACC),)
BIN_YACC=/usr/bin/bison
endif


ifeq ($(FLAGS_LEX),)
FLAGS_LEX=
endif

ifeq ($(FLAGS_YACC),)
FLAGS_YACC=-y -d
endif


ifeq ($(FLAGS_YACC_OUTPUTFLAG),)
FLAGS_YACC_OUTPUTFLAG=--output=
endif
