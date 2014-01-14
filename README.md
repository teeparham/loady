[![Gem Version](https://badge.fury.io/rb/loady.png)](http://badge.fury.io/rb/loady)
[![Build Status](https://api.travis-ci.org/teeparham/loady.png)](https://travis-ci.org/teeparham/loady)
[![Code Climate](https://codeclimate.com/github/teeparham/loady.png)](https://codeclimate.com/github/teeparham/loady)
[![Coverage Status](https://coveralls.io/repos/teeparham/loady/badge.png)](https://coveralls.io/r/teeparham/loady)

# Loady - A file loader with simple logging

Loady is a simple file reader and logger. Use it to quickly load any delimited file, continue on error rows, and do basic logging.

It works with MRI ruby 1.9.3+. It uses ruby's CSV library to parse rows.

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
  # handle each row
end
```

### Skip the first row and log to a file:

``` ruby
logger = Logger.new "/your/file.log"

Loady.read "/your/file.csv", logger: logger, skip_first_row: true do |row|
  puts "#{row[0]}, #{row[1]}, etc."
end
```

### Name your attributes:

``` ruby
Loady.read "/your/file.csv"  do |row|
  Monkey.create row.to_attributes [:name, :year, :mom]

  # row.to_attributes [:name, :year, :mom]
  # => { name: 'Bubbles', year: 2000, mom: 'Momma Bubbles' }
end
```

### Load a tab-delimited file:

``` ruby
Loady.read "/your/file.tab", col_sep: "\t"  do |row|
  # go bananas
end
```

