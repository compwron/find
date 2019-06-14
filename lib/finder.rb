# frozen_string_literal: true

class Finder
  def initialize(args)
    # for now, do nothing with args
    @current_dir = Dir.pwd
  end

  def call
    Dir.entries(@current_dir)
  end
end
