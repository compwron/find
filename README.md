# Find

This is designed to be a ruby version of [find](http://man7.org/linux/man-pages/man1/find.1.html)

## Usage

Note: this is not precisely the contract of `man find` and it should be (TODO)
```(bash)
  ruby find.rb 
  ruby find.rb --path <dir>
  ruby find.rb --name <expression> # example: "*.rb"
  ruby find.rb --path <dir> --name <expression>
  ruby find.rb --empty
  ruby find.rb -L # symlinks - currently shows symlinks but also files it should not
```

## Development

### Setup
gem install bundler # first time only
bundle install # only when Gemfile.lock changes

### Run tests
bundle exec rspec
