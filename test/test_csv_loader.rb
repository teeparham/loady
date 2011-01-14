require File.expand_path('test_helper.rb', File.dirname(__FILE__))

class CsvLoaderTest < Test::Unit::TestCase
  context "Simple class" do
    setup do
    end

    should "read file1" do
      monkeys = []

      Loady::CsvLoader.foreach "test/csv/file1.csv", :skip_first_row => true do |row|
        monkeys << { :name => row[0], :year => row[1] }
      end

      assert monkeys.count == 10, "total rows read"
      assert monkeys[0][:name] == "Bubbles", "first row name"
      assert monkeys[0][:year] == "2000", "first row year"
      assert monkeys[9][:name] == "King Kong", "last row name"
      assert monkeys[9][:year] == "1933", "last row year"
    end

    should "read file2" do
      logger = Logger.new("/dev/null")
      monkeys = []

      Loady::CsvLoader.foreach "test/csv/file2.csv", :logger => logger do |row|
        monkeys << { :name => row[0], :year => row[1] }
      end

      assert monkeys.count == 10, "total rows read"
      assert monkeys[0][:name] == "Bubbles", "first row name"
      assert monkeys[0][:year] == "2000", "first row year"
      assert monkeys[9][:name] == "King Kong", "last row name"
      assert monkeys[9][:year] == "1933", "last row year"
   end

  end
end