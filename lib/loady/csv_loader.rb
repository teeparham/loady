require 'csv'
require 'logger'

module Loady
  class CsvLoader
    def initialize
      @success = 0
      @warning = 0
      @line_number = 0
    end

    class << self
      def read(*args, &block)
        self.new.read(*args, &block)
      end
    end

    # valid options:
    #   skip_first_row: true                       -- default = false
    #   logger: Logger.new('/somewhere/file.log')  -- default = Logger.new(STDOUT)
    #   plus any valid options you can pass to CSV.new:
    #     see http://www.ruby-doc.org/stdlib/libdoc/csv/rdoc/classes/CSV.html#M000190
    def read(filename, options={}, &block)
      @logger = options.delete(:logger) || default_logger

      f = File.new(filename)
      f.autoclose = true
      f.gets if options.delete(:skip_first_row)

      begin
        f.each do |line|
          readline(line, options, &block)
        end        
      rescue Exception => message
        @warning += 1
        @line_number += 1
        @logger.error "#{message} - at line #@line_number\n#{line}"
      end

      @logger.info "Finished. Loaded #@success rows. #@warning unprocessed rows."
    end

  private

    def readline(line, options)
      @line_number += 1
      row = AttributeArray.new(CSV.parse(line, options)[0])

      unless row.empty?
        yield row
        @success += 1
      end
    rescue Exception => message
      @warning += 1
      @logger.warn "#{message.to_s.gsub("line 1", "line #@line_number")}\n#{line}"
    end

    def default_logger
      logger = Logger.new(STDOUT)
      logger.datetime_format = "%H:%M:%S"
      logger
    end
  end
end
