require File.expand_path('test_helper.rb', File.dirname(__FILE__))

class CsvLoaderTest < Test::Unit::TestCase
  context "Simple class" do
    should "read file1" do
      monkeys = []

      Loady::CsvLoader.read "test/csv/file1.csv", :skip_first_row => true do |row|
        monkeys << { :name => row[0], :year => row[1] }
      end

      assert_equal monkeys.count, 10, "total rows read"
      assert_equal monkeys[0][:name], "Bubbles", "first row name"
      assert_equal monkeys[0][:year], "2000", "first row year"
      assert_equal monkeys[9][:name], "King Kong", "last row name"
      assert_equal monkeys[9][:year], "1933", "last row year"
    end

    should "read file2" do
      logger = Logger.new("/dev/null")
      monkeys = []

      Loady::CsvLoader.read "test/csv/file2.csv", :logger => logger do |row|
        monkeys << { :name => row[0], :year => row[1] }
      end

      assert_equal monkeys.count, 10, "total rows read"
      assert_equal monkeys[0][:name], "Bubbles", "first row name"
      assert_equal monkeys[0][:year], "2000", "first row year"
      assert_equal monkeys[9][:name], "King Kong", "last row name"
      assert_equal monkeys[9][:year], "1933", "last row year"
   end
   
   should "build named_attribute_hash" do 
     row = ['Bubbles  ', '2000', ' King Kong ']         
     attrs = Loady::CsvLoader.named_attribute_hash row, [:name, :year, :mom]
     
     assert_equal attrs.size, 3
     assert_equal attrs[:name], 'Bubbles'
     assert_equal attrs[:year], '2000'
     assert_equal attrs[:mom], 'King Kong'
   end
   

  end
end