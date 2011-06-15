require 'csv'
require 'logger'

module Loady
  class CsvLoader

    # valid options:
    #   :skip_first_row => true                       -- default = false
    #   :logger => Logger.new('/somewhere/file.log')  -- default = Logger.new(STDOUT)
    #   plus any valid options you can pass to CSV.new: 
    #     see http://www.ruby-doc.org/stdlib/libdoc/csv/rdoc/classes/CSV.html#M000190
    def self.read(filename, options={})
      success = 0
      warning = 0

      logger = options[:logger]

      unless logger
        logger = Logger.new(STDOUT)
        logger.datetime_format = "%H:%M:%S"
      end

      f = File.new(filename)
      f.readline if options[:skip_first_row]
      
      [:logger, :skip_first_row].each {|d| options.delete(d) }
      
      line_number = 0

      begin
        while (line = f.readline)
          begin
            line_number += 1

            row = CSV.parse(line, options)[0]

            unless row.empty?
              yield row

              success += 1
            end
          rescue Exception => message
            warning += 1
            logger.warn "#{message.to_s.gsub("line 1", "line #{line_number}")}\n#{line}"
          end
        end
      rescue EOFError
        f.close
      rescue Exception => message
        warning += 1
        line_number += 1
        logger.error "#{message.to_s + " - at line #{line_number}"}\n#{line}"
      end

      logger.info "Finished. Loaded #{success} rows. #{warning} unprocessed rows."
    end
        
  end
end
