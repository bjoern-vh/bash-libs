#!/bin/bash

function lib_file_getContents() {
	local contents=''
	if [ "$1" != "" ] && [ -r "$1" ]; then
		contents=$(cat "$1")
	fi
	echo "$contents"
}

function lib_file_dump() {
	local ret=0
	if [ "$1" != "" ] && [ -w "$1" ]; then
		truncate -s0 "$1"
		ret="$?"
	fi
	echo "$ret"
}
