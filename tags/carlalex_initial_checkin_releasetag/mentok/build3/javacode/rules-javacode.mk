#
# Module rules
#

javacode_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Java Code Module Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_BSCATMAN) $(BS_ROOT)/javacode/javacode.html

javacode_info:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Java Code Module Macro Settings"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) JC_JAVAHOME                              $(JC_JAVAHOME)"
	@echo "$(BS_INFO_PREFIX) JC_JAVASRCROOT                           $(JC_JAVASRCROOT)"
	@echo "$(BS_INFO_PREFIX) JC_CLASSPATH                             $(JC_CLASSPATH)"
	@echo "$(BS_INFO_PREFIX) JC_CONTROL_JAVAALL                       $(JC_CONTROL_JAVAALL)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) BIN_JAVAC                                $(BIN_JAVAC)"
	@echo "$(BS_INFO_PREFIX) BIN_JAR                                  $(BIN_JAR)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) FLAGS_JAVAC                              $(FLAGS_JAVAC)"
	@echo "$(BS_INFO_PREFIX) FLAGS_JAR                                $(FLAGS_JAR)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) CLASS_TARGETS                            $(CLASS_TARGETS)"
	@echo "$(BS_INFO_PREFIX) JAR_TARGETS                              $(JAR_TARGETS)"


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
	@echo "$(BS_INFO_PREFIX)  cleaning java code jar targets"
	$(BIN_RM) -f $(_JAR_TARGETS)
endif


$(_JAR_DEPEND_FILE): _JAR_DEP_PREP $(_JAR_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _JAR_DEP_PREP $(_JAR_DEP_GENERATION_TARGETS)



_JAR_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_JAR_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_JAR_DEPEND_FILE))
	echo "##" > $(_JAR_DEPEND_FILE)
	echo "## Auto generated depend file for java jar objects" >> $(_JAR_DEPEND_FILE)
	echo "##" >> $(_JAR_DEPEND_FILE)


#_JAR_DEP_%:  XXX - java targets are currently built into src dir
#_JAR_DEP_%: _JAR=$(BS_NOARCH_TARGET_DIR)/$(*)
#_JAR_DEP_%: _CLASSES=$(addprefix $(BS_NOARCH_TARGET_DIR)/,$($*_CLASSES))
_JAR_DEP_%: _JAR=$(*)
_JAR_DEP_%: _CLASSES=$($*_CLASSES)
_JAR_DEP_%: _DIRS=$($*_DIRS)
_JAR_DEP_%: _MANIFEST=$($*_MANIFEST)
_JAR_DEP_%: _DEP=$($*_DEP)
_JAR_DEP_%:
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for java jar target $(*) "
	@echo "## JAR target: $(*) $(_JAR)" >> $(_JAR_DEPEND_FILE)
	@echo "$(_JAR): $(_CLASSES)" >> $(_JAR_DEPEND_FILE)
	@echo "$(_JAR): $(_DIRS)" >> $(_JAR_DEPEND_FILE)
	@echo "$(_JAR): $(_MANIFEST)" >> $(_JAR_DEPEND_FILE)
	@echo "$(_JAR): $(_DEP)" >> $(_JAR_DEPEND_FILE)
	@echo "" >> $(_JAR_DEPEND_FILE)



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
$(_JAR_TARGETS): _JARFLAGS=$(if $($(_T)_JARFLAGS),$($(_T)_JARFLAGS),$(FLAGS_JAR))
$(_JAR_TARGETS):
	@echo
	@echo "$(BS_INFO_PREFIX)  Building Java jar target $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                    :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                    :  $@"
	@echo "$(BS_INFO_PREFIX)      Jar                            :  $(_JAR)"
	@echo "$(BS_INFO_PREFIX)      Jar Flags                      :  $(_JARFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Classes                        :  $(_CLASSES)"
	@echo "$(BS_INFO_PREFIX)      Directories                    :  $(_DIRS)"
	@echo "$(BS_INFO_PREFIX)      Manifest                       :  $(_MANIFEST)"
	$(_JAR) $(_JARFLAGS) $@ $(_MANIFEST) $(_CLASSES) $(_DIRS)

#
# Class targets
#

# XXX - not yet implemented.
# the JAVAALL contrl is really hackish in my opinions since it 
# cricumvents a good dependancy tree.

_CLASS_DEPEND_FILE=$(BS_NOARCH_TARGET_DIR)/javacode_depend_class.mk
# XXX - java code is currently built into the src dir.
#_CLASS_TARGETS=$(addprefix $(BS_NOARCH_TARGET_DIR)/,$(sort $(CLASS_TARGETS)))
_CLASS_TARGETS=$(sort $(CLASS_TARGETS))
_CLASS_DEP_GENERATION_TARGETS=$(addprefix _CLASS_DEP_,$(CLASS_TARGETS))


ifneq ($(strip $(CLASS_TARGETS)),)
-include $(_CLASS_DEPEND_FILE)

javacode_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning java code Class targets"
	$(BIN_RM) -f $(_CLASS_TARGETS)
endif


$(_CLASS_DEPEND_FILE): _CLASS_DEP_PREP $(_CLASS_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _CLASS_DEP_PREP $(_CLASS_DEP_GENERATION_TARGETS)

_CLASS_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_CLASS_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_CLASS_DEPEND_FILE))
	echo "##" > $(_CLASS_DEPEND_FILE)
	echo "## Auto generated depend file for C objects" >> $(_CLASS_DEPEND_FILE)
	echo "##" >> $(_CLASS_DEPEND_FILE)



#_CLASS_DEP_%:  XXX - java targets are currently built into src dir
#_CLASS_DEP_%: _CLASS=$(BS_NOARCH_TARGET_DIR)/$(*)
_CLASS_DEP_%: _CLASS=$(*)
_CLASS_DEP_%: _SRC=$(if $($*_SRC),$($*_SRC),$(*:%.class=%.java))
_CLASS_DEP_%: _DEP=$($*_DEP)
_CLASS_DEP_%: 
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for Class target $(*) "
	@echo "## Class file: $(*) $(_CLASS)" >> $(_CLASS_DEPEND_FILE)
	@echo "$(_CLASS): $(_SRC)" >> $(_CLASS_DEPEND_FILE)
	@echo "$(_CLASS): $(_DEP)" >> $(_CLASS_DEPEND_FILE)
	@echo "" >> $(_CLASS_DEPEND_FILE)




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
	@echo
	@echo "$(BS_INFO_PREFIX)  compiling Class object $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                    :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                    :  $@"
	@echo "$(BS_INFO_PREFIX)      Source File                    :  $(_SRC)"
	@echo "$(BS_INFO_PREFIX)      Compiler                       :  $(_JAVAC)"
	@echo "$(BS_INFO_PREFIX)      Compiler Flags                 :  $(_JAVACFLAGS)"
	@echo "$(BS_INFO_PREFIX)      Java Source Root               :  $(_JAVASRCROOT)"
	@echo "$(BS_INFO_PREFIX)      Java Class Path                :  $(_CLASSPATH)"
	@echo
	$(JAVAC) -classpath $(JAVACLASSPATH) $(JFLAGS) -d $(JAVADIR) *.java
	$(BIN_JAVAC) -classpath $(_CLASSPATH) $(_JAVACFLAGS) -d $(_JAVASRCROOT) $(_SRC)




#
# hook module rules into build system
#

info:: javacode_info

man:: javacode_man

pretarget::

target:: $(_CLASS_TARGETS)
target:: $(_JAR_TARGETS)

posttarget::

clean:: javacode_clean

depends:: _CLASS_DEP_PREP $(_CLASS_DEP_GENERATION_TARGETS)
depends:: _JAR_DEP_PREP $(_JAR_DEP_GENERATION_TARGETS)

.PHONY:: javacode_info javacode_man javacode_clean


