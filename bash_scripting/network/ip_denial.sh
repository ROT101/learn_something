#!/bin/env bash

#check argument argument 
if [[ -z $1 ]]
then
    echo "error: ip address required"
    exit 1 
fi

# Deny traffic from a specific IP address
ip_address=$1

# Deny all traffic from the specific IP
ufw deny from $ip_address

echo "Denied traffic from $ip_address"