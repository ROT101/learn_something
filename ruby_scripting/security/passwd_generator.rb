#!/bin/env ruby
require 'optparse'

CHARS = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + ['!', '@', '#', '$', '%', '^', '&', '*']
# process to generate password with legth of your choice
def user_passwd (length)
    password = Array.new(length.to_i) { CHARS.sample }.join # build a new array with x length and put array and join each piece of the array 
    puts "Password: #{password}"  # display password
end

# process to generate random password
def generated_passwd()
    num = Random.new # start an instance of random 
    length = num.rand(8..16) # generate random number between 8 and 16 
    password = Array.new(length) { CHARS.sample }.join  # build a new array with  length betwween 8-16 and put array and join each piece of the array 
    puts "Password: #{password}" 
end

# process to get arguments from user
options = {}
opt = OptionParser.new do |parser|
    parser.banner = "Usage: passwd_generator.rb || passwd_generator.rb [option]"
    
    parser.on("-h", "--help", "help page","use with no options") do
        puts parser
        exit
    end

    parser.on("-l ", "--length", "length") do |l|
        options[:length] = l 
    end          
end
# error handling process
begin
    opt.parse!
rescue OptionParser::InvalidOption => e
    puts "#{e} , see format.rb -h"
    exit 1
rescue OptionParser::MissingArgument => e
    puts "Error: #{e.message}, see format.rb -h "
    exit 1
end

# block to runs program
if options[:length]
    length = options[:length] 
    user_passwd(length)
else
    generated_passwd()
end

