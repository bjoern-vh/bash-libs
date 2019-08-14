#!/bin/bash

LIBRARY_PATH="$0/libs"

PREFIX='lib_'

METHOD="$1"

LIBRARY_NAME=$(echo "$1" | cut -d'_' -f1)
LIBRARY_FUNCTION=$(echo "$1" | cut -d' ' -f2)
LIBRARY_FILE="$LIBRARY_PATH/$PREFIX$LIBRARY_NAME.sh"

if [ ! -e "$LIBRARY_FILE" ]; then
	echo "Library file '$LIBRARY_FILE' is not available."
	exit 1
fi

FUNCTION="$PREFIX$LIBRARY_NAME_$LIBRARY_FUNCTION"

# Check if already loaded
declare -f "$FUNCTION" > /dev/null

if [ $? -ne 0 ]; then
	. "$LIBRARY_FILE"
fi

# Call function - TODO: Arguments
${PREFIX}

exit 0
