#!/bin/bash

##    'airportd' command for bash
##    Written by Jake Tesler

#--------------------



case $1 in
	
	on)
		networksetup -setairportpower en1 on
		echo "airport on"
		;;
		
	off)
		networksetup -setairportpower en1 off
		echo "airport off"
		;;
	
	cycle)
		networksetup -setairportpower en1 off
		sleep 4
		networksetup -setairportpower en1 on
		echo "airport cycled off-on."
		;;
		
	*)
		echo -e "\nTurns airport on or off."
		echo -e "\nUsage: \c"
		echo -e "airportd [on | off | cycle]"
		echo -e ""
		;;
	
esac