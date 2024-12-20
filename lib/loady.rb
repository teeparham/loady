# frozen_string_literal: true

require "loady/attribute_array"
require "loady/csv_loader"
require "loady/memory_logger"

module Loady
  def read(*, &)
    Loady::CsvLoader.new.read(*, &)
  end

  alias csv read

  module_function :read, :csv
end
