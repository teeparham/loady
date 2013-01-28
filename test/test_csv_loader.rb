require 'test_helper'

class CsvLoaderTest < Test::Unit::TestCase
  should "delegate Loady.csv to instance #read" do
    Loady::CsvLoader.any_instance.expects :read
    Loady.csv("file")
  end

  should "delegate Loady.read to instance #read" do
    Loady::CsvLoader.any_instance.expects :read
    Loady.read("file")
  end

  should "delegate #read to instance #read" do
    Loady::CsvLoader.any_instance.expects :read
    Loady::CsvLoader.read("file")
  end

  should "read file1" do
    monkeys = []

    Loady.read "test/csv/file1.csv", skip_first_row: true do |row|
      monkeys << { name: row[0], year: row[1] }
    end

    assert_equal monkeys.count, 10, "total rows read"
    assert_equal monkeys[0][:name], "Bubbles", "first row name"
    assert_equal monkeys[0][:year], "2000", "first row year"
    assert_equal monkeys[9][:name], "King Kong", "last row name"
    assert_equal monkeys[9][:year], "1933", "last row year"
  end

  should "read file2 with logger using named attributes" do
    logger = Logger.new("/dev/null")
    monkeys = []

    Loady.read "test/csv/file2.csv", logger: logger do |row|
      monkeys << row.to_attributes([:name, :year])
    end

    assert_equal monkeys.count, 10, "total rows read"
    assert_equal monkeys[0][:name], "Bubbles", "first row name"
    assert_equal monkeys[0][:year], "2000", "first row year"
    assert_equal monkeys[9][:name], "King Kong", "last row name"
    assert_equal monkeys[9][:year], "1933", "last row year"
  end

  should "read file3, a tab-delimited file" do
    monkeys = []

    Loady.read "test/csv/file3.dat", skip_first_row: true, col_sep: "\t" do |row|
      monkeys << { name: row[0], year: row[1] }
    end

    assert_equal monkeys.count, 10, "total rows read"
    assert_equal monkeys[0][:name], "Bubbles", "first row name"
    assert_equal monkeys[0][:year], "2000", "first row year"
    assert_equal monkeys[9][:name], "King Kong", "last row name"
    assert_equal monkeys[9][:year], "1933", "last row year"
  end
       
end