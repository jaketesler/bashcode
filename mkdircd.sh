#!/bin/bash

##    'mkdircd' command for bash
##    Written by Jake Tesler

#--------------------

function mkdircde () { mkdir -p "$@" && eval cd "\"\$$#\""; }

#mkdir -p $1
#sleep 1
#cd $1

#mkdircde
mkdir -p "$@"
eval cd ./$@