# frozen_string_literal: true

require "csv"
require "logger"

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
    #     see https://ruby.github.io/csv/CSV.html#class-CSV-label-Options
    def read(filename, options = {}, &block)
      @logger = options.delete(:logger) || default_logger
      options[:headers] ||= options.delete(:skip_first_row)

      CSV.foreach(filename, **options) do |line|
        readline line, &block
      end
      @logger.info "Finished. Loaded #{@success} rows. #{@warning} skipped rows."
    rescue CSV::MalformedCSVError => e
      @logger.error e.message
      @logger.error "Stopped Loading after #{@success} rows. #{@warning} skipped rows."
    end

    class << self
      def read(*, **, &)
        new.read(*, **, &)
      end
    end

    private

    def readline(line)
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
    rescue StandardError => e
      @warning += 1
      @logger.warn "#{e.to_s.gsub('line 1', "line #{@line_number}")}\n#{line}"
    end

    def default_logger
      logger = Logger.new($stdout)
      logger.datetime_format = "%H:%M:%S"
      logger
    end
  end
end
