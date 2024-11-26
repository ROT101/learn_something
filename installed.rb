#!/usr/bin/env ruby

# Check if a tool name argument is provided
if ARGV.empty?
  puts "Usage: ruby check_tool_installed.rb <tool_name>"
  exit 1
end

# Get the tool name from the command line argument
tool_name = ARGV[0]

# Check if the tool is installed using the `which` command
def tool_installed?(tool)
  # Use backticks to execute the `which` command
  !`which #{tool}`.strip.empty?
end

if tool_installed?(tool_name)
  puts "#{tool_name} is installed."
else
  puts "#{tool_name} is not installed."
end
