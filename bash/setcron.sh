#!/bin/bash

# Define log file
LOGFILE="/var/log/scheduled_tasks.log"
echo "Scheduled Tasks Manager started: $(date)" | tee -a "$LOGFILE"

# Function to list cron jobs
list_cron_jobs() {
    echo "Current cron jobs:" | tee -a "$LOGFILE"
    crontab -l 2>/dev/null | tee -a "$LOGFILE"
}

# Function to add a cron job
add_cron_job() {
    echo "Enter the cron schedule (e.g., '0 2 * * *' for daily at 2 AM):"
    read schedule
    echo "Enter the command to execute:"
    read command
    (crontab -l 2>/dev/null; echo "$schedule $command") | crontab -
    echo "Cron job added: $schedule $command" | tee -a "$LOGFILE"
}

# Function to remove a cron job
remove_cron_job() {
    echo "Current cron jobs:" | tee -a "$LOGFILE"
    crontab -l 2>/dev/null | nl
    echo "Enter the line number of the job to remove:"
    read job_number
    crontab -l 2>/dev/null | sed "${job_number}d" | crontab -
    echo "Cron job removed." | tee -a "$LOGFILE"
}

# Main menu
echo "Choose an option:"
echo "1) List cron jobs"
echo "2) Add a cron job"
echo "3) Remove a cron job"
read choice

case $choice in
    1) list_cron_jobs ;;
    2) add_cron_job ;;
    3) remove_cron_job ;;
    *) echo "Invalid option." | tee -a "$LOGFILE" ;;
esac

exit 0
