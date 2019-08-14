#!/bin/bash

# First source the lib autoloader into your script
. lib_inc.sh

# Call a function of a library with the keyword 'lib' 
# following the function name without the lib_-Prefix 
# and optionally a few arguments
lib string_trim '  A string with spaces   '
