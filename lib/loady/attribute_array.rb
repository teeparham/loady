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

      h = {}

      names.each_with_index do |name, i|
        if i < self.size
          if options[:strip] && self[i]
            h[name] = self[i].strip
          else
            h[name] = self[i]
          end
        else
          h[name] = nil
        end
      end

      h
    end

  end
end