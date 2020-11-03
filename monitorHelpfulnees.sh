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
				 read -p  "macchanger is not installed, you want to install it? (y/n) " macChangerInstaller
						macChangerInstaller= $macChangerInstaller | tr '[:upper:]' '[:lower:]'
					if [ $macChangerInstaller = y ]
					then
						apt install macchanger -n
					elif [ $macChangerInstaller = n ]
					then 
						echo -e "\e[1mAlert, your current  MAC is the permanent MAC.]\e[0m"
					else
						echo "Error, you not put y or n"
					fi
				#now install airmon-ng and start mode monitor
					if ! command aircrack-ng -v &> /dev/null
					then 
						echo "aircrack-ng is not instaled"
						echo "Updating..."
						apt update &> /dev/null
						echo "Installing aircrack-ng..."
						apt install -y aircrack-ng &> /dev/null
						echo "The program was installed"
					fi
					echo "Putting $1 in mode monitor..."
					airmon-ng start $1
					airmon-ng check kill 
					if command macchanger -v &> /dev/null
					then
						#MAC Change
						echo "Mac Changer..."
						ifconfig "$1mon" down
						macchanger -a $1
						ifconfig "$1mon" up
					fi
					airodump-ng "$1mon"
				fi
			else
				echo "The interface not exixst"
			fi
		fi	
	fi

}

#Finish Monitor
function finMonitor(){
	if [ -z $1 ]
	then
	       	
	fi
#MAC Restart
}
