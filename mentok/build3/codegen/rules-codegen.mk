#
# Module rules
#
codegen_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Source Code Generation Module Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_BSCATMAN) $(BS_ROOT)/codegen/codegen.html

codegen_info:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Source Code Generation Module Macro Settings"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) BIN_LEX                                  $(BIN_LEX)"
	@echo "$(BS_INFO_PREFIX) BIN_YACC                                 $(BIN_YACC)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) FLAGS_LEX                                $(FLAGS_LEX)"
	@echo "$(BS_INFO_PREFIX) FLAGS_YACC                               $(FLAGS_YACC)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) LEX_TARGETS                              $(LEX_TARGETS)"
	@echo "$(BS_INFO_PREFIX) YACC_TARGETS                             $(YACC_TARGETS)"
	@echo "$(BS_INFO_PREFIX) TEMPLATEFILE_TARGETS                     $(TEMPLATEFILE_TARGETS)"


codegen_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning code generation targets..."

#
# Template file targets
#
_TEMPLATEFILE_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(sort $(TEMPLATEFILE_TARGETS)))
_TEMPLATEFILE_DEP_GENERATION_TARGETS=$(addprefix _TEMPLATEFILE_DEP_,$(TEMPLATEFILE_TARGETS))
_TEMPLATEFILE_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/codegen_depend_templatefile.mk

_TEMPLATEFILE_BUILDERS=$(addsuffix -builder.sh,$(_TEMPLATEFILE_TARGETS))

ifneq ($(strip $(TEMPLATEFILE_TARGETS)),)
-include $(_TEMPLATEFILE_DEPEND_FILE)

codegen_clean::
	$(BIN_RM) -f $(_TEMPLATEFILE_TARGETS)
	$(BIN_RM) -f $(_TEMPLATEFILE_BUILDERS)

endif

$(_TEMPLATEFILE_DEPEND_FILE): _TEMPLATEFILE_DEP_PREP $(_TEMPLATEFILE_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _TEMPLATEFILE_DEP_PREP $(_TEMPLATEFILE_DEP_GENERATION_TARGETS)



_TEMPLATEFILE_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_TEMPLATEFILE_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_TEMPLATEFILE_DEPEND_FILE))
	echo "##" > $(_TEMPLATEFILE_DEPEND_FILE)
	echo "## Auto generated depend file for TEMPLATEFILE_TARGETS" >> $(_TEMPLATEFILE_DEPEND_FILE)
	echo "##" >> $(_TEMPLATEFILE_DEPEND_FILE)


_TEMPLATEFILE_DEP_%:
_TEMPLATEFILE_DEP_%: _TEMPLATEFILE_OUTPUT=$(BS_ARCH_TARGET_DIR)/$(*)
_TEMPLATEFILE_DEP_%: _TEMPLATEFILE_SRC = $(if $($*_TEMPLATE),$($*_TEMPLATE),$(*).template)
_TEMPLATEFILE_DEP_%: _DEP=$($*_DEP)
_TEMPLATEFILE_DEP_%:
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for TEMPLATEFILE_TARGET $(*) "
	@echo "## TEMPLATEFILE target: $(*) $(_TEMPLATEFILE_OUTPUT)" >> $(_TEMPLATEFILE_DEPEND_FILE)
	@echo "$(_TEMPLATEFILE_OUTPUT): $(_TEMPLATEFILE_SRC)" >> $(_TEMPLATEFILE_DEPEND_FILE)
	@echo "$(_TEMPLATEFILE_OUTPUT): $(_DEP)" >> $(_TEMPLATEFILE_DEPEND_FILE)
	@echo "" >> $(_TEMPLATEFILE_DEPEND_FILE)



$(_TEMPLATEFILE_TARGETS):
$(_TEMPLATEFILE_TARGETS): _T=$(notdir $@)
$(_TEMPLATEFILE_TARGETS): _BUILDER=$(@)-builder.sh
$(_TEMPLATEFILE_TARGETS): _SRC = $(if $($(_T)_TEMPLATE), $($(_T)_TEMPLATE), $(_T).template)
$(_TEMPLATEFILE_TARGETS):
	@echo "$(BS_INFO_PREFIX)  Generating TEMPLATEFILE_TARGET code generation target $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                     :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                     :  $@"
	@echo "$(BS_INFO_PREFIX)      Source File                     :  $(_SRC)"
	@echo "$(BS_INFO_PREFIX)      Template builder                :  $(_BUILDER)"
	@echo
	echo '#!$(BIN_SH)' > $(_BUILDER)
	$(BIN_PRINTF) '$(BIN_ECHO) "' >> $(_BUILDER)
#	$(BIN_CAT) $(_SRC) | $(BIN_SED)  's/"/\\"/g' >> $(_BUILDER)
	$(BIN_SED)  's/"/\\"/g' < $(_SRC) \
		| $(BIN_SED) 's/\$$\([^(]\)/\\$$\1/g' \
		| $(BIN_SED) 's/\$$(\([^)][^)]*\))/$$\1/g' \
		>> $(_BUILDER)
	echo '"' >> $(_BUILDER)
	$(BIN_CHMOD) 755 $(_BUILDER)
	$(_BUILDER) > $@




codegen_templatefile: $(_TEMPLATEFILE_TARGETS)


#
# Lex targets
#
_LEX_YYC_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(sort $(LEX_TARGETS)))
_LEX_DEP_GENERATION_TARGETS=$(addprefix _LEX_DEP_,$(LEX_TARGETS))
_LEX_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/codegen_depend_lex.mk


ifneq ($(strip $(LEX_TARGETS)),)
-include $(_LEX_DEPEND_FILE)

codegen_clean::
	$(BIN_RM) -f $(_LEX_YYC_TARGETS)

endif

$(_LEX_DEPEND_FILE): _LEX_DEP_PREP $(_LEX_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _LEX_DEP_PREP $(_LEX_DEP_GENERATION_TARGETS)



_LEX_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_LEX_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_LEX_DEPEND_FILE))
	echo "##" > $(_LEX_DEPEND_FILE)
	echo "## Auto generated depend file for LEX_TARGETS" >> $(_LEX_DEPEND_FILE)
	echo "##" >> $(_LEX_DEPEND_FILE)


_LEX_DEP_%:
_LEX_DEP_%: _LEX_C=$(BS_ARCH_TARGET_DIR)/$(*)
_LEX_DEP_%: _SRC = $(if $($*_SRC),$($*_SRC),$(*:%.yy.c=%.l))
_LEX_DEP_%: _DEP=$($*_DEP)
_LEX_DEP_%:
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for LEX_TARGET $(*) "
	@echo "## LEX target: $(*) $(_LEX_C)" >> $(_LEX_DEPEND_FILE)
	@echo "$(_LEX_C): $(_SRC)" >> $(_LEX_DEPEND_FILE)
	@echo "$(_LEX_C): $(_DEP)" >> $(_LEX_DEPEND_FILE)
	@echo "" >> $(_LEX_DEPEND_FILE)


$(_LEX_YYC_TARGETS):
$(_LEX_YYC_TARGETS): _T=$(notdir $@)
$(_LEX_YYC_TARGETS): _LEX = $(if $($(_T)_LEX), $($(_T)_LEX), $(BIN_LEX))
$(_LEX_YYC_TARGETS): _LEXFLAGS = $(if $($(_T)_LEXFLAGS), $($(_T)_LEXFLAGS),$(FLAGS_LEX))
$(_LEX_YYC_TARGETS): _SRC = $(if $($(_T)_SRC), $($(_T)_SRC), $(_T:%.yy.c=%.l))
$(_LEX_YYC_TARGETS):
	@echo "$(BS_INFO_PREFIX)  Generating LEX_TARGET code generation target $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                     :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                     :  $@"
	@echo "$(BS_INFO_PREFIX)      Source File                     :  $(_SRC)"
	@echo "$(BS_INFO_PREFIX)      Lex                             :  $(_LEX)"
	@echo "$(BS_INFO_PREFIX)      Lex flags                       :  $(_LEXFLAGS)"
	@echo
	$(_LEX) $(_LEXFLAGS) -o$@  $(_SRC)
	@echo


codegen_lex: $(_LEX_YYC_TARGETS)

#
# Yacc targets
# 
_YACC_TABC_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(sort $(YACC_TARGETS)))
_YACC_TABH_TARGETS=$(patsubst %.tab.c,%.tab.h,$(_YACC_TABC_TARGETS))
_YACC_DEP_GENERATION_TARGETS=$(addprefix _YACC_DEP_,$(YACC_TARGETS))
_YACC_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/codegen_depend_yacc.mk


ifneq ($(strip $(YACC_TARGETS)),)
-include $(_YACC_DEPEND_FILE)

codegen_clean::
	$(BIN_RM) -f $(_YACC_TABC_TARGETS)
	$(BIN_RM) -f $(_YACC_TABH_TARGETS)

endif

$(_YACC_DEPEND_FILE): _YACC_DEP_PREP $(_YACC_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _YACC_DEP_PREP $(_YACC_DEP_GENERATION_TARGETS)



_YACC_DEP_PREP:
	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_YACC_DEPEND_FILE)"
	$(BIN_MKDIR) -p $(dir $(_YACC_DEPEND_FILE))
	echo "##" > $(_YACC_DEPEND_FILE)
	echo "## Auto generated depend file for YACC_TARGETS" >> $(_YACC_DEPEND_FILE)
	echo "##" >> $(_YACC_DEPEND_FILE)


_YACC_DEP_%:
_YACC_DEP_%: _YACC_TABC=$(BS_ARCH_TARGET_DIR)/$(*)
_YACC_DEP_%: _YACC_TABH=$(patsubst %.tab.c,%.tab.h,$(_YACC_TABC))
_YACC_DEP_%: _SRC = $(if $($*_SRC),$($*_SRC),$(*:%.tab.c=%.y))
_YACC_DEP_%: _DEP=$($*_DEP)
_YACC_DEP_%:
	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for YACC_TARGET $(*) "
	@echo "## YACC target: $(*) $(_YACC_TABC)" >> $(_YACC_DEPEND_FILE)
	@echo "$(_YACC_TABC): $(_SRC)" >> $(_YACC_DEPEND_FILE)
	@echo "$(_YACC_TABC): $(_DEP)" >> $(_YACC_DEPEND_FILE)
	@echo "" >> $(_YACC_DEPEND_FILE)
	@echo "$(_YACC_TABH): $(_YACC_TABC)" >> $(_YACC_DEPEND_FILE)
	@echo "" >> $(_YACC_DEPEND_FILE)


$(_YACC_TABC_TARGETS):
$(_YACC_TABC_TARGETS): _YACC_TABC=$@
$(_YACC_TABC_TARGETS): _YACC_TABH=$(patsubst %.tab.c,%.tab.h,$(_YACC_TABC))
$(_YACC_TABC_TARGETS): _T=$(notdir $@)
$(_YACC_TABC_TARGETS): _YACC = $(if $($(_T)_YACC), $($(_T)_YACC), $(BIN_YACC))
$(_YACC_TABC_TARGETS): _YACCFLAGS = $(if $($(_T)_YACCFLAGS), $($(_T)_YACCFLAGS),$(FLAGS_YACC))
$(_YACC_TABC_TARGETS): _SRC = $(if $($(_T)_SRC), $($(_T)_SRC), $(_T:%.tab.c=%.y))
$(_YACC_TABC_TARGETS):
	@echo "$(BS_INFO_PREFIX)  Generating YACC_TARGET code generation target $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                     :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File (tab.c)             :  $(_YACC_TABC)"
	@echo "$(BS_INFO_PREFIX)      Output File (tab.h)             :  $(_YACC_TABH)"
	@echo "$(BS_INFO_PREFIX)      Source File                     :  $(_SRC)"
	@echo "$(BS_INFO_PREFIX)      Yacc                            :  $(_YACC)"
	@echo "$(BS_INFO_PREFIX)      Yacc flags                      :  $(_YACCFLAGS)"
	@echo
	$(_YACC) $(_YACCFLAGS) --output=$@  $(_SRC)
	$(BIN_TOUCH) $(_YACC_TABH)
	@echo


codegen_yacc: $(_YACC_TABC_TARGETS)

#
# JJ (javacc) targets
#

#
# JavaH targets
#


#
# hook module rules into build system
#

info:: codegen_info

man:: codegen_man

pretarget:: codegen_lex
pretarget:: codegen_yacc
pretarget:: codegen_templatefile

target::

posttarget::

clean:: codegen_clean

depends:: _LEX_DEP_PREP $(_LEX_DEP_GENERATION_TARGETS)
depends:: _YACC_DEP_PREP $(_YACC_DEP_GENERATION_TARGETS)

.PHONY:: codegen_info codegen_man


