#/bin/env bash

# check if argument is given
if [ -z $1 ] 
then
    echo "error: enter number of log files to output"
    exit 1
fi

# display the last x number of lines in log file 
tail -n $1 /var/log/syslog