#
# Module rules
#
config_man:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Config Module Manual"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@$(BIN_BSCATMAN) $(BS_ROOT)/config/config.html

config_info:
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX) Build System Config Module Macro Settings"
	@echo "$(BS_INFO_PREFIX) --------------------------------------------------"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_NAME                          $(BUILDSTAMP_NAME)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_COMMENT                       $(BUILDSTAMP_COMMENT)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_DATE_YEAR                     $(BUILDSTAMP_DATE_YEAR)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_DATE_MONTH                    $(BUILDSTAMP_DATE_MONTH)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_DATE_DAY                      $(BUILDSTAMP_DATE_DAY)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_DATE_HOUR                     $(BUILDSTAMP_DATE_HOUR)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_DATE_MINUTE                   $(BUILDSTAMP_DATE_MINUTE)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_DATE_SECOND                   $(BUILDSTAMP_DATE_SECOND)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_DATE_STRING                   $(BUILDSTAMP_DATE_STRING)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_REVISION_MAJOR                $(BUILDSTAMP_REVISION_MAJOR)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_REVISION_MINOR                $(BUILDSTAMP_REVISION_MINOR)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_REVISION_PATCH                $(BUILDSTAMP_REVISION_PATCH)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_REVISION_STRING               $(BUILDSTAMP_REVISION_STRING)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_USERNAME                      $(BUILDSTAMP_USERNAME)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_HOSTNAME                      $(BUILDSTAMP_HOSTNAME)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_OS_NAME                       $(BUILDSTAMP_OS_NAME)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_OS_REVMAJOR                   $(BUILDSTAMP_OS_REVMAJOR)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_OS_REVMINOR                   $(BUILDSTAMP_OS_REVMINOR)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_OS_REVPATCH                   $(BUILDSTAMP_OS_REVPATCH)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_OS_RUNTIMENAME                $(BUILDSTAMP_OS_RUNTIMENAME)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_OS_RUNTIMEREVMAJOR            $(BUILDSTAMP_OS_RUNTIMEREVMAJOR)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_OS_RUNTIMEREVMINOR            $(BUILDSTAMP_OS_RUNTIMEREVMINOR)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_OS_RUNTIMEREVPATCH            $(BUILDSTAMP_OS_RUNTIMEREVPATCH)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_MACHINETYPE                   $(BUILDSTAMP_MACHINETYPE)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_MACHINEPROC                   $(BUILDSTAMP_MACHINEPROC)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_MACHINEINSTSET                $(BUILDSTAMP_MACHINEINSTSET)"
	@echo "$(BS_INFO_PREFIX)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_TARGETS                       $(BUILDSTAMP_TARGETS)"

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
#_BUILDSTAMP_DEPEND_FILE=$(BS_ARCH_TARGET_DIR)/config_depend_buildstamp.mk


ifneq ($(strip $(BUILDSTAMP_TARGETS)),)
#-include $(_BUILDSTAMP_DEPEND_FILE)

config_clean::
	@echo "$(BS_INFO_PREFIX)  cleaning config buildstamp targets"
	$(BIN_RM) -f $(_BUILDSTAMP_H_TARGETS)
	$(BIN_RM) -f $(_BUILDSTAMP_C_TARGETS)
endif


#$(_BUILDSTAMP_DEPEND_FILE): _BUILDSTAMP_DEP_PREP $(_BUILDSTAMP_DEP_GENERATION_TARGETS)
#.INTERMEDIATE:: _BUILDSTAMP_DEP_PREP $(_BUILDSTAMP_DEP_GENERATION_TARGETS)


#_BUILDSTAMP_DEP_PREP:
#	@echo "$(BS_INFO_PREFIX) clearing dependancy file $(_BUILDSTAMP_DEPEND_FILE)"
#	$(BIN_MKDIR) -p $(dir $(_BUILDSTAMP_DEPEND_FILE))
#	echo "##" > $(_BUILDSTAMP_DEPEND_FILE)
#	echo "## Auto generated depend file for buildstamp targets" >> $(_BUILDSTAMP_DEPEND_FILE)
#	echo "##" >> $(_BUILDSTAMP_DEPEND_FILE)


#_BUILDSTAMP_DEP_%:
#_BUILDSTAMP_DEP_%: _BS_H=$(BS_ARCH_TARGET_DIR)/$(*).h
#_BUILDSTAMP_DEP_%: _BS_C=$(BS_ARCH_TARGET_DIR)/$(*).c
#_BUILDSTAMP_DEP_%:
#	@echo "$(BS_INFO_PREFIX) Rebuilding dependancy for buildstamp target $(*) "
#	@echo "## BUILDSTAMP target: $(*)" >> $(_BUILDSTAMP_DEPEND_FILE)
#	@echo "$(_BS_H): " >> $(_BUILDSTAMP_DEPEND_FILE)
#	@echo "$(_BS_C): " >> $(_BUILDSTAMP_DEPEND_FILE)
#	@echo "" >> $(_BUILDSTAMP_DEPEND_FILE)




$(_BUILDSTAMP_H_TARGETS):
$(_BUILDSTAMP_H_TARGETS): _T=$(notdir $(@:.h=))
$(_BUILDSTAMP_H_TARGETS): 
$(_BUILDSTAMP_H_TARGETS): _NAME=$(if $($(_T)_NAME),$($(_T)_NAME),$(BUILDSTAMP_NAME))
$(_BUILDSTAMP_H_TARGETS): _COMMENT=$(if $($(_T)_COMMENT),$($(_T)_COMMENT),$(BUILDSTAMP_COMMENT))
$(_BUILDSTAMP_H_TARGETS): 
$(_BUILDSTAMP_H_TARGETS): _REVISION_MAJOR=$(if $($(_T)_REVISION_MAJOR),$($(_T)_REVISION_MAJOR),$(BUILDSTAMP_REVISION_MAJOR))
$(_BUILDSTAMP_H_TARGETS): _REVISION_MINOR=$(if $($(_T)_REVISION_MINOR),$($(_T)_REVISION_MINOR),$(BUILDSTAMP_REVISION_MINOR))
$(_BUILDSTAMP_H_TARGETS): _REVISION_PATCH=$(if $($(_T)_REVISION_PATCH),$($(_T)_REVISION_PATCH),$(BUILDSTAMP_REVISION_PATCH))
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
	@echo
	@echo "$(BS_INFO_PREFIX)  Generating BuildStamp header file target $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                    :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                    :  $@"
	echo "#ifndef $(_T)_H" > $(@)
	echo "#define $(_T)_H" >> $(@)
	echo "" >> $(@)
	echo "" >> $(@)
	echo "#define $(_T)_NAME                                 \"$(_NAME)\"" >> $(@)
	echo "#define $(_T)_COMMENT                              \"$(_COMMENT)\"" >> $(@)
	echo "" >> $(@)
	echo "#define $(_T)_REVISION_MAJOR                       $(_REVISION_MAJOR)" >> $(@)
	echo "#define $(_T)_REVISION_MINOR                       $(_REVISION_MINOR)" >> $(@)
	echo "#define $(_T)_REVISION_PATCH                       $(_REVISION_PATCH)" >> $(@)
	echo "#define $(_T)_REVISION_STRING                      \"$(_REVISION_STRING)\"" >> $(@)
	echo "" >> $(@)
	echo "#define $(_T)_DATE_YEAR                            $(_DATE_YEAR)" >> $(@)
	echo "#define $(_T)_DATE_MONTH                           $(_DATE_MONTH)" >> $(@)
	echo "#define $(_T)_DATE_DAY                             $(_DATE_DAY)" >> $(@)
	echo "#define $(_T)_DATE_HOUR                            $(_DATE_HOUR)" >> $(@)
	echo "#define $(_T)_DATE_MINUTE                          $(_DATE_MINUTE)" >> $(@)
	echo "#define $(_T)_DATE_SECOND                          $(_DATE_SECOND)" >> $(@)
	echo "#define $(_T)_DATE_STRING                          \"$(_DATE_STRING)\"" >> $(@)
	echo "" >> $(@)
	echo "#define $(_T)_USERNAME                             \"$(_USERNAME)\"" >> $(@)
	echo "#define $(_T)_HOSTNAME                             \"$(_HOSTNAME)\"" >> $(@)
	echo "" >> $(@)
	echo "#define $(_T)_OS_NAME                              \"$(_OS_NAME)\"" >> $(@)
	echo "#define $(_T)_OS_REVMAJOR                          \"$(_OS_REVMAJOR)\"" >> $(@)
	echo "#define $(_T)_OS_REVMINOR                          \"$(_OS_REVMINOR)\"" >> $(@)
	echo "#define $(_T)_OS_REVPATCH                          \"$(_OS_REVPATCH)\"" >> $(@)
	echo "" >> $(@)
	echo "#define $(_T)_OS_RUNTIMENAME                       \"$(_OS_RUNTIMENAME)\"" >> $(@)
	echo "#define $(_T)_OS_RUNTIMEREVMAJOR                   \"$(_OS_RUNTIMEREVMAJOR)\"" >> $(@)
	echo "#define $(_T)_OS_RUNTIMEREVMINOR                   \"$(_OS_RUNTIMEREVMINOR)\"" >> $(@)
	echo "#define $(_T)_OS_RUNTIMEREVPATCH                   \"$(_OS_RUNTIMEREVPATCH)\"" >> $(@)
	echo "" >> $(@)
	echo "#define $(_T)_MACHINETYPE                          \"$(_MACHINETYPE)\"" >> $(@)
	echo "#define $(_T)_MACHINEPROC                          \"$(_MACHINEPROC)\"" >> $(@)
	echo "#define $(_T)_MACHINEINSTSET                       \"$(_MACHINEINSTSET)\"" >> $(@)
	echo "" >> $(@)
	echo "" >> $(@)
	echo "" >> $(@)
	echo "#ifndef $(_T)_NOEXTERN" >> $(@)
	echo "" >> $(@)
	echo "" >> $(@)
	echo "extern const char $(_T)_name[];" >> $(@)
	echo "extern const char $(_T)_comment[];" >> $(@)
	echo "" >> $(@)
	echo "extern const int  $(_T)_revision_major;" >> $(@)
	echo "extern const int  $(_T)_revision_minor;" >> $(@)
	echo "extern const int  $(_T)_revision_patch;" >> $(@)
	echo "extern const char $(_T)_revision_string[];" >> $(@)
	echo "" >> $(@)
	echo "extern const int  $(_T)_date_year;" >> $(@)
	echo "extern const int  $(_T)_date_month;" >> $(@)
	echo "extern const int  $(_T)_date_day;" >> $(@)
	echo "extern const int  $(_T)_date_hour;" >> $(@)
	echo "extern const int  $(_T)_date_minute;" >> $(@)
	echo "extern const int  $(_T)_date_second;" >> $(@)
	echo "extern const char $(_T)_date_string[];" >> $(@)
	echo "" >> $(@)
	echo "extern const char $(_T)_username[];" >> $(@)
	echo "extern const char $(_T)_hostname[];" >> $(@)
	echo "" >> $(@)
	echo "extern const char $(_T)_os_name[];" >> $(@)
	echo "extern const char $(_T)_os_revmajor[];" >> $(@)
	echo "extern const char $(_T)_os_revminor[];" >> $(@)
	echo "extern const char $(_T)_os_revpatch[];" >> $(@)
	echo "" >> $(@)
	echo "extern const char $(_T)_os_runtimename[];" >> $(@)
	echo "extern const char $(_T)_os_runtimerevmajor[];" >> $(@)
	echo "extern const char $(_T)_os_runtimerevminor[];" >> $(@)
	echo "extern const char $(_T)_os_runtimerevpatch[];" >> $(@)
	echo "" >> $(@)
	echo "extern const char $(_T)_machinetype[];" >> $(@)
	echo "extern const char $(_T)_machineproc[];" >> $(@)
	echo "extern const char $(_T)_machineinstset[];" >> $(@)
	echo "" >> $(@)
	echo "" >> $(@)
	echo "#endif /* $(_T)_NOEXTERN*/" >> $(@)
	echo "" >> $(@)
	echo "" >> $(@)
	echo "" >> $(@)
	echo "#endif /* $(_T)_H */" >> $(@)
	echo "" >> $(@)



$(_BUILDSTAMP_C_TARGETS):
$(_BUILDSTAMP_C_TARGETS): _T=$(notdir $(@:.c=))
$(_BUILDSTAMP_C_TARGETS): _BS_H=$(notdir $(@:.c=.h))
$(_BUILDSTAMP_C_TARGETS):
	@echo
	@echo "$(BS_INFO_PREFIX)  Generating BuildStamp c code file target $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                    :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                    :  $@"
	echo "#define $(_T)_NOEXTERN" > $(@)
	echo "#include \"$(_BS_H)\"" >> $(@)
	echo "" >> $(@)
	echo "const char $(_T)_name[]                = $(_T)_NAME;" >> $(@)
	echo "const char $(_T)_comment[]             = $(_T)_COMMENT;" >> $(@)
	echo "" >> $(@)
	echo "const int $(_T)_revision_major         = $(_T)_REVISION_MAJOR;" >> $(@)
	echo "const int $(_T)_revision_minor         = $(_T)_REVISION_MINOR;" >> $(@)
	echo "const int $(_T)_revision_patch         = $(_T)_REVISION_PATCH;" >> $(@)
	echo "const char $(_T)_revision_string[]     = $(_T)_REVISION_STRING;" >> $(@)
	echo "" >> $(@)
	echo "const int $(_T)_date_year              = $(_T)_DATE_YEAR;" >> $(@)
	echo "const int $(_T)_date_month             = $(_T)_DATE_MONTH;" >> $(@)
	echo "const int $(_T)_date_day               = $(_T)_DATE_DAY;" >> $(@)
	echo "const int $(_T)_date_hour              = $(_T)_DATE_HOUR;" >> $(@)
	echo "const int $(_T)_date_minute            = $(_T)_DATE_MINUTE;" >> $(@)
	echo "const int $(_T)_date_second            = $(_T)_DATE_SECOND;" >> $(@)
	echo "const char $(_T)_date_string[]         = $(_T)_DATE_STRING;" >> $(@)
	echo "" >> $(@)
	echo "const char $(_T)_username[]            = $(_T)_USERNAME;" >> $(@)
	echo "const char $(_T)_hostname[]            = $(_T)_HOSTNAME;" >> $(@)
	echo "" >> $(@)
	echo "const char $(_T)_os_name[]             = $(_T)_OS_NAME;" >> $(@)
	echo "const char $(_T)_os_revmajor[]         = $(_T)_OS_REVMAJOR;" >> $(@)
	echo "const char $(_T)_os_revminor[]         = $(_T)_OS_REVMINOR;" >> $(@)
	echo "const char $(_T)_os_revpatch[]         = $(_T)_OS_REVPATCH;" >> $(@)
	echo "" >> $(@)
	echo "const char $(_T)_os_runtimename[]      = $(_T)_OS_RUNTIMENAME;" >> $(@)
	echo "const char $(_T)_os_runtimerevmajor[]  = $(_T)_OS_RUNTIMEREVMAJOR;" >> $(@)
	echo "const char $(_T)_os_runtimerevminor[]  = $(_T)_OS_RUNTIMEREVMINOR;" >> $(@)
	echo "const char $(_T)_os_runtimerevpatch[]  = $(_T)_OS_RUNTIMEREVPATCH;" >> $(@)
	echo "" >> $(@)
	echo "const char $(_T)_machinetype[]         = $(_T)_MACHINETYPE;" >> $(@)
	echo "const char $(_T)_machineproc[]         = $(_T)_MACHINEPROC;" >> $(@)
	echo "const char $(_T)_machineinstset[]      = $(_T)_MACHINEINSTSET;" >> $(@)




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


