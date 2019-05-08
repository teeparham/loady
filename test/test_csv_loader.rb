# frozen_string_literal: true

require "test_helper"

class CsvLoaderTest < MiniTest::Spec
  it "delegate Loady.csv to instance #read" do
    Loady::CsvLoader.any_instance.expects :read
    Loady.csv("file")
  end

  it "delegate Loady.read to instance #read" do
    Loady::CsvLoader.any_instance.expects :read
    Loady.read("file")
  end

  it "delegate #read to instance #read" do
    Loady::CsvLoader.any_instance.expects :read
    Loady::CsvLoader.read("file")
  end

  it "read file1" do
    logger = memory_logger
    monkeys = []

    Loady.read "test/csv/file1.csv", skip_first_row: true, logger: logger do |row|
      monkeys << { name: row[0], year: row[1] }
    end

    assert_equal 10, monkeys.count, "total rows read"
    assert_equal "Bubbles", monkeys[0][:name], "first row name"
    assert_equal "2000", monkeys[0][:year], "first row year"
    assert_equal "King Kong", monkeys[9][:name], "last row name"
    assert_equal "1933", monkeys[9][:year], "last row year"
    assert_equal 1, logger.messages.size
    assert_equal "Finished. Loaded 10 rows. 0 skipped rows.", logger.messages.first
  end

  it "read file2 with logger using named attributes" do
    logger = memory_logger
    monkeys = []

    Loady.read "test/csv/file2.csv", logger: logger do |row|
      monkeys << row.to_attributes(%i[name year])
    end

    assert_equal 10, monkeys.count, "total rows read"
    assert_equal "Bubbles", monkeys[0][:name], "first row name"
    assert_equal "2000", monkeys[0][:year], "first row year"
    assert_equal "King Kong", monkeys[9][:name], "last row name"
    assert_equal "1933", monkeys[9][:year], "last row year"
    assert_equal 2, logger.messages.size
    assert_equal "Unclosed quoted field on line 13.", logger.messages.first
    assert_equal "Stopped Loading after 10 rows. 0 skipped rows.", logger.messages.last
  end

  it "read file3, a tab-delimited file" do
    logger = memory_logger
    monkeys = []

    Loady.read "test/csv/file3.dat", skip_first_row: true, col_sep: "\t", logger: logger do |row|
      monkeys << { name: row[0], year: row[1] }
    end

    assert_equal 10, monkeys.count, "total rows read"
    assert_equal "Bubbles", monkeys[0][:name], "first row name"
    assert_equal "2000", monkeys[0][:year], "first row year"
    assert_equal "King Kong", monkeys[9][:name], "last row name"
    assert_equal "1933", monkeys[9][:year], "last row year"
    assert_equal 1, logger.messages.size
    assert_equal "Finished. Loaded 10 rows. 0 skipped rows.", logger.messages.first
  end

  private

  def memory_logger
    Loady::MemoryLogger.new
  end
end
