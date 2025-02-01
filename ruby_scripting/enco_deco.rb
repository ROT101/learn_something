#!/bin/env ruby
require 'base64'
require 'optparse'

def to_hex(string)
    string.unpack1('H*')
end

def to_octal(string) 
    string.each_byte.map {|byte| sprintf('%o', byte)}.join(" ")
end

def to_base64(string)
    Base64.encode64(string)
end

def to_decimal(string)
    string.each_byte.map {|byte| byte.ord}.join(" ")
end

def from_hex(string)
    [string].pack('H*')
end

def from_octal(string)
    string.split.map { |oct| oct.to_i(8).chr }.join
end

def from_base64(string)
    Base64.decode64(string)
end

def from_decimal(string)
    string.split.map { |dec| dec.to_i.chr }.join
end

options = {}
opt = OptionParser.new do |parser|
    parser.banner = "Usage: example.rb [options]"

    parser.on("-h", "--help", "help page") do
        puts parser
        exit
    end

    parser.on("-D", "--decode", "decode") do
    options[:decode] = true
    end
            
    parser.on("-b ", "--base64", "base64") do |b|
        options[:base64] = b
    end

    parser.on("-x " , "--hex", "hex") do |x|
        options[:hex] = x
    end

    parser.on("-o ", "--octal", "octal") do |o|
        options[:octal] = o
    end

    parser.on("-d ", "decimal ","make sure to add quotation marks "  ) do |d|
        options[:decimal] = d
    end

end

begin
    opt.parse!
    if options.empty?
        puts "Usage: example.rb [options]"
    end
rescue OptionParser::InvalidOption => e
    puts "#{e} , see format.rb -h"
end

if options[:decode]
    case 
    when options[:base64]
        puts from_base64(options[:base64])
    when options[:hex] 
        puts from_hex(options[:hex])
    when options[:octal]
        puts from_octal(options[:octal])
    when options[:decimal]
        puts from_decimal(options[:decimal])

    end
else
    case 
    when options[:base64]
        puts to_base64(options[:base64])
    when options[:hex] 
        puts to_hex(options[:hex])
    when options[:octal]
        puts to_octal(options[:octal])
    when options[:decimal]
        puts to_decimal(options[:decimal])
    end
end
puts "options: #{options}"
