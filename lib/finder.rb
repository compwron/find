# frozen_string_literal: true

class Finder
  def initialize(args)
    _options, starting_path, _expression = args
    @current_dir = starting_path || Dir.pwd
  end

  def call
    Dir.chdir(@current_dir) do
      Dir.glob("**/*")
    end
  end
end
