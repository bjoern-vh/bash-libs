#!/bin/bash

function lib_math_sum() {
	local a=0
	local b=0
	if [ "$2" != "" ]; then
		b=$2
	fi
	if [ "$1" != "" ]; then
		a=$1
	fi
	echo $((a+b))
}
