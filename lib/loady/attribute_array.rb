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
    def to_attributes(names, options={})
      options = { strip: true }.merge(options)

      attr_hash = {}

      names.each_with_index do |name, i|
        if i < self.size
          if options[:strip] && self[i]
            attr_hash[name] = self[i].strip
          else
            attr_hash[name] = self[i]
          end
        else
          attr_hash[name] = nil
        end
      end

      attr_hash
    end

  end
end
