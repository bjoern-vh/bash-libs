#!/bin/bash

#* LIBRARY Helper for logging messages with date and time to a file

lib_logger_dateformat='%Y-%m-%d %H:%M:%S.%N'
lib_logger_file='/tmp/logger.log'

#* function lib_logger_log
#* Logs a string to a a log file
#* @String Message to log
#* @String (Optional) path to different log file
function lib_logger_log() {
	DATETIME=$(date +"$lib_logger_dateformat")
	log="$lib_logger_file"
	if [ "$2" != "" ]; then
		log="$2"
	fi
        echo "$DATETIME: $1" >> "$log"
}

#* function lib_logger_setLogFile
#* Changes the log file path
#* @String Path to log file
#* @throws Throws an error if log file is not writeable or cannot be created.
function lib_logger_setLogFile() {
	lib_logger_file="$1"
	if [ !-f "$lib_logger_file" ]; then
		touch "$lib_logger_file"
		if [ "$?" -ne 0 ]; then
			exit 1
		fi
	elif [ ! -w "$lib_logger_file" ]; then
		exit 1
	fi
}

#* function lib_logger_clear
#* Clears the log file
#* @String Path to alternative log file
#* @throws Throws an error if log is not writebale or file not exists
function lib_logger_clear() {
	log="$lib_logger_log"
	if [ "$1" != "" ]; then
		if [ ! -f "$log" ]; then
			exit 1
		elif [ ! -w "$log" ]; then
			exit 1
		else
			truncate -s0 "$lib_logger_file"
			exit "$?"
		fi
	fi
}

#* function lib_logger_setDateFormat
#* Sets an alternate date format for the log files
#* @String Date format
function lib_logger_setDateFormat() {
	lib_logger_dateformat="$1"
}
