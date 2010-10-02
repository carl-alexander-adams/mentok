#
# Module rules
#
pythoncode_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Python Cocd Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) $(BIN_BSCATMAN) $(BS_ROOT)/pythoncode/pythoncode.html

pythoncode_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Python Code Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PYTHONCODE_PYC_EXEC_STUB      $(PYTHONCODE_PYC_EXEC_STUB)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PYO_TARGETS                   $(PYO_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PYODIR_TARGETS                $(PYODIR_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) PYEXE_TARGETS                 $(PYEXE_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) ")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) _PYO_TARGETS                  $(_PYO_TARGETS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) _PYEXE_PYOS                   $(_PYEXE_PYOS)")

pythoncode_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning python code module targets")



#
# Python Executables
#
_PYEXE_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(PYEXE_TARGETS))
_PYEXE_DEP_GENERATION_TARGETS=$(addprefix _PYEXE_DEP_,$(PYEXE_TARGETS))
_PYEXE_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/pythoncode_depend_python_exe.mk
# Automaticly add the .pyo's to PYO_TARGETS
_PYEXE_PYOS=$(foreach t,$(PYEXE_TARGETS),$(if $($(t)_PYO),$($(t)_PYO),$(t).pyo))
PYO_TARGETS+=$(_PYEXE_PYOS)

ifneq ($(strip $(PYEXE_TARGETS)),)
-include $(_PYEXE_DEPEND_FILE)

pythoncode_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning python code Python Executable targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_PYEXE_TARGETS)
endif


$(_PYTON_EXE_DEPEND_FILE): _PYEXE_DEP_PREP $(_PYEXE_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _PYEXE_DEP_PREP $(_PYEXE_DEP_GENERATION_TARGETS)

_PYEXE_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_PYEXE_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_PYEXE_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_PYEXE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for Python executables" >> $(_PYEXE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_PYEXE_DEPEND_FILE)

_PYEXE_DEP_%:
_PYEXE_DEP_%: _EXE=$(BS_ARCH_TARGET_DIR)/$(*)
_PYEXE_DEP_%: # _SRC=$(if $($*_SRC),$($*_SRC),$(*).py))
_PYEXE_DEP_%: _PYO=$(if $($*_PYO),$($*_PYO),$(BS_ARCH_TARGET_DIR)/$(*).pyo)
_PYEXE_DEP_%: _PYC_EXEC_STUB=$(if $($*_PYC_EXEC_STUB),$($*_PYC_EXEC_STUB),$(PYTHONCODE_PYC_EXEC_STUB))
_PYEXE_DEP_%: _DEP=$($*_DEP)
_PYEXE_DEP_%: 
_PYEXE_DEP_%: 
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for Python executable target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Executable file: $(*) $(_EXE)" >> $(_PYEXE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_EXE): $(_PYO)" >> $(_PYEXE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_EXE): $(_DEP)" >> $(_PYEXE_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_PYEXE_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_PYO): $(_SRC)" >> $(_PYEXE_DEPEND_FILE)


$(_PYEXE_TARGETS): _T=$(notdir $@)
$(_PYEXE_TARGETS): # _SRC=$(if $($(_T)_SRC),$($(_T)_SRC),$(_T).py)
$(_PYEXE_TARGETS): _PYO=$(if $($(_T)_PYO),$($(_T)_PYO),$(BS_ARCH_TARGET_DIR)/$(_T).pyo)
$(_PYEXE_TARGETS): _PYC_EXEC_STUB=$(if $($(_T)_PYC_EXEC_STUB),$($(_T)_PYC_EXEC_STUB),$(PYTHONCODE_PYC_EXEC_STUB))
$(_PYEXE_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Compiling Python executable $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                    :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File                    :  $@")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Input Python Object            :  $(_PYO)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Python exec stub               :  $(_PYC_EXEC_STUB)")
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_CAT) $(_PYC_EXEC_STUB) $(_PYO) > $(@)
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_CHMOD) 755 $(@)



python_pyexe: $(_PYEXE_TARGETS)

#
# Python Object 
#
_PYO_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(sort $(PYO_TARGETS)))
_PYO_DEP_GENERATION_TARGETS=$(addprefix _PYO_DEP_,$(PYO_TARGETS))
#_PYO_DEP_GENERATION_TARGETS=$(subst /,-,$(addprefix _PYO_DEP_,$(PYO_TARGETS)))
_PYO_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/pythoncode_depend_python_pyo.mk

ifneq ($(strip $(PYO_TARGETS)),)
-include $(_PYO_DEPEND_FILE)

pythoncode_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning python code Python Object targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_PYO_TARGETS)
endif


$(_PYTON_PYO_DEPEND_FILE): _PYO_DEP_PREP $(_PYO_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _PYO_DEP_PREP $(_PYO_DEP_GENERATION_TARGETS)

_PYO_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_PYO_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_PYO_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_PYO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for Python objects" >> $(_PYO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_PYO_DEPEND_FILE)

_PYO_DEP_%:
_PYO_DEP_%: _PYO=$(BS_ARCH_TARGET_DIR)/$(*)
_PYO_DEP_%: _SRC=$(if $($*_SRC),$($*_SRC),$(*:.pyo=.py))
_PYO_DEP_%: _DEP=$($*_DEP)
_PYO_DEP_%: 
_PYO_DEP_%: 
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for Python object target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Python Object file: $(*) $(_PYO)" >> $(_PYO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_PYO): $(_SRC)" >> $(_PYO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_PYO): $(_DEP)" >> $(_PYO_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_PYO_DEPEND_FILE)


$(_PYO_TARGETS): _T=$(notdir $@)
$(_PYO_TARGETS): #_T=$(subst ,notdir $@)
$(_PYO_TARGETS): #_DIR=$(dir $@)
$(_PYO_TARGETS): _SRC=$(if $($(_T)_SRC),$($(_T)_SRC),$(_T:.pyo=.py))
$(_PYO_TARGETS): _PYTHON=$(if $($(_T)_PYTHON),$($(_T)_PYTHON),$(BIN_PYTHON))
$(_PYO_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Compiling Python object $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                    :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File                    :  $@")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Source File                    :  $(_SRC)")
	$(BS_CMDPREFIX_VERBOSE1) $(_PYTHON) -OO -c "import py_compile; py_compile.compile('$(_SRC)','$(@)')"


python_pyo: $(_PYO_TARGETS)


#
# Python Object Dir
#
_PYODIR_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/,$(PYODIR_TARGETS))
_PYODIR_FLAG_TARGETS=$(addprefix $(BS_ARCH_TARGET_DIR)/python_flags_pyodir/,$(PYODIR_TARGETS))
_PYODIR_DEP_GENERATION_TARGETS=$(addprefix _PYODIR_DEP_,$(PYODIR_TARGETS))
_PYODIR_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/pythoncode_depend_python_pyodir.mk

ifneq ($(strip $(PYODIR_TARGETS)),)
-include $(_PYODIR_DEPEND_FILE)

pythoncode_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning python code Python Object Directory targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_PYODIR_TARGETS)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_PYODIR_FLAG_TARGETS)
endif


$(_PYTON_PYODIR_DEPEND_FILE): _PYODIR_DEP_PREP $(_PYODIR_DEP_GENERATION_TARGETS)
.INTERMEDIATE:: _PYODIR_DEP_PREP $(_PYODIR_DEP_GENERATION_TARGETS)

_PYODIR_DEP_PREP:
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_PYODIR_DEPEND_FILE)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_PYODIR_DEPEND_FILE))
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_PYODIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for Python object directories" >> $(_PYODIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_PYODIR_DEPEND_FILE)

_PYODIR_DEP_%:
_PYODIR_DEP_%: _PYODIR=$(BS_ARCH_TARGET_DIR)/$(*)
_PYODIR_DEP_%: _FLAG=$(BS_ARCH_TARGET_DIR)/python_flags_pyodir/$(*)
_PYODIR_DEP_%: _SRCS=$(if $($*_SRCS),$($*_SRCS),$(*))
_PYODIR_DEP_%: _DEP=$($*_DEP)
_PYODIR_DEP_%: 
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Rebuilding dependancy for Python object target $(*)")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Python Object directory: $(*) $(_PYODIR)" >> $(_PYODIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_FLAG): $(_SRCS)" >> $(_PYODIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_FLAG): $(_DEP)" >> $(_PYODIR_DEPEND_FILE)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_PYODIR_DEPEND_FILE)


$(_PYODIR_FLAG_TARGETS):
$(_PYODIR_FLAG_TARGETS): _T=$(notdir $@)
$(_PYODIR_FLAG_TARGETS): _FLAG=$@
$(_PYODIR_FLAG_TARGETS): _PYODIR=$(BS_ARCH_TARGET_DIR)/$(_T)
$(_PYODIR_FLAG_TARGETS): _SRCS=$(if $($(_T)_SRCS),$($(_T)_SRCS),$(_T))
$(_PYODIR_FLAG_TARGETS): _PYTHON=$(if $($(_T)_PYTHON),$($(_T)_PYTHON),$(BIN_PYTHON))
$(_PYODIR_FLAG_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Compiling Python pyoect directory $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                    :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Source File(s)/Dir(s)          :  $(_SRCS)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Dir                     :  $(_PYODIR)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Flag File                      :  $(_FLAG)")
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_RM) -rf $(_PYODIR)
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_MKDIR) -p $(_PYODIR)
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_TAR) -cf - $(_SRCS) | ( $(BIN_CD) $(_PYODIR) && $(BIN_TAR) -xf - )
	$(BS_CMDPREFIX_VERBOSE1) $(BIN_CD) $(_PYODIR) && $(_PYTHON) -OO -c "import compileall; compileall.compile_dir('.')"
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_MKDIR) -p $(dir $(_FLAG)) && $(BIN_TOUCH) $(_FLAG)



python_pyodir: $(_PYODIR_FLAG_TARGETS)


#
# hook module rules into build system
#

info:: pythoncode_info

man:: pythoncode_man

depends:: _PYO_DEP_PREP $(_PYO_DEP_GENERATION_TARGETS)
depends:: _PYODIR_DEP_PREP $(_PYODIR_DEP_GENERATION_TARGETS)
depends:: _PYEXE_DEP_PREP $(_PYEXE_DEP_GENERATION_TARGETS)

pretarget::

target:: $(_PYO_TARGETS)
target:: $(_PYODIR_FLAG_TARGETS)
target:: $(_PYEXE_TARGETS)

posttarget::

clean:: pythoncode_clean

nuke::

.PHONY:: pythoncode_info pythoncode_man


