#!/bin/bash

# LIBRARY List a overview of all libs or details of a specified one.

# Check if library file is supplied and if not show all library files
if [ "$1" == "" ]; then
	longest=0
	dirname=$(dirname -- "$0")
    if [ "$dirname" == ".." ]; then
        dirname='.'
    fi
    dirname="$dirname/lib"
	ls -1 "$dirname/"lib_*.sh | while read file; do
		FILENAME=$(basename -- "$file")
		BASENAME="${FILENAME%.*}"
		LINE=$(cat "$file" | grep '#* LIBRARY ')
		LIBNAME="${BASENAME:4:${#BASENAME}}"
		if [ "${#LIBNAME}" -gt "$longest" ]; then
			longest="${#LIBNAME}"
			echo "$longest" > "/tmp/lib.tmp"
		fi
	done
	ls -1 "$dirname/"lib_*.sh | while read file; do
		if [ -r "/tmp/lib.tmp" ]; then
			longest=$(cat "/tmp/lib.tmp")
			longest=$((longest+1))
			rm -f "/tmp/lib.tmp"
		fi
		SPACES="                                                  "
		if [ "$file" != "$0" ]; then
			FILENAME=$(basename -- "$file")
			BASENAME="${FILENAME%.*}"
			LINE=$(cat "$file" | grep '#* LIBRARY ')
			LIBNAME="${BASENAME:4:${#BASENAME}}"
			LENGTH=$(($longest-${#LIBNAME}))
			COMMENT="${LINE:11:${#LINE}}"
			if [ "$COMMENT" == "" ]; then
				COMMENT="-"
			fi
			echo -e "${LIBNAME}${SPACES:0:$LENGTH}| $COMMENT"
		fi
	done
	exit 0
fi

# Checks if prefix and suffix are set and if not add them
LIBRARY="$1"
if [ "${LIBRARY:0:4}" != "lib_" ]; then
	LIBRARY="lib_$LIBRARY"
fi
if [ "${LIBRARY: -3}" != ".sh" ]; then
	LIBRARY="$LIBRARY.sh"
fi

LIBRARY_FILE=$(dirname -- "$0")"/lib/$LIBRARY"
if [ ! -r "$LIBRARY_FILE" ]; then
	echo "No valid library file submitted"
	exit 1
fi

# Print out library file name in uppercase
echo -e '\033[1;34m'"${1^^}"

# Loop all lines of the library and parse the comments starting with #*
cat "$LIBRARY_FILE" | while read line; do
	# only parse if starting with #*
	if [ "${line:0:2}" == "#*" ]; then
		# Print out funtion name
		if [ "${line:3:8}" == "function" ]; then
			echo -e '\033[1;33m'"${line:3:${#line}}"
		# Print out comment for the whole library
elif [ "${line:3:7}" == "LIBRARY" ]; then
			echo -e '\033[1;34m'"${line:11:${#line}}"
		# Print out constants
		elif [ "${line:3:5}" == "Const" ]; then
			CONSTANT=$(echo "${line:9:${#line}}" | cut -d' ' -f1)
			COMMENT=$(echo "${line:9:${#line}}" | cut -d' ' -f2-100)
			if [ "$COMMENT" == "$CONSTANT" ]; then
				COMMENT=
			fi
			SEPARATOR=' : '
			if [ "$COMMENT" == "" ]; then
				SEPARATOR=
			fi
			echo -e '\033[1;33m'"Constant "'\033[1;37m'"$CONSTANT$SEPARATOR"'\033[0m'$COMMENT
		elif [ "${line:3:7}" == "@throws" ]; then
			echo -e '\033[1;31m'" ${line:3:${#line}}"
		# Print out default line
		elif [ "${line:3:1}" != "@" ]; then
			echo -e '\033[1;37m'"${line:3:${#line}}"
		# Print out argument or return values
		else
			echo -e '\033[0m'" ${line:3:${#line}}"
		fi
	fi
done

exit 0
