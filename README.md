# Find

This is designed to be a ruby version of [find](http://man7.org/linux/man-pages/man1/find.1.html)

## Usage

(coming soon: better usage)
```(bash)
  ruby find.rb 
  ruby find.rb --path <dir>
  ruby find.rb --expression <expression> # example: "*.rb"
```

## Development

### Setup
gem install bundler # first time only
bundle install # only when Gemfile.lock changes

### Run tests
bundle exec rspec
