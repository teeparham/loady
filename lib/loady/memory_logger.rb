class MemoryLogger
  attr_reader :messages

  def initialize
    @messages = []
  end

  def info(message)
    @messages << message
  end

  alias_method :warn, :info
  alias_method :error, :info
end