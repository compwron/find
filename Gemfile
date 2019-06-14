# frozen_string_literal: true

source "https://rubygems.org"
require 'pp' # prevent fakefs error- see https://github.com/fakefs/fakefs/blob/master/README.md

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

group :development do
  gem "rspec"
  gem "byebug"
end

group :test do
  gem 'fakefs'
end
