require 'loady/csv_loader.rb'

module Loady

  # Loady::named_attribute_hash row, [:name, :age, :email]
  # => { :name => 'Bob', :age => '21', :email => 'bob@example.com' }
  #
  # options:
  #  :strip => false        -- default = true  -- strip each row value
  def named_attribute_hash(row, attrs, options={})
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
  module_function :named_attribute_hash

end
