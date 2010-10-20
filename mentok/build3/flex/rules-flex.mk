#
# Module rules
#

flex_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Adobe Flex Code Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_BSCATMAN) $(BS_ROOT)/flex/flex.html

flex_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Adobe Flex Code Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLEX_HOME                          $(FLEX_HOME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BIN_FLEX_MXMLC                     $(BIN_FLEX_MXMLC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) FLAGS_MXMLC_SWF                    $(FLAGS_MXMLC_SWF)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) SWF_TARGETS                        $(SWF_TARGETS)")


flex_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning Adobe flex code targets...")


#
# SWF targets
#
_SWF_TARGETS=$(foreach t,$(sort $(SWF_TARGETS)),$(addprefix $(BS_ARCH_TARGET_DIR)/,$(t)))
_SWF_DEP_GENERATION_TARGETS=$(addprefix _SWF_DEP_,$(SWF_TARGETS))
_SWF_DEPEND_FILE=$(BS_ARCH_DEPEND_DIR)/flex_depend_swf.mk


ifneq ($(strip $(SWF_TARGETS)),)
-include $(_SWF_DEPEND_FILE)

flex_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning Adobe Flex code SWF targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_SWF_TARGETS)
endif


$(_SWF_DEPEND_FILE): _SWF_DEP_PREP $(_SWF_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _SWF_DEP_PREP $(_SWF_DEP_GENERATION_TARGETS)



_SWF_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_SWF_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_SWF_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_SWF_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for SWF Adobe FLex targets" >> $(_SWF_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_SWF_DEPEND_FILE)



_SWF_DEP_%:
_SWF_DEP_%: _SWF=$(BS_ARCH_TARGET_DIR)/$(*)
_SWF_DEP_%: _SRC=$(if $($*_SRC),$($*_SRC),$(*:.swf=.mxml))
_SWF_DEP_%: _DEP=$($*_DEP)
_SWF_DEP_%:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for Adobe flex SWF target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## SWF target: $(*) $(_SWF)" >> $(_SWF_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_SWF): $(_SRC)" >> $(_SWF_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_SWF): $(_DEP)" >> $(_SWF_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_SWF_DEPEND_FILE)




$(_SWF_TARGETS):
$(_SWF_TARGETS): _SWF=$@
$(_SWF_TARGETS): _T=$(notdir $@)
$(_SWF_TARGETS): _SRC=$(if $($(_T)_SRC),$($(_T)_SRC),$(_T:.swf=.mxml))
$(_SWF_TARGETS):
$(_SWF_TARGETS): _MXMLC=$(if $($(_T)_MXMLC),$($(_T)_MXMLC),$(BIN_FLEX_MXMLC))
$(_SWF_TARGETS): _MXMLC_FLAGS=$(if $($(_T)_MXMLC_FLAGS),$($(_T)_MXMLC_FLAGS),$(FLAGS_MXMLC_SWF))
$(_SWF_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Building Adobe Flex SWF target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                    :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Source File                    :  $(_SRC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File                    :  $@")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      MXMLC Builder                  :  $(_MXMLC)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      MXMLC FLags                    :  $(_MXMLC_FLAGS)")
	$(BS_CMDPREFIX_VERBOSE1) $(_MXMLC) $(_MXMLC_FLAGS) -output=$@ $(_SRC)



#
# hook module rules into build system
#


info:: flex_info

man::  flex_man

pretarget::

target:: $(_SWF_TARGETS)

posttarget::

clean:: flex_clean

depends:: _SWF_DEP_PREP $(_SWF_DEP_GENERATION_TARGETS)


.PHONY:: flex_info flex_man flex_clean

