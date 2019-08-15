#!/bin/bash

# First source the lib autoloader into your script
. ~/Downloads/bash-libs/lib_inc.sh

# Call a function of a library with the keyword 'lib'
# following the function name without the lib_-Prefix
# and optionally a few arguments
STRING=$(lib string_toupper '  A string with spaces   ')

echo "#$STRING#"
