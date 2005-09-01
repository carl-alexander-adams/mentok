#
# Module rules
#

javacode_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Java Code Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_BSCATMAN) $(BS_ROOT)/javacode/javacode.html

javacode_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Java Code Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) JC_JAVAHOME                              $(JC_JAVAHOME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) JC_JAVASRCROOT                           $(JC_JAVASRCROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) JC_CLASSPATH                             $(JC_CLASSPATH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) JC_CONTROL_JAVAALL                       $(JC_CONTROL_JAVAALL)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_JAVA                                 $(BIN_JAVA)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_JAVAC                                $(BIN_JAVAC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_JAR                                  $(BIN_JAR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_JAVAC                              $(FLAGS_JAVAC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_JAR                                $(FLAGS_JAR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_JAR_MANIFEST                       $(FLAGS_JAR_MANIFEST)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) CLASS_TARGETS                            $(CLASS_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) JAR_TARGETS                              $(JAR_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) JJ_TARGETS                               $(JJ_TARGETS)")


#
# Set up env for java tools
#
CLASSPATH=$(JC_CLASSPATH)
export CLASSPATH

#
# Jar targets
#
# XXX - java code is currently built into the src dir.
#_JAR_TARGETS=$(addprefix $(BS_NOARCH_TARGET_DIR)/,$(sort $(JAR_TARGETS)))
_JAR_TARGETS=$(sort $(JAR_TARGETS))
_JAR_DEP_GENERATION_TARGETS=$(addprefix _JAR_DEP_,$(JAR_TARGETS))
_JAR_DEPEND_FILE=$(BS_NOARCH_TARGET_DIR)/javacode_depend_jar.mk

_JAR_CLASS_TARGETS=$(foreach t,$(JAR_TARGETS),$(if $($(t)_CLASSES),$($(t)_CLASSES)))
CLASS_TARGETS+=$(_JAR_CLASS_TARGETS)


ifneq ($(strip $(JAR_TARGETS)),)
-include $(_JAR_DEPEND_FILE)

javacode_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning java code jar targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_JAR_TARGETS)
endif


$(_JAR_DEPEND_FILE): _JAR_DEP_PREP $(_JAR_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _JAR_DEP_PREP $(_JAR_DEP_GENERATION_TARGETS)



_JAR_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_JAR_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_JAR_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_JAR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for java jar objects" >> $(_JAR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_JAR_DEPEND_FILE)


#_JAR_DEP_%:  XXX - java targets are currently built into src dir
#_JAR_DEP_%: _JAR=$(BS_NOARCH_TARGET_DIR)/$(*)
#_JAR_DEP_%: _CLASSES=$(addprefix $(BS_NOARCH_TARGET_DIR)/,$($*_CLASSES))
_JAR_DEP_%: _JAR=$(*)
_JAR_DEP_%: _CLASSES=$($*_CLASSES)
_JAR_DEP_%: _DIRS=$($*_DIRS)
_JAR_DEP_%: _MANIFEST=$($*_MANIFEST)
_JAR_DEP_%: _DEP=$($*_DEP)
_JAR_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for java jar target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## JAR target: $(*) $(_JAR)" >> $(_JAR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_JAR): $(_CLASSES)" >> $(_JAR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_JAR): $(_DIRS)" >> $(_JAR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_JAR): $(_MANIFEST)" >> $(_JAR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_JAR): $(_DEP)" >> $(_JAR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_JAR_DEPEND_FILE)



#$(_JAR_TARGETS): XXX java files are built in src dir for now
#$(_JAR_TARGETS): _CLASSES=$(addprefix $(BS_NOARCH_TARGET_DIR)/,$($(_T)_CLASSES))
$(_JAR_TARGETS):
$(_JAR_TARGETS): _T=$(notdir $@)
$(_JAR_TARGETS):
$(_JAR_TARGETS): _JAR=$(if $($(_T)_JAR),$($(_T)_JAR),$(BIN_JAR))
$(_JAR_TARGETS): _CLASSES=$($(_T)_CLASSES)
$(_JAR_TARGETS): _DIRS=$($(_T)_DIRS)
$(_JAR_TARGETS): _MANIFEST=$($(_T)_MANIFEST)
$(_JAR_TARGETS):
$(_JAR_TARGETS): _T_JARFLAGS=$(if $($(_T)_JARFLAGS),$($(_T)_JARFLAGS),$(FLAGS_JAR))
$(_JAR_TARGETS): _T_JARFLAGS_MANIFEST=$(if $($(_T)_JARFLAGS_MANIFEST),$($(_T)_JARFLAGS_MANIFEST),$(FLAGS_JAR_MANIFEST))
$(_JAR_TARGETS):
$(_JAR_TARGETS): _JARFLAGS_MANIFEST=$(if $(_MANIFEST),$(_T_JARFLAGS_MANIFEST))
$(_JAR_TARGETS): _JARFLAGS=$(_T_JARFLAGS)$(_JARFLAGS_MANIFEST)
$(_JAR_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Building Java jar target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                    :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File                    :  $@")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Jar                            :  $(_JAR)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Jar Flags (base)               :  $(_T_JARFLAGS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Jar Flags (manifest)           :  $(_T_JARFLAGS_MANIFEST)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Jar Flags (current build)      :  $(_JARFLAGS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Classes                        :  $(_CLASSES)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Directories                    :  $(_DIRS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Manifest                       :  $(_MANIFEST)")
	$(BS_CMDPREFIX_VERBOSE2) $(_JAR) $(_JARFLAGS) $@ $(_MANIFEST) $(_CLASSES) $(_DIRS)

#
# Class targets
#

_CLASS_DEPEND_FILE=$(BS_NOARCH_TARGET_DIR)/javacode_depend_class.mk
# XXX - java code is currently built into the src dir.
#_CLASS_TARGETS=$(addprefix $(BS_NOARCH_TARGET_DIR)/,$(sort $(CLASS_TARGETS)))
_CLASS_TARGETS=$(sort $(CLASS_TARGETS))
_CLASS_DEP_GENERATION_TARGETS=$(addprefix _CLASS_DEP_,$(CLASS_TARGETS))


ifneq ($(strip $(CLASS_TARGETS)),)
-include $(_CLASS_DEPEND_FILE)

javacode_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning java code Class targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_CLASS_TARGETS)
endif


$(_CLASS_DEPEND_FILE): _CLASS_DEP_PREP $(_CLASS_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _CLASS_DEP_PREP $(_CLASS_DEP_GENERATION_TARGETS)

_CLASS_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_CLASS_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_CLASS_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_CLASS_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for C objects" >> $(_CLASS_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_CLASS_DEPEND_FILE)



#_CLASS_DEP_%:  XXX - java targets are currently built into src dir
#_CLASS_DEP_%: _CLASS=$(BS_NOARCH_TARGET_DIR)/$(*)
_CLASS_DEP_%: _CLASS=$(*)
_CLASS_DEP_%: _SRC=$(if $($*_SRC),$($*_SRC),$(*:%.class=%.java))
_CLASS_DEP_%: _DEP=$($*_DEP)
_CLASS_DEP_%: 
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for Class target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Class file: $(*) $(_CLASS)" >> $(_CLASS_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_CLASS): $(_SRC)" >> $(_CLASS_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_CLASS): $(_DEP)" >> $(_CLASS_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_CLASS_DEPEND_FILE)




# XXX - common practice among java coders is to compile all java
# src in one command. I dislike this since it inhibits the ability to
# have per target flags. so, we DELIBRIATLY only do it if a control
# tells us to.
$(_CLASS_TARGETS): _T=$(notdir $@)
$(_CLASS_TARGETS): _SRC=$(if $($(_T)_SRC),$($(_T)_SRC),$(_T:%.class=%.java))
$(_CLASS_TARGETS): 
$(_CLASS_TARGETS): _JAVAC       = $(if $($(_T)_JAVAC),$($(_T)_JAVAC),$(BIN_JAVAC))
$(_CLASS_TARGETS): _JAVACFLAGS  = $(if $($(_T)_JAVACFLAGS),$($(_T)_JAVACFLAGS),$(FLAGS_JAVAC))
$(_CLASS_TARGETS): _JAVASRCROOT = $(if $($(_T)_JAVASRCROOT),$($(_T)_JAVASRCROOT),$(JC_JAVASRCROOT))
$(_CLASS_TARGETS): _CLASSPATH   = $(if $($(_T)_CLASSPATH),$($(_T)_CLASSPATH),$(JC_CLASSPATH))
$(_CLASS_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Compiling Class object $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                    :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File                    :  $@")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Source File                    :  $(_SRC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Compiler                       :  $(_JAVAC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Compiler Flags                 :  $(_JAVACFLAGS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Java Source Root               :  $(_JAVASRCROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Java Class Path                :  $(_CLASSPATH)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_JAVAC) -classpath $(_CLASSPATH) $(_JAVACFLAGS) -d $(_JAVASRCROOT) $(_SRC)


#
# JJ targets
#

_JJ_DEPEND_FILE=$(BS_NOARCH_TARGET_DIR)/javacode_depend_jj.mk
# XXX - java code is currently built into the src dir.
#_JJ_TARGETS=$(addprefix $(BS_NOARCH_TARGET_DIR)/,$(sort $(JJ_TARGETS)))
_JJ_TARGETS=$(sort $(JJ_TARGETS))
_JJ_DEP_GENERATION_TARGETS=$(addprefix _JJ_DEP_,$(JJ_TARGETS))


ifneq ($(strip $(JJ_TARGETS)),)
-include $(_JJ_DEPEND_FILE)

javacode_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning java code Class targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_JJ_TARGETS)
endif


$(_JJ_DEPEND_FILE): _JJ_DEP_PREP $(_JJ_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _JJ_DEP_PREP $(_JJ_DEP_GENERATION_TARGETS)

_JJ_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_JJ_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_JJ_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_JJ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for generated java" >> $(_JJ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_JJ_DEPEND_FILE)



#_JJ_DEP_%:  XXX - java targets are currently built into src dir
#_JJ_DEP_%: _JJ=$(BS_NOARCH_TARGET_DIR)/$(*)
_JJ_DEP_%: _JJ=$(*)
_JJ_DEP_%: _SRC=$(if $($*_SRC),$($*_SRC),$(*:%.java=%.jj))
_JJ_DEP_%: _DEP=$($*_DEP)
_JJ_DEP_%: 
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for JJ target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Generated java file: $(*) $(_JJ)" >> $(_JJ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_JJ): $(_SRC)" >> $(_JJ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_JJ): $(_DEP)" >> $(_JJ_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_JJ_DEPEND_FILE)




# XXX - common practice among java coders is to compile all java
# src in one command. I dislike this since it inhibits the ability to
# have per target flags. so, we DELIBRIATLY only do it if a control
# tells us to.
$(_JJ_TARGETS): _T=$(notdir $@)
$(_JJ_TARGETS): _SRC=$(if $($(_T)_SRC),$($(_T)_SRC),$(_T:%.java=%.jj))
$(_JJ_TARGETS): 
$(_JJ_TARGETS): _JAVACC       = $(if $($(_T)_JAVACC),$($(_T)_JAVACC),$(BIN_JAVACC))
$(_JJ_TARGETS): _JAVACCFLAGS  = $(if $($(_T)_JAVACCFLAGS),$($(_T)_JAVACCFLAGS),$(FLAGS_JAVACC))
$(_JJ_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Compiling Class object $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                    :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File                    :  $@")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Source File                    :  $(_SRC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Compiler                       :  $(_JAVACC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Compiler Flags                 :  $(_JAVACCFLAGS)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_JAVACC) $(_JAVACCFLAGS) $(_SRC)


#
# JAVAALL targets
#

# XXX - this actually always forces a build, because we can't do dependencies
# Probably the worst possible way to do this, but it works...

ifeq ($(strip $(JC_CONTROL_JAVAALL)),1)
javacode_javaall:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Compiling ALL java source files")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Compiler                       :  $(BIN_JAVAC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Compiler Flags                 :  $(FLAGS_JAVAC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Java Source Root               :  $(JC_JAVASRCROOT)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Java Class Path                :  $(JC_CLASSPATH)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_JAVAC) -classpath $(JC_CLASSPATH) $(FLAGS_JAVAC) -d $(JC_JAVASRCROOT) *.java
endif

#
# hook module rules into build system
#

info:: javacode_info

man:: javacode_man

pretarget:: $(_JJ_TARGETS)

target:: $(_CLASS_TARGETS)
target:: $(_JAR_TARGETS)

ifeq ($(strip $(JC_CONTROL_JAVAALL)),1)
target:: javacode_javaall
endif

posttarget::

clean:: javacode_clean

depends:: _CLASS_DEP_PREP $(_CLASS_DEP_GENERATION_TARGETS)
depends:: _JAR_DEP_PREP $(_JAR_DEP_GENERATION_TARGETS)
depends:: _JJ_DEP_PREP $(_JJ_DEP_GENERATION_TARGETS)

.PHONY:: javacode_info javacode_man javacode_clean javacode_javaall


