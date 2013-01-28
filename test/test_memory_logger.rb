require 'test_helper'

class MemoryLoggerTest < Test::Unit::TestCase
  context "memory logger" do
    setup do
      @logger = Loady::MemoryLogger.new
    end

    should "have no messages" do
      assert_empty @logger.messages
    end

    should "log warning" do
      @logger.warn "message"
      assert_equal "message", @logger.messages.first
    end

    should "log info" do
      @logger.info "message"
      assert_equal "message", @logger.messages.first
    end

    should "log error" do
      @logger.error "message"
      assert_equal "message", @logger.messages.first
    end
  end
end