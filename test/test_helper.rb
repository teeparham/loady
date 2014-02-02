if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

require 'minitest/autorun'
require 'mocha/setup'
require 'loady'
