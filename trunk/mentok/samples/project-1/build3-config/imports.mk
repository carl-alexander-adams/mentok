# Project wide import targets are defined in this file.
# There is really nothing that distinguishes import targets
# from any other targets, except that in practice they are
# things that are required by many othter makefiles in the
# project, and may even be required by the project wide
# defines for the construction of default linker and compiler
# flags.  To accomodate this real world usage of these 
# targets, the core build system looks for a component
# wide imports.mk file that is expected to include the definition
# of import pattern targets.


# IMPORT_ARCH_TARGETS=mhnet mhnet-crossplatform blackbird-mh boguscomp1
# IMPORT_NOARCH_TARGETS=


this_component_doesnt_exist_REV=2003-07-18

blackbird-mh_REV=4.0.4-2005-03-28_blackbird-404-endc-204-branch

mhnet_REV=2003-04-03
#mhnet_DISTROOT=foo
#mhnet_FROM=foobar

mhnet-crossplatform_REV=2003-04-03
mhnet-crossplatform_PLATFORM=SunOS-5.9-sparcv9
mhnet-crossplatform_DISTNAME=mhnet
#mhnet_DISTROOT=foo
#mhnet_FROM=foobar



