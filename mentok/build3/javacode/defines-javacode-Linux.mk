ifeq ($(JC_JAVAHOME),)
JC_JAVAHOME=/usr/local/java1.4
endif

ifeq ($(BIN_JAVAC),)
BIN_JAVAC=$(JC_JAVAHOME)/bin/javac
endif

ifeq ($(BIN_JAR),)
BIN_JAR=$(JC_JAVAHOME)/bin/jar
endif


ifeq ($(FLAGS_JAVAC),)
FLAGS_JAVAC=
endif

ifeq ($(FLAGS_JAR),)
FLAGS_JAR=
endif
