#!/bin/bash

function lib_string_tolower() {
    echo "${1,,}"
}

function lib_string_toupper() {
    echo "${1^^}"
}

function lib_string_trim() {
    local replace=' ' 
    if [ -z "$1" ]; then
        replace="${1:0:1}"
    fi    
    echo "${1%%$replace}"
}

function lib_string_substr() {
    echo "${1:$2:$3}"
}

#* function lib_string_repeat
#* Repeats a character a given times
#* @arg1 String Character to repeat
#* @arg2 Int Quantity to repeat
#* @return String Repeated String
function lib_string_repeat() {
    local res=$(printf "${1:0:1}%.0s" {1..$2})
    echo "$res"
}

#* function lib_string_pad
#* Pads a string to a given length with a filling character
#* @arg1 String Input
#* @arg2 Int Size 
#* @arg3 String Character to fill
#* @arg4 (Optional) String left|right; Default: left
function lib_string_pad() {
    local res
    local spacer=lib_string_repeat $2 $1
    if [ "$4" != "left" ]; then
        res="${spacer:0:$(($2 - ${#1}))}${1:0:$2}"            
    else
        res="${1:0:$2}${spacer:0:$(($2 - ${#1}))}"
    fi
    echo "$res"
}
