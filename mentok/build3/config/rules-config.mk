#
# Module rules
#
config_man:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Config Module Manual")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	$(BS_CMDPREFIX_VERBOSE3) @$(BIN_BSCATMAN) $(BS_ROOT)/config/config.html

config_info:
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Build System Config Module Macro Settings")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) --------------------------------------------------")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_NAME                          $(BUILDSTAMP_NAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_COMMENT                       $(BUILDSTAMP_COMMENT)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_DATE_YEAR                     $(BUILDSTAMP_DATE_YEAR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_DATE_MONTH                    $(BUILDSTAMP_DATE_MONTH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_DATE_DAY                      $(BUILDSTAMP_DATE_DAY)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_DATE_HOUR                     $(BUILDSTAMP_DATE_HOUR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_DATE_MINUTE                   $(BUILDSTAMP_DATE_MINUTE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_DATE_SECOND                   $(BUILDSTAMP_DATE_SECOND)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_DATE_STRING                   $(BUILDSTAMP_DATE_STRING)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_REVISION_MAJOR                $(BUILDSTAMP_REVISION_MAJOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_REVISION_MINOR                $(BUILDSTAMP_REVISION_MINOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_REVISION_PATCH                $(BUILDSTAMP_REVISION_PATCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_REVISION_BUILD                $(BUILDSTAMP_REVISION_BUILD)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_REVISION_SRCVER               $(BUILDSTAMP_REVISION_SRCVER)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_REVISION_STRING               $(BUILDSTAMP_REVISION_STRING)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_USERNAME                      $(BUILDSTAMP_USERNAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_HOSTNAME                      $(BUILDSTAMP_HOSTNAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_OS_NAME                       $(BUILDSTAMP_OS_NAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_OS_REVMAJOR                   $(BUILDSTAMP_OS_REVMAJOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_OS_REVMINOR                   $(BUILDSTAMP_OS_REVMINOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_OS_REVPATCH                   $(BUILDSTAMP_OS_REVPATCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_OS_RUNTIMENAME                $(BUILDSTAMP_OS_RUNTIMENAME)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_OS_RUNTIMEREVMAJOR            $(BUILDSTAMP_OS_RUNTIMEREVMAJOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_OS_RUNTIMEREVMINOR            $(BUILDSTAMP_OS_RUNTIMEREVMINOR)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_OS_RUNTIMEREVPATCH            $(BUILDSTAMP_OS_RUNTIMEREVPATCH)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_MACHINETYPE                   $(BUILDSTAMP_MACHINETYPE)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_MACHINEPROC                   $(BUILDSTAMP_MACHINEPROC)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_MACHINEINSTSET                $(BUILDSTAMP_MACHINEINSTSET)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX)")
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) BUILDSTAMP_TARGETS                       $(BUILDSTAMP_TARGETS)")

config_clean::

#
# Build stamp generation
#

_BUILDSTAMP_H_TARGETS=$(addsuffix .h,$(addprefix $(BS_ARCH_TARGET_DIR)/,$(BUILDSTAMP_TARGETS)))
_BUILDSTAMP_C_TARGETS=$(_BUILDSTAMP_H_TARGETS:.h=.c)
# _BUILDSTAMP_MK_TARGETS=$(_BUILDSTAMP_H_TARGETS:.h=.mk)

#
# Build stamps don't depend on anything.
#
#_BUILDSTAMP_DEP_GENERATION_TARGETS=$(addprefix _BUILDSTAMP_DEP_,$(BUILDSTAMP_TARGETS))
#_BUILDSTAMP_DEPEND_FILE=$(BS_ARCH_DEPEND_DIR)/config_depend_buildstamp.mk


ifneq ($(strip $(BUILDSTAMP_TARGETS)),)
#-include $(_BUILDSTAMP_DEPEND_FILE)

config_clean::
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Cleaning config buildstamp targets")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_BUILDSTAMP_H_TARGETS)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_RM) -f $(_BUILDSTAMP_C_TARGETS)
endif


#$(_BUILDSTAMP_DEPEND_FILE): _BUILDSTAMP_DEP_PREP $(_BUILDSTAMP_DEP_GENERATION_TARGETS)
#.INTERMEDIATE:: _BUILDSTAMP_DEP_PREP $(_BUILDSTAMP_DEP_GENERATION_TARGETS)


#_BUILDSTAMP_DEP_PREP:
#	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) clearing dependancy file $(_BUILDSTAMP_DEPEND_FILE)")
#	$(BIN_MKDIR) -p $(dir $(_BUILDSTAMP_DEPEND_FILE))
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" > $(_BUILDSTAMP_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## Auto generated depend file for buildstamp targets" >> $(_BUILDSTAMP_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "##" >> $(_BUILDSTAMP_DEPEND_FILE)


#_BUILDSTAMP_DEP_%:
#_BUILDSTAMP_DEP_%: _BS_H=$(BS_ARCH_TARGET_DIR)/$(*).h
#_BUILDSTAMP_DEP_%: _BS_C=$(BS_ARCH_TARGET_DIR)/$(*).c
#_BUILDSTAMP_DEP_%:
#	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX) Rebuilding dependancy for buildstamp target $(*) ")
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "## BUILDSTAMP target: $(*)" >> $(_BUILDSTAMP_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_BS_H): " >> $(_BUILDSTAMP_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "$(_BS_C): " >> $(_BUILDSTAMP_DEPEND_FILE)
#	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(_BUILDSTAMP_DEPEND_FILE)




$(_BUILDSTAMP_H_TARGETS):
$(_BUILDSTAMP_H_TARGETS): _T=$(notdir $(@:.h=))
$(_BUILDSTAMP_H_TARGETS): 
$(_BUILDSTAMP_H_TARGETS): _NAME=$(if $($(_T)_NAME),$($(_T)_NAME),$(BUILDSTAMP_NAME))
$(_BUILDSTAMP_H_TARGETS): _COMMENT=$(if $($(_T)_COMMENT),$($(_T)_COMMENT),$(BUILDSTAMP_COMMENT))
$(_BUILDSTAMP_H_TARGETS): 
$(_BUILDSTAMP_H_TARGETS): _REVISION_MAJOR=$(if $($(_T)_REVISION_MAJOR),$($(_T)_REVISION_MAJOR),$(BUILDSTAMP_REVISION_MAJOR))
$(_BUILDSTAMP_H_TARGETS): _REVISION_MINOR=$(if $($(_T)_REVISION_MINOR),$($(_T)_REVISION_MINOR),$(BUILDSTAMP_REVISION_MINOR))
$(_BUILDSTAMP_H_TARGETS): _REVISION_PATCH=$(if $($(_T)_REVISION_PATCH),$($(_T)_REVISION_PATCH),$(BUILDSTAMP_REVISION_PATCH))
$(_BUILDSTAMP_H_TARGETS): _REVISION_BUILD=$(if $($(_T)_REVISION_BUILD),$($(_T)_REVISION_BUILD),$(BUILDSTAMP_REVISION_BUILD))
$(_BUILDSTAMP_H_TARGETS): _REVISION_SRCVER=$(if $($(_T)_REVISION_SRCVER),$($(_T)_REVISION_SRCVER),$(BUILDSTAMP_REVISION_SRCVER))
$(_BUILDSTAMP_H_TARGETS): _REVISION_STRING=$(if $($(_T)_REVISION_STRING),$($(_T)_REVISION_STRING),$(BUILDSTAMP_REVISION_STRING))
$(_BUILDSTAMP_H_TARGETS): 
$(_BUILDSTAMP_H_TARGETS): _DATE_YEAR=$(if $($(_T)_DATE_YEAR),$($(_T)_DATE_YEAR),$(BUILDSTAMP_DATE_YEAR))
$(_BUILDSTAMP_H_TARGETS): _DATE_MONTH=$(if $($(_T)_DATE_MONTH),$($(_T)_DATE_MONTH),$(BUILDSTAMP_DATE_MONTH))
$(_BUILDSTAMP_H_TARGETS): _DATE_DAY=$(if $($(_T)_DATE_DAY),$($(_T)_DATE_DAY),$(BUILDSTAMP_DATE_DAY))
$(_BUILDSTAMP_H_TARGETS): _DATE_HOUR=$(if $($(_T)_DATE_HOUR),$($(_T)_DATE_HOUR),$(BUILDSTAMP_DATE_HOUR))
$(_BUILDSTAMP_H_TARGETS): _DATE_MINUTE=$(if $($(_T)_DATE_MINUTE),$($(_T)_DATE_MINUTE),$(BUILDSTAMP_DATE_MINUTE))
$(_BUILDSTAMP_H_TARGETS): _DATE_SECOND=$(if $($(_T)_DATE_SECOND),$($(_T)_DATE_SECOND),$(BUILDSTAMP_DATE_SECOND))
$(_BUILDSTAMP_H_TARGETS): _DATE_STRING=$(if $($(_T)_DATE_STRING),$($(_T)_DATE_STRING),$(BUILDSTAMP_DATE_STRING))
$(_BUILDSTAMP_H_TARGETS): 
$(_BUILDSTAMP_H_TARGETS): _USERNAME=$(if $($(_T)_USERNAME),$($(_T)_USERNAME),$(BUILDSTAMP_USERNAME))
$(_BUILDSTAMP_H_TARGETS): _HOSTNAME=$(if $($(_T)_HOSTNAME),$($(_T)_HOSTNAME),$(BUILDSTAMP_HOSTNAME))
$(_BUILDSTAMP_H_TARGETS): 
$(_BUILDSTAMP_H_TARGETS): _OS_NAME=$(if $($(_T)_OS_NAME),$($(_T)_OS_NAME),$(BUILDSTAMP_OS_NAME))
$(_BUILDSTAMP_H_TARGETS): _OS_REVMAJOR=$(if $($(_T)_OS_REVMAJOR),$($(_T)_OS_REVMAJOR),$(BUILDSTAMP_OS_REVMAJOR))
$(_BUILDSTAMP_H_TARGETS): _OS_REVMINOR=$(if $($(_T)_OS_REVMINOR),$($(_T)_OS_REVMINOR),$(BUILDSTAMP_OS_REVMINOR))
$(_BUILDSTAMP_H_TARGETS): _OS_REVPATCH=$(if $($(_T)_OS_REVPATCH),$($(_T)_OS_REVPATCH),$(BUILDSTAMP_OS_REVPATCH))
$(_BUILDSTAMP_H_TARGETS): 
$(_BUILDSTAMP_H_TARGETS): _OS_RUNTIMENAME=$(if $($(_T)_OS_NAME),$($(_T)_OS_NAME),$(BUILDSTAMP_OS_NAME))
$(_BUILDSTAMP_H_TARGETS): _OS_RUNTIMEREVMAJOR=$(if $($(_T)_OS_RUNTIMEREVMAJOR),$($(_T)_OS_RUNTIMEREVMAJOR),$(BUILDSTAMP_OS_RUNTIMEREVMAJOR))
$(_BUILDSTAMP_H_TARGETS): _OS_RUNTIMEREVMINOR=$(if $($(_T)_OS_RUNTIMEREVMINOR),$($(_T)_OS_RUNTIMEREVMINOR),$(BUILDSTAMP_OS_RUNTIMEREVMINOR))
$(_BUILDSTAMP_H_TARGETS): _OS_RUNTIMEREVPATCH=$(if $($(_T)_OS_RUNTIMEREVPATCH),$($(_T)_OS_RUNTIMEREVPATCH),$(BUILDSTAMP_OS_RUNTIMEREVPATCH))
$(_BUILDSTAMP_H_TARGETS): 
$(_BUILDSTAMP_H_TARGETS): _MACHINETYPE=$(if $($(_T)_MACHINETYPE),$($(_T)_MACHINETYPE),$(BUILDSTAMP_MACHINETYPE))
$(_BUILDSTAMP_H_TARGETS): _MACHINEPROC=$(if $($(_T)_MACHINEPROC),$($(_T)_MACHINEPROC),$(BUILDSTAMP_MACHINEPROC))
$(_BUILDSTAMP_H_TARGETS): _MACHINEINSTSET=$(if $($(_T)_MACHINEINSTSET),$($(_T)_MACHINEINSTSET),$(BUILDSTAMP_MACHINEINSTSET))
$(_BUILDSTAMP_H_TARGETS): 
$(_BUILDSTAMP_H_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Generating BuildStamp header file target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                    :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File                    :  $@")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#ifndef $(_T)_H" > $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_H" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_NAME                                 \"$(_NAME)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_COMMENT                              \"$(_COMMENT)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_REVISION_MAJOR                       $(_REVISION_MAJOR)" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_REVISION_MINOR                       $(_REVISION_MINOR)" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_REVISION_PATCH                       $(_REVISION_PATCH)" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_REVISION_BUILD                       $(_REVISION_BUILD)" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_REVISION_SRCVER                      \"$(_REVISION_SRCVER)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_REVISION_STRING                      \"$(_REVISION_STRING)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_DATE_YEAR                            $(_DATE_YEAR)" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_DATE_MONTH                           $(_DATE_MONTH)" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_DATE_DAY                             $(_DATE_DAY)" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_DATE_HOUR                            $(_DATE_HOUR)" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_DATE_MINUTE                          $(_DATE_MINUTE)" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_DATE_SECOND                          $(_DATE_SECOND)" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_DATE_STRING                          \"$(_DATE_STRING)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_USERNAME                             \"$(_USERNAME)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_HOSTNAME                             \"$(_HOSTNAME)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_OS_NAME                              \"$(_OS_NAME)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_OS_REVMAJOR                          \"$(_OS_REVMAJOR)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_OS_REVMINOR                          \"$(_OS_REVMINOR)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_OS_REVPATCH                          \"$(_OS_REVPATCH)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_OS_RUNTIMENAME                       \"$(_OS_RUNTIMENAME)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_OS_RUNTIMEREVMAJOR                   \"$(_OS_RUNTIMEREVMAJOR)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_OS_RUNTIMEREVMINOR                   \"$(_OS_RUNTIMEREVMINOR)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_OS_RUNTIMEREVPATCH                   \"$(_OS_RUNTIMEREVPATCH)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_MACHINETYPE                          \"$(_MACHINETYPE)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_MACHINEPROC                          \"$(_MACHINEPROC)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_MACHINEINSTSET                       \"$(_MACHINEINSTSET)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#ifndef $(_T)_NOEXTERN" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_name[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_comment[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const int  $(_T)_revision_major;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const int  $(_T)_revision_minor;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const int  $(_T)_revision_patch;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const int  $(_T)_revision_build;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_revision_srcver[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_revision_string[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const int  $(_T)_date_year;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const int  $(_T)_date_month;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const int  $(_T)_date_day;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const int  $(_T)_date_hour;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const int  $(_T)_date_minute;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const int  $(_T)_date_second;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_date_string[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_username[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_hostname[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_os_name[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_os_revmajor[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_os_revminor[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_os_revpatch[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_os_runtimename[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_os_runtimerevmajor[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_os_runtimerevminor[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_os_runtimerevpatch[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_machinetype[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_machineproc[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "extern const char $(_T)_machineinstset[];" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#endif /* $(_T)_NOEXTERN*/" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#endif /* $(_T)_H */" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)



$(_BUILDSTAMP_C_TARGETS):
$(_BUILDSTAMP_C_TARGETS): _T=$(notdir $(@:.c=))
$(_BUILDSTAMP_C_TARGETS): _BS_H=$(notdir $(@:.c=.h))
$(_BUILDSTAMP_C_TARGETS):
	@$(call BS_FUNC_ECHO_VERBOSE0,"$(BS_INFO_PREFIX) Generating BuildStamp C code file target $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Target Name                    :  $(_T)")
	@$(call BS_FUNC_ECHO_VERBOSE2,"$(BS_INFO_PREFIX)      Output File                    :  $@")
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#define $(_T)_NOEXTERN" > $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "#include \"$(_BS_H)\"" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_name[]                = $(_T)_NAME;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_comment[]             = $(_T)_COMMENT;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const int $(_T)_revision_major         = $(_T)_REVISION_MAJOR;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const int $(_T)_revision_minor         = $(_T)_REVISION_MINOR;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const int $(_T)_revision_patch         = $(_T)_REVISION_PATCH;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const int $(_T)_revision_build         = $(_T)_REVISION_BUILD;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_revision_srcver       = $(_T)_REVISION_SRCVER;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_revision_string[]     = $(_T)_REVISION_STRING;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const int $(_T)_date_year              = $(_T)_DATE_YEAR;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const int $(_T)_date_month             = $(_T)_DATE_MONTH;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const int $(_T)_date_day               = $(_T)_DATE_DAY;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const int $(_T)_date_hour              = $(_T)_DATE_HOUR;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const int $(_T)_date_minute            = $(_T)_DATE_MINUTE;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const int $(_T)_date_second            = $(_T)_DATE_SECOND;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_date_string[]         = $(_T)_DATE_STRING;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_username[]            = $(_T)_USERNAME;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_hostname[]            = $(_T)_HOSTNAME;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_os_name[]             = $(_T)_OS_NAME;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_os_revmajor[]         = $(_T)_OS_REVMAJOR;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_os_revminor[]         = $(_T)_OS_REVMINOR;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_os_revpatch[]         = $(_T)_OS_REVPATCH;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_os_runtimename[]      = $(_T)_OS_RUNTIMENAME;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_os_runtimerevmajor[]  = $(_T)_OS_RUNTIMEREVMAJOR;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_os_runtimerevminor[]  = $(_T)_OS_RUNTIMEREVMINOR;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_os_runtimerevpatch[]  = $(_T)_OS_RUNTIMEREVPATCH;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_machinetype[]         = $(_T)_MACHINETYPE;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_machineproc[]         = $(_T)_MACHINEPROC;" >> $(@)
	$(BS_CMDPREFIX_VERBOSE2) $(BIN_ECHO) "const char $(_T)_machineinstset[]      = $(_T)_MACHINEINSTSET;" >> $(@)




config_buildstamp: $(_BUILDSTAMP_H_TARGETS)
config_buildstamp: $(_BUILDSTAMP_C_TARGETS)
#config_buildstamp: $(_BUILDSTAMP_MK_TARGETS)


#
# hook module rules into build system
#

info:: config_info

man:: config_man

pretarget:: config_buildstamp

target::

posttarget::

clean:: config_clean

#depends:: _BUILDSTAMP_DEP_PREP $(_BUILDSTAMP_DEP_GENERATION_TARGETS)

.PHONY:: config_info config_man


