# frozen_string_literal: true

args = ARGV
require_relative 'lib/finder'
puts Finder.new(args).call
