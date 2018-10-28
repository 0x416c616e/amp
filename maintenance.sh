#!/bin/bash
#maintenance.sh
#script for automating maintenance and update stuff on the computer
#perhaps I should make a mac os x version of this at some point?

error_value=none #functions will define this later
function exit_message()
{
	printf "Error code: $error_value\nExiting now\nPress any key to continue"
	sleep 1
	read whatever
	exit
}

#TO-DO LIST IS ALL THE WAY AT THE BOTTOM
#GENERAL INFO AND RELEASE NOTES ARE NEAR THE TOP
#FUNCTIONS ARE AFTER RELEASE STUFF
#FUNCTIONS ARE INVOKED AT THE END

#BEGIN NETWORKING SETUP
echo "be sure to edit the defaultGatewayAddress and modemAddress settings in the shell script before running"
defaultGatewayAddress="10.48.96.1" #put the default gateway here
modemAddress="192.168.100.1" #put the modem address here
networkInfoEcho() #invoke this function to troubleshoot network stuff
{
	echo "The following networking information is specified as follows"
	sleep 1
	echo "Default gateway:"
	echo $defaultGatewayAddress
	sleep 0.5
	echo "Modem address:"
	echo $modemAddress
	sleep 0.5
	echo ""
	#^NOT YET IMPLEMENTED
	echo "(remove this text if/when these features are fully finished)"
	sleep 4
}

function networkIfconfigInfo() #displays info about networking stuff
{
	echo "Wireless networking settings:"
	/sbin/ifconfig wlan0
}

#END NETWORKING SETUP

############################################################
#
# ------
#           _             _                                
#     /\   | |           ( )                               
#    /  \  | | __ _ _ __ |/ ___                            
#   / /\ \ | |/ _` | '_ \  / __|                           
#  / ____ \| | (_| | | | | \__ \                           
# /_/  __\_\_|\__,_|_| |_| |___/                           
# |  \/  |     (_)     | |                                 
# | \  / | __ _ _ _ __ | |_ ___ _ __   __ _ _ __   ___ ___ 
# | |\/| |/ _` | | '_ \| __/ _ \ '_ \ / _` | '_ \ / __/ _ \
# | |  | | (_| | | | | | ||  __/ | | | (_| | | | | (_|  __/
# |_|__|_|\__,_|_|_|_|_|\__\___|_| |_|\__,_|_| |_|\___\___|
#  / ____|         (_)     | |                             
# | (___   ___ _ __ _ _ __ | |_                            
#  \___ \ / __| '__| | '_ \| __|                           
#  ____) | (__| |  | | |_) | |_                            
# |_____/ \___|_|  |_| .__/ \__|                           
#                    | |                                   
#                    |_|  
# ------
# 
# NOTE: THIS PROGRAM IS INTENDED TO BE LOCATED
# FROM THE /root DIRECTORY
# SO IF YOU COPY IT TO ANOTHER COMPUTER
# MAKE SURE YOU EITHER SAVE IT IN /root
# OR CHANGE THE SCRIPT ACCORDINGLY
# ALSO IT MUST BE RUN AS ROOT AS WELL
# CONSIDER ADDING A NON-ROOT ALIAS FOR MAINTENANCE
# THAT SAYS "MUST BE RUN AS ROOT"
# AND ONLY MAKE THE TRUE ALIAS FOR ROOT
#
# 
# ~~~~~~~~~~ 
# SOFTWARE DEPENDENCIES:
# GNU/LINUX WITH ALL STANDARD UTILITIES
# BASH
# CLAMAV
# RKHUNTER
# APT PACKAGE MANAGER (DEBIAN/UBUNTU/MINT/ETC)
# SPEEDTEST-CLI
# ~~~~~~~~~~
# 
# AS OF OCTOBER 9TH 2015, I WILL START ADDING NOTES HERE TO
# INCLUDE INFORMATION ABOUT UPDATES TO THIS PROGRAM
# THIS PROJECT HAS SEEN IMMENSE SCOPE CREEP
# WHAT WAS ORIGINALLY INTENDED TO BE A SIMPLE UPDATE SCRIPT
# IS NOW SIGNIFICANTLY LARGER AND MORE COMPLICATED THAN IT
# USED TO BE.
# 
# 
# RELEASE NOTES:
# current version:
versionNumber="0.7a_april_3_2016" #syntax: X.Xa_month_day_year
#version number is very important for archival/troubleshooting purposes
#uncomment next line to test:
#echo "testing version number: $versionNumber"
#
#
#

############################################################
#~~~~~~~~~~
#COLOR NOTES:
#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37
#example:
#RED='\033[0;31m'
#NC='\033[0m'
#echo -e "${RED}hi${NC}"
#~~~~~~~~~~

TEXTCOLOR=WHITE #WHITE or BLACK only; all caps
#defining all the colors used in this script
RED='\033[0;31m'
if [[ $TEXTCOLOR == BLACK ]];
then
	BLACK='\033[0;30m' #change 0;30 to 1;37 instead for white
	echo "black text echo debug" #remove later
	sleep 1
elif [[ $TEXTCOLOR == WHITE ]];
then					#testing; not actually white right now
	BLACK='\033[0;37m' 		#actually white; half-assed late implementation
	echo "white text echo debug"    #don't feel like changing all instances of BLACK to WHITE
	sleep 1				#but maybe I should later... and just refactor the entire
else					#program and remove the excess comments too
	error_value=COLOR
	exit_message
	exit
fi
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
ORANGE='\033[0;33m'
#might want to change black to white if using a terminal with a black background
#this was made for a terminal window which is configured to have black text on a
#white background, so just 


#newer banner function

function bannerFunctionNew()
{
	clear
	#choose something with random numbers or time nanoseconds or something
	#then call a function which echos the "alan's maintenance text"
	#but do that stuff in separate functions
	#then just invoke them here
	#based on random choosing stuff that I need to do above
	bannerDecider=$(shuf -i 1-5 -n 1)
	if [[ $bannerDecider == 1 ]] #look at how I refactored the ping stuff and try to
								 #implement something similar in this function
	then
		bannerTextOne
	elif [[ $bannerDecider == 2 ]]
	then
		bannerTextTwo
	elif [[ $bannerDecider == 3 ]]
	then
		bannerTextThree
	elif [[ $bannerDecider == 4 ]]
	then
		bannerTextFour
	elif [[ $bannerDecider == 5 ]]
	then
		bannerTextFive
	else
		echo "out of range" #you should never ever see this
	fi
	#one through five for five different banner options
	sleep 5
	echo -e "${RED}CTRL + C TO EXIT PROGRAM${BLACK}"
	sleep 2
	echo -e "${BLUE}version $versionNumber${BLACK}"
	sleep 1
	lineCounter=$(cat /root/maintenance.sh | wc -l | head -n 1) #number of lines of code in the script (works only if in the proper directory; not portable)
	echo -e "${BLUE}This program is currently $lineCounter lines of code${BLACK}"
	echo -e "${BLUE}View changelog.txt for update notes or to-do_list.txt for future features${BLACK}"
	sleep 1
	echo -e "${GREEN}Programmed by Alan${BLACK}" #use -e flag when doing colors
	sleep 1
	echo -e "${RED}THIS SOFTWARE IS PROVIDED \"AS IS\" WITHOUT WARRANTY${BLACK}"
	sleep 1
}


function bannerTextOne() #this is basically the stuff I did in the old one but now it's in a different function and lacks certain things, just the echo lines
{
        echo -e "${BLUE}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
        echo -e "▓                             ▓"
        echo -e "▓ ${PURPLE}Alan's${BLUE}                      ▓"
        echo -e "▓ ${CYAN}══════  ${PURPLE}Maintenance${BLUE}         ▓"
        echo -e "▓        ${CYAN} ═══════════  ${PURPLE}Script${BLUE} ▓"
        echo -e "▓                     ${CYAN} ══════${BLUE} ▓"
        echo -e "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${BLACK}"
	
}

function bannerTextTwo()
{
	#tested and works
	#displays blue ascii art banner
echo -e -n "${CYAN}"
cat << "EOF"
           _             _                                
     /\   | |           ( )                               
    /  \  | | __ _ _ __ |/ ___                            
   / /\ \ | |/ _` | '_ \  / __|                           
  / ____ \| | (_| | | | | \__ \                           
 /_/  __\_\_|\__,_|_| |_| |___/                           
 |  \/  |     (_)     | |                                 
 | \  / | __ _ _ _ __ | |_ ___ _ __   __ _ _ __   ___ ___ 
 | |\/| |/ _` | | '_ \| __/ _ \ '_ \ / _` | '_ \ / __/ _ \
 | |  | | (_| | | | | | ||  __/ | | | (_| | | | | (_|  __/
 |_|__|_|\__,_|_|_|_|_|\__\___|_| |_|\__,_|_| |_|\___\___|
  / ____|         (_)     | |                             
 | (___   ___ _ __ _ _ __ | |_                            
  \___ \ / __| '__| | '_ \| __|                           
  ____) | (__| |  | | |_) | |_                            
 |_____/ \___|_|  |_| .__/ \__|                           
                    | |                                   
                    |_|                                 
EOF
echo -e -n "${BLACK}"
}

function bannerTextThree()
{

echo -e -n "${ORANGE}"
cat << "EOF"
    _   _           _                             
   /_\ | |__ _ _ _ ( )___                         
  / _ \| / _` | ' \|/(_-<                         
 /_/ \_\_\__,_|_||_|_/__/                         
 |  \/  |__ _(_)_ _| |_ ___ _ _  __ _ _ _  __ ___ 
 | |\/| / _` | | ' \  _/ -_) ' \/ _` | ' \/ _/ -_)
 |_|_ |_\__,_|_|_||_\__\___|_||_\__,_|_||_\__\___|
 / __| __ _ _(_)_ __| |_                          
 \__ \/ _| '_| | '_ \  _|                         
 |___/\__|_| |_| .__/\__|                         
               |_|        
EOF
echo -e -n "${BLACK}"

}

function bannerTextFour()
{
echo -e -n "${BLUE}"
cat << "EOF"
     .     .                 ,                                          
    /|     |     ___  , __   /   ____                                   
   /  \    |    /   ` |'  `.    (                                       
  /---'\   |   |    | |    |    `--.                                    
,'      \ /\__ `.__/| /    |   \___.'                                   
                                                                        
 __   __                  .                                             
 |    |    ___  ` , __   _/_     ___  , __     ___  , __     ___    ___ 
 |\  /|   /   ` | |'  `.  |    .'   ` |'  `.  /   ` |'  `. .'   ` .'   `
 | \/ |  |    | | |    |  |    |----' |    | |    | |    | |      |----'
 /    /  `.__/| / /    |  \__/ `.___, /    | `.__/| /    |  `._.' `.___,
                                                                        
   _____                        .                                       
  (        ___  .___  ` \,___, _/_                                      
   `--.  .'   ` /   \ | |    \  |                                       
      |  |      |   ' | |    |  |                                       
 \___.'   `._.' /     / |`---'  \__/                                    
                        \                                               
EOF
echo -e -n "${BLACK}"
}

function bannerTextFive()
{
echo -e -n "${GREEN}"
cat << "EOF"
_____________             ___                                           
___    |__  /_____ ________( )_______                                   
__  /| |_  /_  __ `/_  __ \|/__  ___/                                   
_  ___ |  / / /_/ /_  / / /  _(__  )                                    
/_/  |_/_/  \__,_/ /_/ /_/   /____/                                     
                                                                        
______  ___      _____       _____                                      
___   |/  /_____ ___(_)________  /__________________ __________________ 
__  /|_/ /_  __ `/_  /__  __ \  __/  _ \_  __ \  __ `/_  __ \  ___/  _ \
_  /  / / / /_/ /_  / _  / / / /_ /  __/  / / / /_/ /_  / / / /__ /  __/
/_/  /_/  \__,_/ /_/  /_/ /_/\__/ \___//_/ /_/\__,_/ /_/ /_/\___/ \___/ 
                                                                        
________            _____        _____                                  
__  ___/_______________(_)_________  /_                                 
_____ \_  ___/_  ___/_  /___  __ \  __/                                 
____/ // /__ _  /   _  / __  /_/ / /_                                   
/____/ \___/ /_/    /_/  _  .___/\__/                                   
                         /_/         
EOF
echo -e -n "${BLACK}"
}

#prettyLoader: adds pauses (for readability/not scrolling by too fast)
#and also makes it look cooler and makes it look like it's doing more
function prettyLoader()
{
	function loadingBarPart()
	{
		for i in `seq 1 26`;
		do
			echo -n "═"
			sleep 0.05
		done
	}
	loadingBarPart
	echo -e "${GREEN} [Proceeding...]${BLACK}"	
	sleep 0.5
}

#cdFunction: changing to the proper directory for the commands
function cdFunction()
{
	echo "Changing directory..."
	cd /
}
function cdFunction2()
{
	cd /
}
#cdCheck: just cd / and pwd
#cdCheckVar: stores pwd output in variable
#this is not a nested function because it is
#used by a later function
#chCheckFunction: checking to see if directory is correct
#kinda pointless after I changed the program but whatever
#keep it in anyway because it looks like the program is
#doing more than it really is
#the cd functions changed a lot over the course of making
#this program and I could redo all of it if I really
#want to but I don't feel like it
function cdCheck()
{
	cd /
	pwd
}
cdCheckVar=$(cdCheck)
function cdCheckFunction()
{
	cdFunction2
	if [[ "$cdCheckVar" == "/" ]]
	then
		echo "Current directory is correct."
	else
		echo "ERROR: The current directory is incorrect."
		echo "Exiting now."
		exit
	fi
}
#whoamiText: text before whoamiFunction; has prettyLoader in between
#to make it look like it's doing something
function whoamiText()
{
	echo "Checking user..."
}
#whoamiFunction: checking to make sure user is root
function whoamiFunction()
{
	function whoamiCheck()
	{
		whoami
	}

	whoamiCheckVar=$(whoamiCheck)

	if [[ "$whoamiCheckVar" == "root" ]]
	then
		echo "Currently logged in as root."
	else
		echo -e "${RED}ERROR: You are not logged in as root.${BLACK}"
		echo "You need to be logged in as root to use this script."
		echo "Exiting now."
		exit
	fi
}
#aptUpdateFunction: updates with apt package manager
function aptUpdateFunction()
{
	echo "Updating software..."
 	sleep 0.5
	apt-get --yes --force-yes update
}
#aptUpgradeFunction: upgrades with apt package manager
function aptUpgradeFunction()
{
	echo "Upgrading software..."
	sleep 0.5
	apt-get --yes --force-yes upgrade
}
function freshclamStop()
{
	echo "Stopping antivirus..."
	sleep 1 #sleep 1 when slightly big output but no action required from user
	/etc/init.d/clamav-freshclam stop
}
function freshclamFunction()
{
	echo "Updating antivirus..."
	sleep 1 # sleep 1 when slightly big output but no action required from user
	freshclam
}
function freshclamStart()
{
	echo "Restarting antivirus..."
	sleep 1
	/etc/init.d/clamav-freshclam start
}

function clamscanFunction()
{
	cdFunction2
	echo "Beginning recursive virus scan"
	sleep 0.5
	echo "In directory $cdCheckVar"
	sleep 0.5
	echo "This will take a while."
	sleep 0.5
	echo "I suggest doing something else"
	sleep 0.5
	echo "And checking back later."
	echo "Just because there is no output"
	sleep 0.5
	echo "Does not mean the program is doing nothing."
	sleep 5
	echo "But you will see a message once it has finished."
	clamscan --recursive --infected 2>/dev/null	
}
function finalLazy()
{
	echo "Check the line above that says"
	sleep 0.5
	echo "Infected files:"
	sleep 0.5
	echo "And make sure it says 0."
	sleep 0.5
	echo "I'm too lazy to finish the script"
	sleep 0.5
	echo "So just manually check it."
	echo "Also, the output from the antivirus"
	sleep 0.5
	echo "program is pretty big, so let"
	sleep 0.5
	echo "Let me know if there's a problem."
	sleep 15
}
function noteText()
{
	echo "This maintenance script requires an internet connection"
	echo "in order to function properly. Be sure to check the"
	echo "lower right-hand corner."
	sleep 5
	echo "And remember, you can exit the program at any time"
	echo "by hitting ctrl + c"
	echo "For example, if there is no network connection"
	echo "and you want to halt the program to look into the"
	echo "network issues before proceeding."
	sleep 5
}
function pingText() #notice text before invocation of individual ping functions
{
	echo "Make sure packet loss is 0%."
	sleep 0.5
	echo "0% loss means fine"
	sleep 0.5
	echo "100% packet loss means no connection"
	sleep 0.5
	echo "Anything in between means poor connection"
	sleep 0.5
	echo "Also keep in mind that the \"OK\" just means"
	sleep 0.5
	echo "that the program has proceeded to the next"
	sleep 0.5	
	echo "function, not that everything is error-free."
	sleep 3
}

function ping_test()
{
	declare -a description_array=(
		"loopback interface"
		"router connection"
		"modem connection"
		"external connectivity"
		"DNS resolution"
	)

	declare -a address_array=(
		"127.0.0.1"
		"10.48.96.1"
		"192.168.100.1"
		"8.8.8.8"
		"www.google.com"
	)

	for ((i=0;i<${#description_array[@]};++i));
	do
		printf "Checking the %s: %s\n" "${description_array[i]}" "${address_array[i]}"
		ping -c 4 ${address_array[i]} | tail -n 2
		#sleep 1
		#prettyLoader
	done
}

#october 18th: added speedtest-cli stuff
#note: means that speedtest-cli package must be installed on system in order for this to work
#so just comment out the function at the end if you don't want it to run
function speedtestCheck()
{
	echo "Testing download and upload speeds:"
	sleep 1
	speedtest-cli
}


#relatively new (octobor 9th 2015) rkhunter stuff
#have to explain to dad about new stuff


#this first function just updates rkhunter
function rkhUpdate()
{
	echo "Updating rkhunter..."
	rkhunter --update
	rkhunter --propupd
}

#this second rkhunter-related function does the actual rkhunter stuff
function rootkitCheck()
{
	#basic explanation stuff for user to see
	echo "This next part will check for rootkits"
	#make sure that /dev/shm/pulse-shm-* is allowed (uncommented) in rkhunter.conf
	sleep 3
	rkhunter -c --sk #rkhunter check with flag to skip keypresses
	sleep 10
}

function antivirusArt()
{
echo "Finished with network testing and updates. Now moving on"
echo "to virus and rootkit checking, keeping this computer safe."
sleep 5
cat << "EOF"
       _,.
     ,` -.)
    '( _/'-\\-.               
   /,|`--._,-^|            ,     
   \_| |`-._/||          ,'|       
     |  `-, / |         /  /      
     |     || |        /  /       
      `r-._||/   __   /  /  
  __,-<_     )`-/  `./  /
 '  \   `---'   \   /  / 
     |           |./  /  
     /           //  /     
 \_/' \         |/  /         
  |    |   _,^-'/  /              
  |    , ``  (\/  /_        
   \,.->._    \X-=/^         
   (  /   `-._//^`  
    `Y-.____(__}              
     |     {__)           
           ()`     
EOF
sleep 15
}
function finalMessage()
{
	sleep 5
	echo "That's all for now."
	sleep 1
	echo "Remember that it's up to you, the user,"
	sleep 1
	echo "to interpret the output of this program"
	sleep 1
	echo "and look into any possible problems."
	sleep 1
	echo "Scroll up and review what happened."
	sleep 1
	echo -e "Keep in mind that all the \"${GREEN}OK${BLACK}\" means is"
	sleep 1
	echo "that the program proceeded to the next function."
	sleep 1
	echo "In many cases, this program will keep on going even if"
	sleep 1
	echo "something goes wrong because I didn't program in functionality"
	sleep 1
	echo "to stop or give error messages when things go wrong because"
	sleep 1
	echo "I'm kinda lazy and this is a rushed project."
	sleep 1
}

debugModeMenu() {
    echo "debugModeMenu function:"
    sleep 0.5
    echo "this hasn't been made yet"
    sleep 0.5
    echo "just a placeholder for now"
    sleep 0.5
}

function MasterProductionFunction() #contains all function calls for non-debug things
{
	#ping variable substitution thing is not finished yet
	#ALL FUNCTION CALLS GO HERE
	#beginning stuff
	bannerFunctionNew
    echo "You chose not to enter debug mode. If you want to enter debug mode, then ^C, !!, and hit any key"
	prettyLoader
	noteText
	prettyLoader
	#network info display
	networkInfoEcho
	prettyLoader
	networkIfconfigInfo
	prettyLoader
	#network testing stuff
	pingText
	prettyLoader
	ping_test
	prettyLoader
	#speedtest
	speedtestCheck
	prettyLoader
	#changing dir, checking dir, checking user, etc
	cdFunction
	prettyLoader
	cdCheckFunction
	prettyLoader
	whoamiText
	prettyLoader
	whoamiFunction
	prettyLoader
	#updating software
	aptUpdateFunction
	prettyLoader
	aptUpgradeFunction
	prettyLoader
	#anti-rootkit stuff
	rkhUpdate
	prettyLoader
	rootkitCheck
	prettyLoader
	#antivirus stuff - ascii art, stopping, updating, and starting av
	#then doing a virus scan on all files
	antivirusArt
	prettyLoader
	freshclamStop
	prettyLoader
	freshclamFunction
	prettyLoader
	freshclamStart
	prettyLoader
	clamscanFunction #comment out this line if you want to just test the script, as this part is the most time-consuming
	prettyLoader
	#ending stuff
	finalLazy
	prettyLoader
	finalMessage
}

#debugKeyPress:
#if the user presses any key, they enter debug mode
#if not, the program goes about its normal functions
debugKeyPress() {
was_key_pressed=

for (( i=5; i>0; i--)); do
    printf "\rHit any key to enter debug mode or wait $i seconds and the program will start normally..."
    read -s -n 1 -t 1 key
    if [ $? -eq 0 ]
    then
        was_key_pressed="true"
        break
    fi
done
echo

if [ "${was_key_pressed}" ]; then
    echo "Entering debug mode..."
    debugModeMenu
else
    echo "Resuming..."
    MasterProductionFunction
fi
}
debugKeyPress
