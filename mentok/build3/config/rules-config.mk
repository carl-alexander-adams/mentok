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
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_OS                            $(BUILDSTAMP_OS)"
	@echo "$(BS_INFO_PREFIX) BUILDSTAMP_MACHINETYPE                   $(BUILDSTAMP_MACHINETYPE)"
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
$(_BUILDSTAMP_H_TARGETS): _OS=$(if $($(_T)_OS),$($(_T)_OS),$(BUILDSTAMP_OS))
$(_BUILDSTAMP_H_TARGETS): _MACHINETYPE=$(if $($(_T)_MACHINETYPE),$($(_T)_MACHINETYPE),$(BUILDSTAMP_MACHINETYPE))

$(_BUILDSTAMP_H_TARGETS): 
$(_BUILDSTAMP_H_TARGETS):
	@echo
	@echo "$(BS_INFO_PREFIX)  Generating BuildStamp header file target $(_T)"
	@echo "$(BS_INFO_PREFIX)      Target Name                    :  $(_T)"
	@echo "$(BS_INFO_PREFIX)      Output File                    :  $@"
	echo "#ifndef $(_T)_H" > $(@)
	echo "#define $(_T)_H" >> $(@)
	echo "" >> $(@)
	echo "#ifdef $(_T)_NOEXTERN" >> $(@)
	echo "#define $(_T)_EXTERN" >> $(@)
	echo "#else" >> $(@)
	echo "#define $(_T)_EXTERN extern" >> $(@)
	echo "#endif" >> $(@)
	echo "" >> $(@)
	echo "" >> $(@)
	echo "" >> $(@)
	echo "#define $(_T)_NAME            \"$(_NAME)\"" >> $(@)
	echo "#define $(_T)_COMMENT         \"$(_COMMENT)\"" >> $(@)
	echo "#define $(_T)_REVISION_STRING \"$(_REVISION_STRING)\"" >> $(@)
	echo "#define $(_T)_DATE_STRING     \"$(_DATE_STRING)\"" >> $(@)
	echo "" >> $(@)
	echo "#define $(_T)_REVISION_MAJOR                       $(_REVISION_MAJOR)" >> $(@)
	echo "#define $(_T)_REVISION_MINOR                       $(_REVISION_MINOR)" >> $(@)
	echo "#define $(_T)_REVISION_PATCH                       $(_REVISION_PATCH)" >> $(@)
	echo "" >> $(@)
	echo "#define $(_T)_DATE_YEAR                            $(_DATE_YEAR)" >> $(@)
	echo "#define $(_T)_DATE_MONTH                           $(_DATE_MONTH)" >> $(@)
	echo "#define $(_T)_DATE_DAY                             $(_DATE_DAY)" >> $(@)
	echo "#define $(_T)_DATE_HOUR                            $(_DATE_HOUR)" >> $(@)
	echo "#define $(_T)_DATE_MINUTE                          $(_DATE_MINUTE)" >> $(@)
	echo "#define $(_T)_DATE_SECOND                          $(_DATE_SECOND)" >> $(@)
	echo "" >> $(@)
	echo "#define $(_T)_OS                                   $(_OS)" >> $(@)
	echo "#define $(_T)_MACHINETYPE                          $(_MACHINETYPE)" >> $(@)
	echo "" >> $(@)
	echo "" >> $(@)
	echo "" >> $(@)
	echo "$(_T)_EXTERN const char $(_T)_name[];" >> $(@)
	echo "$(_T)_EXTERN const char $(_T)_comment[];" >> $(@)
	echo "$(_T)_EXTERN const char $(_T)_revision_string[];" >> $(@)
	echo "$(_T)_EXTERN const char $(_T)_date_string[];" >> $(@)
	echo "" >> $(@)
	echo "$(_T)_EXTERN const int $(_T)_revision_major;" >> $(@)
	echo "$(_T)_EXTERN const int $(_T)_revision_minor;" >> $(@)
	echo "$(_T)_EXTERN const int $(_T)_revision_patch;" >> $(@)
	echo "" >> $(@)
	echo "$(_T)_EXTERN const int $(_T)_date_year;" >> $(@)
	echo "$(_T)_EXTERN const int $(_T)_date_month;" >> $(@)
	echo "$(_T)_EXTERN const int $(_T)_date_day;" >> $(@)
	echo "$(_T)_EXTERN const int $(_T)_date_hour;" >> $(@)
	echo "$(_T)_EXTERN const int $(_T)_date_minute;" >> $(@)
	echo "$(_T)_EXTERN const int $(_T)_date_second;" >> $(@)
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
	echo "const char $(_T)_name[]            = $(_T)_NAME;" >> $(@)
	echo "const char $(_T)_comment[]         = $(_T)_COMMENT;" >> $(@)
	echo "const char $(_T)_revision_string[] = $(_T)_REVISION_STRING;" >> $(@)
	echo "const char $(_T)_date_string[]     = $(_T)_DATE_STRING;" >> $(@)
	echo "" >> $(@)
	echo "const int $(_T)_revision_major     = $(_T)_REVISION_MAJOR;" >> $(@)
	echo "const int $(_T)_revision_minor     = $(_T)_REVISION_MINOR;" >> $(@)
	echo "const int $(_T)_revision_patch     = $(_T)_REVISION_PATCH;" >> $(@)
	echo "" >> $(@)
	echo "const int $(_T)_date_year          = $(_T)_DATE_YEAR;" >> $(@)
	echo "const int $(_T)_date_month         = $(_T)_DATE_MONTH;" >> $(@)
	echo "const int $(_T)_date_day           = $(_T)_DATE_DAY;" >> $(@)
	echo "const int $(_T)_date_hour          = $(_T)_DATE_HOUR;" >> $(@)
	echo "const int $(_T)_date_minute        = $(_T)_DATE_MINUTE;" >> $(@)
	echo "const int $(_T)_date_second        = $(_T)_DATE_SECOND;" >> $(@)
	echo "" >> $(@)




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


