# frozen_string_literal: true

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end

  opts.on("-name N", "--name N ", "Files matching pattern") do |pattern|
    options[:match_pattern] = pattern
  end
end.parse!

p "OPTIONS"
p options

p "ARGV"
p ARGV
args = ARGV
require_relative 'lib/finder'
puts Finder.new(args).call
