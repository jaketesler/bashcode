#!/bin/bash

##    'COMMAND NAME' command for bash
##    Written by Jake Tesler

#--------------------

DATEMODEXIT=$(date -j +"%m-%d-%C%y, %H:%M:%S")
CDLOC="/Volumes/Jumbo Shrimp"
CDCMDA=$(cd "$CDLOC")
CDCMDB=$(cd "$CDLOC" | grep 'no such file')

#on exit
trap 'echo -e "Interupt detected; stopping sequence...";echo -e "exiting "$DATEMODEXIT;echo "with exit status 5, exit "$?;cd;exit' INT


cd "$CDLOC" > /dev/null 2>&1
echo -e "\n"



while [ -z $CDCMB ];
do
	if [ ! -z $CDCMDB ]; then
		exit 0
	elif [ -z $CDCMDB ]; then
		echo alive > .alive.txt
		echo -e "$DATEMODEXIT"
		echo -e "Written...\c"
		sleep 1
		rm ./.alive.txt
		echo -e "Deleted\n"
		sleep 59
	fi	
done