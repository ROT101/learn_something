#!/bin/bash

# Define log file
LOGFILE="/var/log/service_status.log"
echo "Starting service status check: $(date)" | tee -a "$LOGFILE"

# List of critical services to check
SERVICES=("apache2" "mysql" "ssh")  # Modify as needed

# Function to check and restart services
check_service() {
    local service=$1
    if systemctl is-active --quiet "$service"; then
        echo "$service is running." | tee -a "$LOGFILE"
    else
        echo "$service is down. Restarting..." | tee -a "$LOGFILE"
        systemctl restart "$service"
        if systemctl is-active --quiet "$service"; then
            echo "$service restarted successfully." | tee -a "$LOGFILE"
        else
            echo "Failed to restart $service." | tee -a "$LOGFILE"
        fi
    fi
}

# Iterate through services and check status
for service in "${SERVICES[@]}"; do
    check_service "$service"
done

# Completion message
echo "Service status check completed: $(date)" | tee -a "$LOGFILE"

exit 0
