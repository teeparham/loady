require 'loady/array'
require 'loady/csv_loader'
require 'loady/memory_logger'

module Loady
  def csv(*args, &block)
    Loady::CsvLoader.read(*args, &block)
  end
  module_function :csv
end
