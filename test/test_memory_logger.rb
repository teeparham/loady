require File.expand_path('test_helper.rb', File.dirname(__FILE__))

class MemoryLoggerTest < Test::Unit::TestCase
  context "memory logger" do
    setup do
      @logger = MemoryLogger.new
    end

    should "have no messages" do
      assert_empty @logger.messages
    end

    should "log warning" do
      @logger.warn "message"
      assert_equal "message", @logger.messages.first.to_s
    end

    should "log info" do
      @logger.info "message"
      assert_equal "message", @logger.messages.first.to_s
    end

    should "log error" do
      @logger.error "message"
      assert_equal "message", @logger.messages.first.to_s
    end
  end
end