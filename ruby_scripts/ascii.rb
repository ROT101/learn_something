#!/usr/bin/env ruby

# A command-line tool to convert ASCII text to various formats
require 'optparse'

# Define the available formats
FORMATS = %w[unicode binary hex octet decimal html]

# Method to convert ASCII to Unicode
def to_unicode(text)
  text.chars.map { |char| "\\u#{char.ord.to_s(16).rjust(4, '0')}" }.join
end

# Method to convert ASCII to Binary
def to_binary(text)
  text.chars.map { |char| char.ord.to_s(2).rjust(8, '0') }.join(' ')
end

# Method to convert ASCII to Hexadecimal
def to_hex(text)
  text.chars.map { |char| char.ord.to_s(16).rjust(2, '0') }.join(' ')
end

# Method to convert ASCII to Octet
def to_octet(text)
  text.chars.map { |char| char.ord.to_s(8).rjust(3, '0') }.join(' ')
end

# Method to convert ASCII to Decimal
def to_decimal(text)
  text.chars.map { |char| char.ord.to_s }.join(' ')
end

# Method to convert ASCII to HTML Entities
def to_html(text)
  text.chars.map { |char| "&#{char.ord};" }.join
end

# Parse command-line options
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ascii_converter.rb [options]"

  opts.on("-t", "--text TEXT", "Text to convert") do |text|
    options[:text] = text
  end

  opts.on("-f", "--format FORMAT", "Format to convert to (#{FORMATS.join(', ')})") do |format|
    options[:format] = format.downcase
  end
end.parse!

# Validate input
if options[:text].nil? || options[:format].nil?
  puts "Error: Text and format are required."
  puts "Use -h or --help for usage instructions."
  exit 1
end

unless FORMATS.include?(options[:format])
  puts "Error: Unsupported format '#{options[:format]}'."
  puts "Supported formats: #{FORMATS.join(', ')}"
  exit 1
end

# Perform the conversion
output = case options[:format]
         when 'unicode'
           to_unicode(options[:text])
         when 'binary'
           to_binary(options[:text])
         when 'hex'
           to_hex(options[:text])
         when 'octet'
           to_octet(options[:text])
         when 'decimal'
           to_decimal(options[:text])
         when 'html'
           to_html(options[:text])
         end

puts "Converted text (#{options[:format]}):"
puts output
