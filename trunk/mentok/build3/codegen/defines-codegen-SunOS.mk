ifeq ($(BIN_LEX),)
BIN_LEX=/usr/local/bin/flex
endif

ifeq ($(BIN_YACC),)
BIN_YACC=/usr/local/bin/bison
endif


ifeq ($(FLAGS_LEX),)
FLAGS_LEX=
endif

ifeq ($(FLAGS_YACC),)
FLAGS_YACC=-y -d
endif


