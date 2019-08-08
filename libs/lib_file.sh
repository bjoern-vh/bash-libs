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
