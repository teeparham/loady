# frozen_string_literal: true

require 'test_helper'

class MemoryLoggerTest < MiniTest::Spec
  describe "memory logger" do
    before do
      @logger = Loady::MemoryLogger.new
    end

    it "have no messages" do
      assert_empty @logger.messages
    end

    it "log warning" do
      @logger.warn "message"
      assert_equal "message", @logger.messages.first
    end

    it "log info" do
      @logger.info "message"
      assert_equal "message", @logger.messages.first
    end

    it "log error" do
      @logger.error "message"
      assert_equal "message", @logger.messages.first
    end
  end
end
