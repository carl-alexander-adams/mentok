ifeq ($(BIN_LEX),)
BIN_LEX=/usr/bin/lex
endif

ifeq ($(BIN_YACC),)
#BIN_YACC=/usr/local/bin/bison
BIN_YACC=/usr/bin/yacc
endif


ifeq ($(FLAGS_LEX),)
FLAGS_LEX=
endif

ifeq ($(FLAGS_YACC),)
#FLAGS_YACC=-y -d
FLAGS_YACC=-d
endif


ifeq ($(FLAGS_YACC_OUTPUTFLAG),)
#FLAGS_YACC_OUTPUTFLAG=--output=
FLAGS_YACC_OUTPUTFLAG=-o
endif
