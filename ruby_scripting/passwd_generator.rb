#!/bin/env ruby
require 'optparse'

CHARS = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + ['!', '@', '#', '$', '%', '^', '&', '*']

def user_passwd (length)
    password = Array.new(length.to_i) { CHARS.sample }.join
    puts "Password: #{password}"   
end

def generated_passwd()
    num = Random.new
    length = num.rand(8..16)
    password = Array.new(length) { CHARS.sample }.join
    puts "Password: #{password}"
end

options = {}
opt = OptionParser.new do |parser|
    parser.banner = "Usage: passwd_generator.rb || passwd_generator.rb [option]"
    
    parser.on("-h", "--help", "help page","use with no options") do
        
        puts parser
        puts ""
        exit
    end

    parser.on("-l ", "--length", "length") do |l|
        options[:length] = l 
    end          
end
begin
    opt.parse!
rescue OptionParser::InvalidOption => e
    puts "#{e} , see format.rb -h"
    exit 1
rescue OptionParser::MissingArgument => e
    puts "Error: #{e.message}, see format.rb -h "
    exit 1
end

if options[:length]
    length = options[:length]
    user_passwd(length)
else
    generated_passwd()
end

