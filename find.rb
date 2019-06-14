# frozen_string_literal: true

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end

  opts.on("-p N", "--path N ", "Files in path") do |pattern|
    options[:starting_path] = pattern
  end

  opts.on("-e N", "--expression N ", "Files matching pattern") do |pattern|
    options[:match_pattern] = pattern
  end
end.parse!

require_relative 'lib/finder'
puts Finder.new(options).call
