require 'loady/attribute_array'
require 'loady/csv_loader'
require 'loady/memory_logger'

module Loady
  def read(*args, &block)
    Loady::CsvLoader.new.read(*args, &block)
  end
  module_function :read

  def csv(*args, &block)
    Loady::CsvLoader.new.read(*args, &block)
  end
  module_function :csv
end
