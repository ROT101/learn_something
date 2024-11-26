#!/bin/bash

# Define the starting directory and flag pattern as command-line arguments
if [ $# -ne 2 ]; then
  echo "Usage: bash grep_finder.sh <starting_directory> <flag_pattern>"
  exit 1
fi

starting_directory=$1
flag_pattern=$2

# Use find to search for files recursively and execute grep on each file
find "$starting_directory" -type f -exec grep -l "$flag_pattern" {} \;

#$# is a special variable in Bash that represents the number of command-line arguments passed to the script.
#-ne is a conditional operator that checks if the value of $# is not equal to 2.
#If the condition is true (i.e., the number of arguments is not 2), the script prints an error message indicating the correct usage of the script.
#The exit 1 statement terminates the script with a non-zero exit status, indicating an error
