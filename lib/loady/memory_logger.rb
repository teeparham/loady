module Loady
  class MemoryLogger
    attr_reader :messages

    def initialize
      @messages = []
    end

    def info(message)
      @messages << message
    end

    alias warn info
    alias error info
  end
end
