#!/bin/bash

##  'stop' command for bash
##  Written by Jake Tesler
##  v2
#--------------------



case $1 in
	-u )
		pid=$(ps -A | grep -m1 "$2" | awk '{print $1}')
		pid2=$(ps -A | grep -m1 "$2" | awk '{print $1}')
		if [ $pid != $pid2 ]; then
			echo -e "ERROR: App Not Running"
			exit 0;
		fi
		echo -e "Unpause: "$2" (kill -CONT "$pid")"
		kill -CONT $pid
		;;
	#-h )
	#	disphelp;
	#	;;
	*)
		pid=$(ps -A | grep -m1 "$1" | awk '{print $1}')
		pid2=$(ps -A | grep -m1 "$1" | awk '{print $1}')
		echo -e "Pause: "$1" (kill -STOP "$pid")"

		if [ $pid != $pid2 ]; then
			echo "ERROR: App Not Running"
			exit 0;
		fi
		kill -STOP $pid
		;;
esac