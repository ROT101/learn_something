#!/bin/env bash

# [read] is to accept input from user and [-p] is to display text for user to see during the process  

# Function to display the menu options
show_menu() {
    echo "UFW Management Script"
    echo "1. Allow traffic from a specific IP to a port"
    echo "2. deny traffic from a specific IP to a port"
    echo "3. Enable UFW"
    echo "4. Disable UFW"
    echo "5. Check UFW status"
    echo "6. Allow all traffic from a specific IP"
    echo "7. Deny all traffic from a specific IP"
    echo "8. Delete a specific UFW rule"
    echo "9. Allow a specific service"
    echo "10. Deny a specific service"
    echo "11. Exit"
}

# Function to allow traffic from a given IP to a port
allow_traffic() {
    read -p "Enter the IP address: " ip_address
    read -p "Enter the port number: " port_number
    # execution command
    sudo ufw allow from $ip_address to any port $port_number
    echo "Rule added: Allow traffic from $ip_address to port $port_number"
}

# Function to deny traffic to a given port
deny_traffic() {
    read -p "Enter the IP address: " ip_address
    read -p "Enter the port number: " port_number
    # execution command
    sudo ufw deny from $ip_address to any port $port_number
    echo "Rule added: deny traffic from $ip_address to port $port_number"
}

# Function to enable UFW
enable_ufw() {
    # execution command
    sudo ufw enable
    echo "UFW is now enabled"
}

# Function to disable UFW
disable_ufw() {
    # execution command
    sudo ufw disable
    echo "UFW is now disabled"
}

# Function to show UFW status
check_status() {
    sudo ufw status
}

# Function to allow all traffic from a given IP
allow_all_from_ip() {
    read -p "Enter the IP address: " ip_address
    # execution command
    sudo ufw allow from $ip_address
    echo "Rule added: Allow all traffic from $ip_address"
}

# Function to deny all traffic from a specific IP
deny_all_from_ip() {
    read -p "Enter the IP address: " ip_address
    # execution command
    sudo ufw deny from $ip_address
    echo "Rule added: Deny all traffic from $ip_address"
}

# Function to delete a specific UFW rule
delete_rule() {
    read -p "Enter the rule number to delete: " rule_number
    # execution command
    sudo ufw delete $rule_number
    echo "Rule $rule_number deleted"
}

# Function to allow a given service
allow_service() {
    echo "Available services: SSH, HTTP, HTTPS, FTP, SMTP, DNS, etc."
    read -p "Enter the service name: " service_name
    # execution command
    sudo ufw allow $service_name
    echo "Rule added: Allow $service_name"
}

# Function to deny a given service
deny_service() {
    echo "Available services: SSH, HTTP, HTTPS, FTP, SMTP, DNS, etc."
    read -p "Enter the service name: " service_name
    # execution command
    sudo ufw deny $service_name
    echo "Rule added: Deny $service_name"
}

allow_logging() {
    # execution command
    ufw logging on
    echo "UFW logging enabled"
}

# loop to run program
while true; do
    show_menu
    read -p "Enter your choice [1-11]: " choice
    # case to run chosen option
    case $choice in
        1)
            allow_traffic
            ;;
        2)
            deny_traffic
            ;;
        3)
            enable_ufw
            ;;
        4)
            disable_ufw
            ;;
        5)
            check_status
            ;;
        6)
            allow_all_from_ip
            ;;
        7)
            deny_all_from_ip
            ;;
        8)
            delete_rule
            ;;
        9)
            allow_service
            ;;
        10)
            deny_service
            ;;
        11)
            echo "Exiting script..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

    echo
    sleep 1
done
