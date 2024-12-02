# frozen_string_literal: true

if ENV["TRAVIS"]
  require "coveralls"
  Coveralls.wear!
end

require "minitest/autorun"
require "mocha/minitest"
require "loady"
