#!/usr/bin/env ruby

require 'optparse'

# Define a method to convert input into various ASCII formats
def convert(input, from:, to:)
  ascii_value = case from
                when :decimal then input.to_i
                when :hex then input.to_i(16)
                when :octal then input.to_i(8)
                when :binary then input.to_i(2)
                when :html_number then input.gsub("&#", "").to_i
                when :symbol then input.ord
                else raise "Unsupported input format: #{from}"
                end

  case to
  when :decimal then ascii_value.to_s
  when :hex then "0x" + ascii_value.to_s(16).upcase
  when :octal then "0o" + ascii_value.to_s(8)
  when :binary then "0b" + ascii_value.to_s(2)
  when :html_number then "&#" + ascii_value.to_s
  when :symbol then ascii_value.chr
  else raise "Unsupported output format: #{to}"
  end
end

# Define supported formats
formats = {
  '--dec' => :decimal,
  '--hex' => :hex,
  '--oct' => :octal,
  '--sym' => :symbol,
  '--bin' => :binary,
  '--htn' => :html_number
}

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ascii_converter.rb [options]"

  formats.each do |flag, format|
    opts.on(flag, "--from#{flag}", "Convert #{flag} format") do
      options[:from] = format
    end

    opts.on(flag, "--to#{flag}", "Output to #{flag} format") do
      options[:to] = format
    end
  end

  opts.on("--input VALUE", "Input value for conversion") do |value|
    options[:input] = value
  end
end.parse!

# Ensure all necessary options are provided
if options[:from].nil? || options[:to].nil? || options[:input].nil?
  puts "Error: Missing required arguments."
  puts "Use --help for usage instructions."
  exit 1
end

# Perform conversion
begin
  result = convert(options[:input], from: options[:from], to: options[:to])
  puts "Converted value: #{result}"
rescue => e
  puts "Error: #{e.message}"
end
