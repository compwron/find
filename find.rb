# frozen_string_literal: true

require 'optparse'
require_relative 'lib/finder'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  # required by OptionParser
  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end

  opts.on("-p N", "--path N ", "Files in path") do |pattern|
    options[:starting_path] = pattern
  end

  opts.on("-n N", "--name N ", "Files matching pattern") do |pattern|
    options[:match_pattern] = pattern
  end

  opts.on("-e", "--empty", "Only empty files") do |e|
    options[:only_empty_files] = e
  end

  opts.on("-L", "--symlinks", "Find and follow symlinks") do |e|
    options[:follow_symlinks] = e
  end
end.parse!

puts Finder.new(options).call
