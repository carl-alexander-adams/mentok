# These macro doesn't mean anything to the core build system
# Things in here are for the component to do it's own thing.
#
# We keep these in their own .mk file to make life easier for
# the windows build to access these variables. 
# To that end, we explictly limit the make syntax you use in 
# this file to simple MACRO=<literal value> statements.

PROJECT		= my_project
PRODUCTNUM	= 0100
VERSION		= 1.0
VERSION_MAJOR	= 1
VERSION_MINOR	= 0
VERSION_PATCH	= 0

