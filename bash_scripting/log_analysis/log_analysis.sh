#!/bin/env bash

# path to log file
log_file="/var/log/syslog"
#pattern to search
pattern=$1
# file to store output
output_file="syslog_analysis.output" 

# Check if the log file is empty
if [[ -z $pattern ]]; then 
  echo "no pattern error"
  echo "ussage ./log_analysis.sh [pattern] "
  exit 1
fi

# display search pattern
echo "Searching for pattern: $pattern" 
# Search for the pattern in the log file and save output to file
grep $pattern $log_file > $output_file 

# display and Count the number of occurrences of pattern
echo "Number of occurrences: $(grep -c "$pattern" $log_file)" 