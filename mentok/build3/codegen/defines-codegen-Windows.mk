ifeq ($(BIN_LEX),)
BIN_LEX=$(BIN_FALSE)
endif

ifeq ($(BIN_YACC),)
BIN_YACC=$(BIN_FALSE)
endif


ifeq ($(FLAGS_LEX),)
FLAGS_LEX=
endif

ifeq ($(FLAGS_YACC),)
FLAGS_YACC=-y -d
endif


