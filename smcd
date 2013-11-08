#!/bin/bash

##  'smcd' command for bash
##  Written by Jake Tesler

#--------------------

if [ -z "$1" ]; then
	echo -e "\n""Please insert a value to change to"
	echo -e "Usage: smcd (value)"
else
	echo -e "\n""smc -k F0Mn/F1Mn -w $1"
	smc -k F0Mn -w $1
	smc -k F1Mn -w $1
	echo -e "\n""Complete...Fan Speed set to $1"
	echo -e " "
fi