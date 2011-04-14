require 'csv'
require 'logger'

module Loady
  class CsvLoader

    # options:
    #   :skip_first_row => true                       -- default = false
    #   :logger => Logger.new('/somewhere/file.log')  -- default = Logger.new(STDOUT)
    def self.read(filename, options={})
      success = 0
      warning = 0

      logger = options[:logger]

      unless logger
        logger = Logger.new(STDOUT)
        logger.datetime_format = "%H:%M:%S"
      end

      begin
        f = File.new(filename)
        f.readline if options[:skip_first_row]

        line_number = 0

        begin
          while (line = f.readline)
            begin
              line_number += 1

              row = CSV.parse(line)[0]

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

      rescue Exception => message
        logger.fatal "Unhandled error: \n#{message}\n"
      end
    end
    
    # CsvLoader.named_attribute_hash row, [:name, :age, :email]
    # => { :name => 'Bob', :age => '21', :email => 'bob@example.com' }
    #
    # options:
    #  :strip => false        -- default = true  -- strip each row value
    def self.named_attribute_hash(row, attrs, options={})
      options = options.merge!(:strip => true){|k,o,n| o }

      h = {}

      attrs.each_with_index do |attr, i|
        if options[:strip]
          h[attr] = row[i].strip
        else
          h[attr] = row[i]
        end
      end

      h
    end
    
  end
end
