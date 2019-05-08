# frozen_string_literal: true

module Loady
  class MemoryLogger
    attr_reader :messages

    def initialize(options = {})
      @messages = []
    end

    def info(message)
      @messages << message
    end

    alias warn info
    alias error info
  end
end
