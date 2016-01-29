# Loady

[![Gem Version](http://img.shields.io/gem/v/loady.svg)](http://rubygems.org/gem/loady)
[![Build Status](http://img.shields.io/travis/teeparham/loady.svg)](https://travis-ci.org/teeparham/loady)
[![Code Climate](http://img.shields.io/codeclimate/github/teeparham/loady.svg)](https://codeclimate.com/github/teeparham/loady)
[![Coverage Status](http://img.shields.io/coveralls/teeparham/loady.svg)](https://coveralls.io/r/teeparham/loady)

Loady is a simple file reader and logger. Use it to read any delimited file. Loady makes it easy to conveniently convert input fields to an attribute hash, continue on error rows, and do basic logging.

Loady was initially created to load hundreds of millions of rows from CSV files that had various data errors.

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

### Collect log messages in memory

`Loady::MemoryLoader` is a class that collects log messages in memory.

``` ruby
memory_logger = Loady::MemoryLogger.new

Loady.read "/your/file.csv", logger: memory_logger do |row|
  # do things
end

memory_logger.messages
=> [
    'Line 123: Something bad happened.',
    'Line 456: Exception of some sort.',
    'Finished. Loaded 9998 rows. 2 unprocessed rows.'
   ]
```

## Major Change in 1.0

Up to version 1.0, `loady` worked fundamentally differently than ruby's CSV
parser in that it did not support newlines. The benefit was that lines
with errant newlines could easily be ignored.

In version 1.0+, `loady` works like the stdlib ruby CSV parser, and you
must have properly formed CSV rows.
