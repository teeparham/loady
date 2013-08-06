[![Build Status](https://api.travis-ci.org/teeparham/loady.png)](https://travis-ci.org/teeparham/loady)
[![Code Climate](https://codeclimate.com/github/teeparham/loady.png)](https://codeclimate.com/github/teeparham/loady)

# Loady - A file loader with simple logging

Loady is a simple file reader and logger. Use it to quickly load any delimited file, continue on error rows, and do basic logging.

It works with MRI ruby 1.9 and 2.0. It uses ruby's CSV library to parse rows.

## Install

``` ruby
gem install loady
```

Or include the gem in your Gemfile:

``` ruby
gem 'loady'
```

## Use

If an error occurs, Loady will continue reading the file, ignoring problem rows and logging a warning for each.

By default, messages are logged to the standard output.

### Basic usage:

``` ruby
Loady.read "/your/file.csv" do |row|
  # your code to process each row goes here
  puts "#{row[0]}, #{row[1]}, etc."
end
```

### Skip the first row and log to a file:

``` ruby
logger = Logger.new "/your/file.log"

Loady.read "/your/file.csv", logger: logger, skip_first_row: true do |row|
  # do some stuff for each row
end
```

### Name your attributes:

``` ruby
Loady.read "/your/file.csv"  do |row|
  Monkey.create row.to_attributes [:name, :year, :mom]
end
```

### Load a tab-delimited file:

``` ruby
Loady.read "/your/file.tab", col_sep: "\t"  do |row|
  # go bananas
end
```

## Development

```
git clone git://github.com/teeparham/loady.git
cd loady
bundle
bundle exec rake
```
