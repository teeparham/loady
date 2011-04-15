class Array

  # usage:
  # ['john', 'doe'].to_attributes([:first, :last]) => { :first => 'john', :last => 'doe' }
  #
  # options:
  #   :strip => true     -- default = false
  #                      -- array values must be strings if :strip is true
  def to_attributes(names, options={})
    options = options.merge!(:strip => true){|_,o| o }

    h = {}

    names.each_with_index do |name, i|
      if i < self.size
        if options[:strip]
          h[name] = self[i].strip
        else
          h[name] = self[i]
        end
      end
    end

    h
  end

end