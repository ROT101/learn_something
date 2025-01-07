#!/usr/bin/env bash

set -e  # Exit immediately if a command fails

# Function to check command success
check_command() {
  if [ $? -ne 0 ]; then
    echo "Error: Command '$1' failed." >&2
    exit 1
  else
    echo "Success: Command '$1' executed successfully."
  fi
}


if [[ -z $1 ]]
then
	echo "$? error:interface requiered"
	exit 1
fi
# Bring the network interface down
echo "Bringing down the network interface..."
ifconfig $1 down
check_command "ifconfig $1  down"

# Change the IP address
echo "Assigning a new IP address..."
ip addr add 192.168.1.150/24 dev $1
check_command "ip addr add 192.168.1.150/24 dev $1"

# Randomize the MAC address
echo "Randomizing the MAC address..."
macchanger -r $1
check_command "macchanger -r $1"

# Bring the network interface up
echo "Bringing up the network interface..."
ifconfig $1 up
check_command "ifconfig wlan0 up"

echo "All commands executed successfully!"

