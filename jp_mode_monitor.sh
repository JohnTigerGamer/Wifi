#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
orangeColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "\n\n${redColour}[!]${endColour} ${grayColour}Operación abortada${endColour}\n"
  tput cnorm; exit 1
}
                                                                                        
# Ctrl+C
trap ctrl_c INT

tput -x clear

echo -e "${blueColour}"
echo -e "  ===================================================  "
echo -e "||       _       _        _______ _                  ||"
echo -e "||      | |     | |      |__   __(_)                 ||"
echo -e "||      | | ___ | |__  _ __ | |   _  __ _  ___ _ __  ||"
echo -e "||  _   | |/ _ \| '_ \| '_ \| |  | |/ _' |/ _ \ |__| ||"
echo -e "|| | |__| | (_) | | | | | | | |  | | (_| |  __/ |    ||"
echo -e "||  \____/ \___/|_| |_|_| |_|_|  |_|\__, |\___|_|    ||"
echo -e "||                                   __/ |           ||"
echo -e "||                                  |___/            ||"
echo -e "  ===================================================  "

echo -e "\n${endColour}"

echo -e "${blueColour}[+]${endColour}${grayColour} Ha continuación se activará la tarjeta en modo monitor${endColour}"
echo -ne "\n${blueColour}[+]${endColour}${grayColour} Indique el nombre de la interface de red -> ${endColour}${greenColour}" && read nombreInt
echo -e "${blueColour}[+]${endColour}${grayColour} ifconfig $nombreInt up${endColour}"
sudo ifconfig $nombreInt up
sleep 5
echo -e "${blueColour}[+]${endColour}${grayColour} rmmod r8188eu.ko${endColour}"
sudo rmmod r8188eu.ko
sleep 5
echo -e "${blueColour}[+]${endColour}${grayColour} modprobe 8188eu${endColour}"
sudo modprobe 8188eu
sleep 5
echo -e "${blueColour}[+]${endColour}${grayColour} iwconfig $nombreInt mode auto${endColour}"
sudo iwconfig $nombreInt mode auto
sleep 5
echo -e "${blueColour}[+]${endColour}${grayColour} ifconfig $nombreInt down${endColour}"
sudo ifconfig $nombreInt down
sleep 5
echo -e "${blueColour}[+]${endColour}${grayColour} iwconfig $nombreInt mode monitor${endColour}"
sudo iwconfig $nombreInt mode monitor
sleep 5
echo -e "${blueColour}[+]${endColour}${grayColour} ifconfig $nombreInt up${endColour}"
sleep 5
sudo ifconfig $nombreInt up
echo -e "${blueColour}[+]${endColour}${grayColour} Una vez terminada la configuración comprobamos el estado de la interfaz${endColour}"
sleep 5
iwconfig >temp.txt 2>&1
modoInt=$(cat temp.txt | grep wlan0 -A 1 | tail -n 1 | cut -d 'F' -f 1 | sed 's/ //g' | sed 's/Mode://g')
rm -r temp.txt
echo -e "${blueColour}[+]${endColour}${grayColour} El modo actual de la interface ${endColour}${blueColour}$nombreInt${endColour}${grayColour} es -> ${endColour}${greenColour}$modoInt${endColour}\n"

