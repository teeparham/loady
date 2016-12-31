require 'csv'
require 'logger'

module Loady
  class CsvLoader
    def initialize
      @success = 0
      @warning = 0
      @line_number = 0
    end

    # valid options:
    #   skip_first_row: true                       -- default = false
    #   logger: Logger.new('/somewhere/file.log')  -- default = Logger.new(STDOUT)
    #   plus any valid options you can pass to CSV.new:
    #     see http://www.ruby-doc.org/stdlib/libdoc/csv/rdoc/classes/CSV.html#M000190
    def read(filename, options = {}, &block)
      @logger = options.delete(:logger) || default_logger
      options[:headers] ||= options.delete(:skip_first_row)

      CSV.foreach(filename, options) do |line|
        readline line, options, &block
      end
      @logger.info "Finished. Loaded #{ @success } rows. #{ @warning } skipped rows."
    rescue CSV::MalformedCSVError => ex
      @logger.error ex.message
      @logger.error "Stopped Loading after #{ @success } rows. #{ @warning } skipped rows."
    end

    class << self
      def read(*args, &block)
        new.read(*args, &block)
      end
    end

    private

    def readline(line, options)
      @line_number += 1
      row = if line.respond_to?(:to_hash)
              AttributeArray.new(line.to_hash.values)
            else
              AttributeArray.new(line)
            end

      if row.any?
        yield row
        @success += 1
      end
    rescue Exception => ex
      @warning += 1
      @logger.warn "#{ ex.to_s.gsub("line 1", "line #{ @line_number }") }\n#{ line }"
    end

    def default_logger
      logger = Logger.new(STDOUT)
      logger.datetime_format = "%H:%M:%S"
      logger
    end
  end
end
