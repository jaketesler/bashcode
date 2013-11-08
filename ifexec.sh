#!/bin/bash

## Is this file executable? command for bash
## Written by Jake Tesler

#--------------------

if [ -x "$1" ]; then
    echo "File '$1' is executable"
elif [ -z "$1" ]; then
    echo "Usage: ifexec [file to be tested]"
	echo "This will test if a file can be executed by a bash shell."
	exit
else
	echo "File '$1' is not executable or not found"
fi

#if [ -x "$1" ]; then
#    echo "File '$1' is executable"
#else
#    echo "File '$1' is not executable or found"
#fi