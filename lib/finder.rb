# frozen_string_literal: true

class Finder
  def initialize(options)
    starting_path = options[:starting_path]
    matching_pattern = options[:matching_pattern]
    @current_dir = starting_path || Dir.pwd
  end

  def call
    Dir.chdir(@current_dir) do
      Dir.glob("**/*")
    end
  end
end
