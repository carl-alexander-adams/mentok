# macros and includes to make the build system go. (generally this
# will be one of the first things in your Makefile)
COMPONENT_ROOT=../..
BS_ROOT=$(COMPONENT_ROOT)/build3
include $(BS_ROOT)/defines.mk


#
# Set up global C flags - The use of += is encouraged as to avoid
# stomping on project wide settings in $(COMPONENT_ROOT)/build3-config
#
FLAGS_CC+=-I../include
FLAGS_CXX+=-I../include

# When you specify objects for an EXE target, OBJ_XXX_TARGETS
# are implied. you do not need do specify them separatly.
# these implied OBJ_XXX_TARGETS have all the controls
# availible to them that are demonstrated elseware in this 
# sample project.
OBJ_CC_TARGETS=
OBJ_CXX_TARGETS=



# Specify executable pattern targets. It is not necessary to
# to specify a .exe suffix
EXE_TARGETS=exe1-hello-a  exe1-hello-b

# Specify the objects for an executable. If none are specified,
# it is assumed that the executable is made from one object
# of the form 
# exe1-hello-a_OBJS= # look for a way to build exe1-hello-a.o
exe1-hello-b_OBJS= hello-plusplus.o hello-pp.o


# Just as object targets have may controls, EXE targets
# have their own set of controls. See the nativecode.html
# documentation for a full list and description. Like other
# target control macros, these permit the full overriding of
# global defaults, so chaining is widely reccomended to 
# respect that which is global for a reason
#exe-hello-a_LDFLAGS= $(FLAGS_LD_EXE) -L/Some/lib/dir/lib -lmylib

# include the rules to make the build system go. (generally this
# will be one of the last things in your Makefile)
include $(BS_ROOT)/rules.mk
