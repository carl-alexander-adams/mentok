#
# Module rules
#
codegen_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Source Code Generation Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) @$(BIN_BSCATMAN) $(BS_ROOT)/codegen/codegen.html

codegen_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Source Code Generation Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_LEX                                  $(BIN_LEX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_YACC                                 $(BIN_YACC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_LEX                                $(FLAGS_LEX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_YACC                               $(FLAGS_YACC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) LEX_TARGETS                              $(LEX_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) YACC_TARGETS                             $(YACC_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) TEMPLATEFILE_TARGETS                     $(TEMPLATEFILE_TARGETS)")


codegen_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning code generation targets...")

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
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_TEMPLATEFILE_TARGETS)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_TEMPLATEFILE_BUILDERS)

endif

$(_TEMPLATEFILE_DEPEND_FILE): _TEMPLATEFILE_DEP_PREP $(_TEMPLATEFILE_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _TEMPLATEFILE_DEP_PREP $(_TEMPLATEFILE_DEP_GENERATION_TARGETS)



_TEMPLATEFILE_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_TEMPLATEFILE_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_TEMPLATEFILE_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_TEMPLATEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for TEMPLATEFILE_TARGETS" >> $(_TEMPLATEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_TEMPLATEFILE_DEPEND_FILE)


_TEMPLATEFILE_DEP_%:
_TEMPLATEFILE_DEP_%: _TEMPLATEFILE_OUTPUT=$(BS_ARCH_TARGET_DIR)/$(*)
_TEMPLATEFILE_DEP_%: _TEMPLATEFILE_SRC = $(if $($*_TEMPLATE),$($*_TEMPLATE),$(*).template)
_TEMPLATEFILE_DEP_%: _DEP=$($*_DEP)
_TEMPLATEFILE_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for TEMPLATEFILE_TARGET $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## TEMPLATEFILE target: $(*) $(_TEMPLATEFILE_OUTPUT)" >> $(_TEMPLATEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_TEMPLATEFILE_OUTPUT): $(_TEMPLATEFILE_SRC)" >> $(_TEMPLATEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_TEMPLATEFILE_OUTPUT): $(_DEP)" >> $(_TEMPLATEFILE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_TEMPLATEFILE_DEPEND_FILE)



$(_TEMPLATEFILE_TARGETS):
$(_TEMPLATEFILE_TARGETS): _T=$(notdir $@)
$(_TEMPLATEFILE_TARGETS): _BUILDER=$(@)-builder.sh
$(_TEMPLATEFILE_TARGETS): _SRC = $(if $($(_T)_TEMPLATE), $($(_T)_TEMPLATE), $(_T).template)
$(_TEMPLATEFILE_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Generating TEMPLATEFILE_TARGET code generation target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                     :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File                     :  $@")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Source File                     :  $(_SRC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Template builder                :  $(_BUILDER)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) '#!$(BIN_SH)' > $(_BUILDER)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_PRINTF) '$(BIN_ECHO) "' >> $(_BUILDER)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CAT) $(_SRC) | $(BIN_SED)  's/"/\\"/g' >> $(_BUILDER)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_SED)  's/"/\\"/g' < $(_SRC) \
		| $(BIN_SED) 's/\$$\([^(]\)/\\$$\1/g' \
		| $(BIN_SED) 's/\$$(\([^)][^)]*\))/$$\1/g' \
		>> $(_BUILDER)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) '"' >> $(_BUILDER)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CHMOD) 755 $(_BUILDER)
	$(BS_CMDPREFIX_VERBOSE2) $(_BUILDER) > $@




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
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_LEX_YYC_TARGETS)

endif

$(_LEX_DEPEND_FILE): _LEX_DEP_PREP $(_LEX_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _LEX_DEP_PREP $(_LEX_DEP_GENERATION_TARGETS)



_LEX_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_LEX_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_LEX_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_LEX_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for LEX_TARGETS" >> $(_LEX_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_LEX_DEPEND_FILE)


_LEX_DEP_%:
_LEX_DEP_%: _LEX_C=$(BS_ARCH_TARGET_DIR)/$(*)
_LEX_DEP_%: _SRC = $(if $($*_SRC),$($*_SRC),$(*:%.yy.c=%.l))
_LEX_DEP_%: _DEP=$($*_DEP)
_LEX_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for LEX_TARGET $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## LEX target: $(*) $(_LEX_C)" >> $(_LEX_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_LEX_C): $(_SRC)" >> $(_LEX_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_LEX_C): $(_DEP)" >> $(_LEX_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_LEX_DEPEND_FILE)


$(_LEX_YYC_TARGETS):
$(_LEX_YYC_TARGETS): _T=$(notdir $@)
$(_LEX_YYC_TARGETS): _LEX = $(if $($(_T)_LEX), $($(_T)_LEX), $(BIN_LEX))
$(_LEX_YYC_TARGETS): _LEXFLAGS = $(if $($(_T)_LEXFLAGS), $($(_T)_LEXFLAGS),$(FLAGS_LEX))
$(_LEX_YYC_TARGETS): _SRC = $(if $($(_T)_SRC), $($(_T)_SRC), $(_T:%.yy.c=%.l))
$(_LEX_YYC_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Generating LEX_TARGET code generation target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                     :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File                     :  $@")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Source File                     :  $(_SRC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Lex                             :  $(_LEX)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Lex flags                       :  $(_LEXFLAGS)")
	$(BS_CMDPREFIX_VERBOSE2) $(_LEX) $(_LEXFLAGS) -o$@  $(_SRC)


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
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_YACC_TABC_TARGETS)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_YACC_TABH_TARGETS)

endif

$(_YACC_DEPEND_FILE): _YACC_DEP_PREP $(_YACC_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _YACC_DEP_PREP $(_YACC_DEP_GENERATION_TARGETS)



_YACC_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_YACC_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_YACC_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_YACC_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for YACC_TARGETS" >> $(_YACC_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_YACC_DEPEND_FILE)


_YACC_DEP_%:
_YACC_DEP_%: _YACC_TABC=$(BS_ARCH_TARGET_DIR)/$(*)
_YACC_DEP_%: _YACC_TABH=$(patsubst %.tab.c,%.tab.h,$(_YACC_TABC))
_YACC_DEP_%: _SRC = $(if $($*_SRC),$($*_SRC),$(*:%.tab.c=%.y))
_YACC_DEP_%: _DEP=$($*_DEP)
_YACC_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for YACC_TARGET $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## YACC target: $(*) $(_YACC_TABC)" >> $(_YACC_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_YACC_TABC): $(_SRC)" >> $(_YACC_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_YACC_TABC): $(_DEP)" >> $(_YACC_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_YACC_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_YACC_TABH): $(_YACC_TABC)" >> $(_YACC_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_YACC_DEPEND_FILE)


$(_YACC_TABC_TARGETS):
$(_YACC_TABC_TARGETS): _YACC_TABC=$@
$(_YACC_TABC_TARGETS): _YACC_TABH=$(patsubst %.tab.c,%.tab.h,$(_YACC_TABC))
$(_YACC_TABC_TARGETS): _T=$(notdir $@)
$(_YACC_TABC_TARGETS): _YACC = $(if $($(_T)_YACC), $($(_T)_YACC), $(BIN_YACC))
$(_YACC_TABC_TARGETS): _YACCFLAGS = $(if $($(_T)_YACCFLAGS), $($(_T)_YACCFLAGS),$(FLAGS_YACC))
$(_YACC_TABC_TARGETS): _SRC = $(if $($(_T)_SRC), $($(_T)_SRC), $(_T:%.tab.c=%.y))
$(_YACC_TABC_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Generating YACC_TARGET code generation target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                     :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File (tab.c)             :  $(_YACC_TABC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File (tab.h)             :  $(_YACC_TABH)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Source File                     :  $(_SRC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Yacc                            :  $(_YACC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Yacc flags                      :  $(_YACCFLAGS)")
	$(BS_CMDPREFIX_VERBOSE2) $(_YACC) $(_YACCFLAGS) --output=$@  $(_SRC)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_TOUCH) $(_YACC_TABH)


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


