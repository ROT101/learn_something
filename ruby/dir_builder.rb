#!/usr/bin/env ruby
require 'fileutils'

class TreeBuilder
  def initialize(input_file, root_dir = nil)
    @input_file = input_file
    @root_dir = root_dir || Dir.pwd
    @created_count = 0
    @skipped_count = 0
  end

  def build
    validate_input
    process_file
    display_summary
  end

  private

  def validate_input
    unless File.exist?(@input_file)
      abort "Error: Input file '#{@input_file}' not found"
    end

    unless File.directory?(@root_dir)
      abort "Error: Root directory '#{@root_dir}' doesn't exist"
    end
  end

  def process_file
    File.readlines(@input_file).each do |line|
      line.strip!
      next if line.empty? || line.start_with?('#')

      path = File.join(@root_dir, line)
      create_directory(path)
    end
  end

  def create_directory(path)
    if File.exist?(path)
      if File.directory?(path)
        puts "Skipped (exists): #{path}"
        @skipped_count += 1
      else
        puts "Error: Path exists but is not a directory: #{path}"
      end
      return
    end

    FileUtils.mkdir_p(path)
    puts "Created: #{path}"
    @created_count += 1
  rescue => e
    puts "Error creating #{path}: #{e.message}"
  end

  def display_summary
    puts "\nSummary:"
    puts "  Directories created: #{@created_count}"
    puts "  Directories skipped: #{@skipped_count}"
    puts "  Total processed: #{@created_count + @skipped_count}"
  end
end

if __FILE__ == $0
  if ARGV.empty? || ARGV.include?('-h') || ARGV.include?('--help')
    puts <<~HELP
      Directory Tree Builder
      Usage: #{$0} <input_file> [root_directory]
      
      Arguments:
        input_file     Text file containing directory structure
        root_directory Base directory to create structure in (default: current directory)

      Input file format:
        - One directory path per line
        - Relative paths will be created under root directory
        - Empty lines and lines starting with # are ignored
        - Example:
          dir1
          dir1/subdir1
          dir2
          dir2/subdir2/subsubdir
    HELP
    exit
  end

  input_file = ARGV[0]
  root_dir = ARGV[1]

  TreeBuilder.new(input_file, root_dir).build
end