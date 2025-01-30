#!/usr/bin/env bash

set -e  # Exit immediately if a command fails 

# makes contenet bold
F_BOLD="\033[1m\$" 
# underlins content
F_UNDERLINED="\033[4m\$"
# colors contens lime
C_LIME="\033[38;5;10m\$"
# removes colour from content
NC='\033[0m'

# Function to check command if the is successful 
check_command() {
  if [ $? -ne 0 ]; then #if the last command is not equal to zero then
    echo "Error: Command '$1' failed." >&2  # { >&2 } means redirect the output to stderr
    exit 1 # exit with code error 1
  else
    # $1 in a function allows for you to add an argument that will run within the function
    echo -e " $F_BOLD $F_UNDERLINED $C_LIME Success: Command '$1' executed successfully.$NC" 
  fi
}

if [[ -z $1 ]] # if argument(interface) is empty then
then
	echo "$? error:interface requiered" 
	exit 1
fi
# Bring the network interface down
echo "Bringing down the network interface..."
ifconfig $1 down # brings down interface
check_command "ifconfig $1  down"

# Change the IP address
echo "Assigning a new IP address..."
ip addr add 192.168.1.150/24 dev $1 #changes ip address
check_command "ip addr add 192.168.1.150/24 dev $1"

# Randomize the MAC address
echo "Randomizing the MAC address..."
macchanger -r $1 # chooses random mac address 
check_command "macchanger -r $1"

# Bring the network interface up
echo "Bringing up the network interface..."
ifconfig $1 up #brings interface up
check_command "ifconfig $1 up"

echo "All commands executed successfully!"

