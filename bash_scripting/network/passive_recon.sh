#!/bin/env bash

F_BOLD="\033[1m\$"
F_UNDERLINED="\033[4m\$"
C_LIME="\033[38;5;10m\$"
NC='\033[0m'

if [[ -z $1 ]]
then
    echo "error: domain name required"
    exit 1 
fi

check_command() {
  if [ $? -ne 0 ]; then #if the last command is not equal to zero then
    echo "Error: Command '$1' failed." >&2  # { >&2 } means redirect the output to stderr
    exit 1 # exit with code error 1
  else
    echo -e " $F_BOLD $F_UNDERLINED $C_LIME Success: Command '$1' executed successfully.$NC"
  fi
}

whatweb $1
sleep 3
check_command "whatweb $1 "
echo
whois $1
sleep 3
check_command "whois $1 "
echo
dig $1
sleep 3
check_command "dig $1 "
echo
wig -N -u $1 
check_command "wig -N -u $1 "