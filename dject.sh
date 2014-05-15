#!/bin/bash

##  'dject' command for bash
##  Written by Jake Tesler
##  v2
#--------------------


disklist=$(diskutil list)

function ejectDiskWithName() {
	if [ -z "$disknum" ]; then		
		echo -e "\nDisk \"$diskname\" not found..."
		echo -e "\ndiskutil list"
		echo -e "$disklist"	
	else
		for i in $disknum 
		do
			echo -e "\n""diskutil eject $i"
			diskutil eject $i
		done
		echo -e "\n""diskutil list"
		diskutil list
	fi
}

case $1 in
	
	disk*)
		echo -e "\n""diskutil eject $1"
		diskutil eject $1
		echo -e "\n""diskutil list"
		diskutil list
		;;
		
	-n)
		diskname=$2
		disknum=$(echo "$disklist" | grep "$diskname" | tr -s ' ' | rev | cut -d ' ' -f1 | rev | cut -d 's' -f 1-2)
		ejectDiskWithName
		echo -e " "
		;;
		
	--name)
		diskname=$2
		disknum=$(echo $disklist | grep $diskname | tr -s ' ' | cut -d ' ' -f 7 | cut -d 's' -f 1-2)
		ejectDiskWithName
		echo -e " "
		;;
		
	*)
		echo -e "\nEjects disks."
		echo -e "Usage: \c"
		echo -e "dject disk# | dject -n (or --name) [VolumeName]"
		echo -e ""
		echo -e "\n""diskutil list"
		echo -e "$disklist"
		echo -e " "
		;;
	
esac