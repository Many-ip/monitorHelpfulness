#!/bin/bash
#Init Monitor
function initMonitor (){
	if [ $EUID -ne 0 ]
	then echo "Please run as root"
	else
		if [ -z $1 ]
		then 
			echo "Please puts interface wirelees"
			echo
			if [[ $(ifconfig | grep wl* | cut -d ' ' -f 1| rev |cut -c 2- |rev) ]]
			then 
				echo "Some interface that could use wirelees"
				echo
				ifconfig | grep wl* | cut -d ' ' -f 1| rev |cut -c 2- |rev
			else
				echo "Please check interfaces with iwconfig compatibility"
			fi
		else 
			if [[ $(ifconfig | grep $1 | cut -d ' ' -f 1| rev |cut -c 2- |rev) ]]
			then
				if ! command -v macchanger &> /dev/null
			       	then	
				 raed -p  "macchanger is not installed, you want to install it? (y/n) " macChangerInstaller
						macChangerInstaller= $macChangerInstaller | tr '[:upper:]' '[:lower:]'
					if [ $macChangerInstaller -eq "y" ]
					then
						apt install macchanger
					elif [ $macChangerInstaller -eq "n" ]
					then 
						echo -e "\e[1emAlert, your current  MAC is the permanent MAC.]"
					else
						echo "Error, you not put y or n"
						exit 1
					fi
					
				fi


			fi
		fi	
#MAC Change
	fi

}

#Finish Monitor

#MAC Restart

