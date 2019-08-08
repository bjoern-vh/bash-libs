#!/bin/bash

LIBRARY_PATH="$0/lib"

if [ "$1" == "" ]; then
	echo "No library file submitted."
	exit 1
fi

LIBRARY="$1"

if [ "${LIBRARY:0:4}" != "lib_" ]; then
        LIBRARY="lib_$LIBRARY"
fi

if [ "${LIBRARY: -3}" != ".sh" ]; then
        LIBRARY="$LIBRARY.sh"
fi

if [ ! -f "$LIBRARY_PATH/$LIBRARY" ]; then
	echo "Library is not available."
	exit 1
fi

if [ ! -r "$LIBRARY_PATH/$LIBRARY" ]; then
	echo "Library is not readable."
	exit 1
fi

. "LIBRARY_PATH/$LIBRARY"

exit 0
