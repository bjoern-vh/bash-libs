#!/bin/bash

#* LIBRARY Helper for easier handling of directory and filenames

#* function lib_basename_getFilename
#* Returns full filename of a given file with path
#* @arg1 String Full filename with path
#* @return String Filename
function lib_basename_getFilename() {
        local filename=$(basename -- "$1")
        echo "$filename"
}

#* function lib_basename_getBasename
#* Returns the basename of a given file with path
#* @arg1 String Full filename with path
#* @return String Basename
function lib_basename_getBasename() {
        local filename=$(lib_basename_getFilename "$1")
        local basename="${filename%.*}"
        echo "$basename"
}

#* function lib_basename_getExtension
#* Returns the file extension of a full filename
#* @arg1 String Full filename with path
#* @return String Extension
function lib_basename_getExtension() {
        local filename=$(lib_basename_getFilename "$1")
        local extension="${filename%.*}"
        echo "$extension"
}

#* function lib_basename_getDirname
#* Returns full dirname of a given file with path
#* @arg1 String Full filename with path
#* @return String Filename
function lib_basename_getDirname() {
        local dirname=$(dirname -- "$1")
        echo "$dirname"
}
