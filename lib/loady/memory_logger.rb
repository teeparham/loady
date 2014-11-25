module Loady
  class MemoryLogger
    attr_reader :messages

    def initialize(options = {})
      @messages = []
    end

    def info(message)
      @messages << message
    end

    alias_method :warn, :info
    alias_method :error, :info
  end
end
