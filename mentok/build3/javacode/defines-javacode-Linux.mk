ifeq ($(JC_JAVAHOME),)
JC_JAVAHOME=/usr/lib/jvm/jre-1.6.0-openjdk.x86_64
endif

# Actually for JNI, so these are args to $(CC)
ifeq ($(JC_JAVAINC),)
JC_JAVAINC=-I$(JC_JAVAHOME)/include -I$(JC_JAVAHOME)/include/linux
endif

ifeq ($(BIN_JAVA),)
BIN_JAVA=$(JC_JAVAHOME)/bin/java
endif

ifeq ($(BIN_JAVAC),)
BIN_JAVAC=$(JC_JAVAHOME)/bin/javac
endif

ifeq ($(BIN_JAR),)
BIN_JAR=$(JC_JAVAHOME)/bin/jar
endif

ifeq ($(BIN_JARSIGNER),)
BIN_JARSIGNER=$(JC_JAVAHOME)/bin/jarsigner
endif

ifeq ($(BIN_JAVACC),)
BIN_JAVACC=$(JC_JAVAHOME)/bin/javacc
endif


ifeq ($(FLAGS_JAVAC),)
FLAGS_JAVAC=
endif

ifeq ($(FLAGS_JAR),)
FLAGS_JAR=cf
endif

ifeq ($(FLAGS_JAR_MANIFEST),)
FLAGS_JAR_MANIFEST=m
endif

ifeq ($(FLAGS_JAVACC),)
FLAGS_JAVACC=
endif


ifeq ($(JC_JAVACCZIP),)
JC_JAVACCZIP=/usr/local/javacc/JavaCC.zip
endif
