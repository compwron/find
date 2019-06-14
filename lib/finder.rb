# frozen_string_literal: true

class Finder
  def initialize(options)
    @matching_pattern = interpret_matching_pattern(options[:match_pattern])
    @current_dir = options[:starting_path] || Dir.pwd
  end

  def call
    Dir.chdir(@current_dir) do
      Dir.glob("**/*")
    end.select do |file|
      /#{@matching_pattern}/.match?(file)
    end
  end

  private

  def interpret_matching_pattern(pattern)
    # Think about how to make it safer to (essentially) execute user-provided matchers
    pattern&.gsub("*", ".*")
  end
end
