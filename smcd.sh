#!/bin/bash

##  'smcd' command for bash
##  Written by Jake Tesler

#--------------------

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
orig_speed=""
speed=""
use_py=true;
str=""
speed_ok=false;

function show_help()
{
	echo -e "Usage: smcd [options]
	Manually sets fan speed.
	Options:
	-h\t\tShow Help (this)
	-x\t\tDisable Python (fast calculation)
	-f VALUE\tValue to set fan speed"
}

function quit() { show_help; exit 0; }

if [ "$#" -eq 0 ]; then quit; fi #if no arguments

while getopts "h?xf:" opt; do
    case "$opt" in
    h|\?) quit ;;
    x)  use_py=false ;;
    f)  speed=$OPTARG ;;
    esac
done

if [[ $speed =~ ^-?[0-9]+$ ]]; then true; #check for valid value (if number)
else echo -e "ERROR: please insert a value to set fan speed."; quit; #if NaN or blank
fi 

shift $((OPTIND-1))
[ "$1" = "--" ] && shift

max_sp=$(smc -k F0Mx -r | cut -d ' ' -f 7)
min_sp=$(smc -k F0Mn -r | cut -d ' ' -f 7)
while [ [$speed_ok] ]; do
	if [[ $speed -gt $max_sp ]]; then
		echo -e "\nERROR: selected speed too high (max speed = $max_sp""rpm)"
		echo -e "Please enter target fan speed ['q' to quit]: \c"
		read speed

		if [[ $speed == 'q' ]]; then exit 0;
		elif [[ -z $speed ]]; then speed=$(expr $max_sp + 1);
		elif [[ $speed =~ ^-?[0-9]+$ ]]; then true; #check for valid value (if number)
		else speed=$(expr $max_sp + 1);
		fi

	elif [[ $speed -lt $min_sp ]]; then
		echo -e "\nERROR: selected speed too low (min speed = $min_sp""rpm)"
		echo -e "Please enter target fan speed ['q' to quit]: \c"
		read speed
		
		if [[ $speed == 'q' ]]; then exit 0;
		elif [[ -z $speed ]]; then speed=$(expr $min_sp - 1);
		elif [[ $speed =~ ^-?[0-9]+$ ]]; then true; #check for valid value (if number)
		else speed=$(expr $min_sp - 1);
		fi

	else speed_ok=true; fi
done

if [ $use_py == true ]; then
	orig_speed=$speed;
	speed=$(python -c "print hex($speed << 2)")
fi

smc -k F0Tg -w $speed
smc -k F1Tg -w $speed
[[ $use_py == true ]] && str="Fan Speed set to target ~""$orig_speed""rpm" || str="Fan Speed set to target $speed""rpm"
echo -e $str
exit 0;
