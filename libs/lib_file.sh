#!/bin/bash

#* LIBRARY Helper for easier handling of directories and filenames

#* function lib_file_getContents
#* Returns the whole content of file
#* @arg1 String Filename
#* @return String Content
function lib_file_getContents() {
	local contents=''
	if [ "$1" != "" ] && [ -r "$1" ]; then
		contents=$(cat "$1")
	fi
	echo "$contents"
}

#* function lib_file_dump
#* Empties the contents of a file
#* @arg1 String Filename
#* @return Integer Exit Code
function lib_file_dump() {
	local ret=0
	if [ "$1" != "" ] && [ -w "$1" ]; then
		truncate -s0 "$1"
		ret=$?
	fi
	echo $ret
}

#* function lib_file_getFilename
#* Returns full filename of a given file with path
#* @arg1 String Full filename with path
#* @return String Filename
function lib_file_getFilename() {
        local filename=$(basename -- "$1")
        echo "$filename"
}

#* function lib_file_getBasename
#* Returns the basename of a given file with path
#* @arg1 String Full filename with path
#* @return String Basename
function lib_file_getBasename() {
        local filename=$(lib_file_getFilename "$1")
        local basename="${filename%.*}"
        echo "$basename"
}

#* function lib_file_getExtension
#* Returns the file extension of a full filename
#* @arg1 String Full filename with path
#* @return String Extension
function lib_file_getExtension() {
        local filename=$(lib_file_getFilename "$1")
        local extension="${filename%.*}"
        echo "$extension"
}

#* function lib_file_getDirname
#* Returns full dirname of a given file with path
#* @arg1 String Full filename with path
#* @return String Filename
function lib_file_getDirname() {
        local dirname=$(dirname -- "$1")
        echo "$dirname"
}

#* function lib_file_setOwner
#* Sets user and optional group of a file system object
#* @arg1 String File system object
#* @arg2 String Username
#* @arg3 String (Optional) Groupname
#* @return Integer Exit Code
#* @throws Throws an error if no file system object is given
#* @throws Throws an error if file system object dioes not exist
#* @throws Throws an error if no user is given
#* @throws Throws an error if group is given but dows not exists
function lib_file_setOwner() {
	if [ "$1" == "" ]; then
		echo "No file system object is given"
		exit 1
	fi
	if [ ! -e "$1" ]; then
		echo "File system object does not exist: $1"
		exit 1
	fi
	if [ "$2" == "" ]; then
		echo "No user given"
		exit 1
	fi
	if [ $(id -u "$2") -eq 1 ]; then
		echo "User $2 does not exist"
		exit 1
	fi
	if [ "$3" != "" ]; then
		if [ ! $(getent group "$1") ]; then
			echo "Group $3 does not exist"
			exit 1
		fi
	fi
	if [ "$3" == "" ]; then
		chown "$2" "$1"
	else
		chown "$2:$3" "$1"
	fi
	echo $?
}
