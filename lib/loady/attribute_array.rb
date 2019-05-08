# frozen_string_literal: true

module Loady
  class AttributeArray < Array
    # usage:
    # aa = Loady::AttributeArray.new(['john', 'doe'])
    # aa.to_attributes([:first, :last])
    # => { first: 'john', last: 'doe' }
    #
    # options:
    #   strip: false    -- default = true
    #                   -- array values must be strings if :strip is true
    def to_attributes(names, options = {})
      options = { strip: true }.merge(options)

      {}.tap do |attr_hash|
        names.each_with_index do |name, i|
          attr_hash[name] = if i < size && self[i]
                              options[:strip] ? self[i].to_s.strip : self[i]
                            end
        end
      end
    end
  end
end
