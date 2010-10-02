#
# Module rules
#
doc_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Document Generation Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_BSCATMAN) $(BS_ROOT)/codegen/codegen.html

doc_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Document Generation Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_DOXYGEN                              $(BIN_DOXYGEN)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_DOXYGEN                            $(FLAGS_DOXYGEN)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) DOXYGEN_TARGETS                          $(DOXYGEN_TARGETS)")

doc_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning document generation targets...")


#
# Doxygen targets
#
_DOXYGEN_TARGETS=$(addprefix $(BS_NOARCH_TARGET_DIR)/,$(sort $(DOXYGEN_TARGETS)))
_DOXYGEN_DEP_GENERATION_TARGETS=$(addprefix _DOXYGEN_DEP_,$(DOXYGEN_TARGETS))
_DOXYGEN_DEPEND_FILE=$(BS_NOARCH_TARGET_DIR)/doc_depend_doxygen.mk


ifneq ($(strip $(DOXYGEN_TARGETS)),)
-include $(_DOXYGEN_DEPEND_FILE)

doc_clean::
	$(BIN_RM) -rf $(_DOXYGEN_TARGETS)

endif

$(_DOXYGEN_DEPEND_FILE): _DOXYGEN_DEP_PREP $(_DOXYGEN_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _DOXYGEN_DEP_PREP $(_DOXYGEN_DEP_GENERATION_TARGETS)



_DOXYGEN_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_DOXYGEN_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_DOXYGEN_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_DOXYGEN_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for DOXYGEN_TARGETS" >> $(_DOXYGEN_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_DOXYGEN_DEPEND_FILE)


_DOXYGEN_DEP_%:
_DOXYGEN_DEP_%: _DOXYGEN_OUTPUT_DIR=$(BS_NOARCH_TARGET_DIR)/$(*)
_DOXYGEN_DEP_%: _SRC = $(if $($*_SRC),$($*_SRC),Doxyfile)
_DOXYGEN_DEP_%: _DEP=$($*_DEP)
_DOXYGEN_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for DOXYGEN_TARGET $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## DOXYGEN target: $(*) $(_DOXYGEN_OUTPUT_DIR)" >> $(_DOXYGEN_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_DOXYGEN_OUTPUT_DIR): $(_SRC)" >> $(_DOXYGEN_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_DOXYGEN_OUTPUT_DIR): $(_DEP)" >> $(_DOXYGEN_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_DOXYGEN_DEPEND_FILE)


$(_DOXYGEN_TARGETS):
$(_DOXYGEN_TARGETS): _T=$(notdir $@)
$(_DOXYGEN_TARGETS): _DOXYGEN = $(if $($(_T)_DOXYGEN), $($(_T)_DOXYGEN), $(BIN_DOXYGEN))
$(_DOXYGEN_TARGETS): _DOXYGEN_FLAGS = $(if $($(_T)_DOXYGENFLAGS), $($(_T)_DOXYGENFLAGS),$(FLAGS_DOXYGEN))
$(_DOXYGEN_TARGETS): _SRC=$(if $($(_T)_SRC), $($(_T)_SRC),Doxyfile)
$(_DOXYGEN_TARGETS): _FIXED_SRC = $(BS_NOARCH_TARGET_DIR)/$(notdir $(_SRC).buildsystem-altered.doxyfile)
$(_DOXYGEN_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Generating DOXYGEN_TARGET document generation target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                     :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output DIR                      :  $@")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Source File                     :  $(_SRC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Doxygen                         :  $(_DOXYGEN)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Doxygen flags                   :  $(_DOXYGEN_FLAGS)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -rf $@
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $@
# Doxygen is lame and requires that we massage the input file to put the output where we want.
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_CAT) $(_SRC) | $(BIN_SED) 's/^[\t ]*OUTPUT_DIRECTORY.*//' > $(_FIXED_SRC)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "OUTPUT_DIRECTORY = $@" >> $(_FIXED_SRC)
	$(BS_CMDPREFIX_VERBOSE2) $(_DOXYGEN) $(_DOXYGEN_FLAGS) $(_FIXED_SRC)


doc_doxygen: $(_DOXYGEN_TARGETS)


doc_depends:: _DOXYGEN_DEP_PREP $(_DOXYGEN_DEP_GENERATION_TARGETS)


#
# hook module rules into build system
#

info:: doc_info

man:: doc_man

pretarget::

# target:: doc_doxygen
target::

# posttarget:: doc_doxygen
posttarget::

clean:: doc_clean

depends:: doc_depends

.PHONY:: doc_info doc_man


