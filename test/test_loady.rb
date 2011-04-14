require File.expand_path('test_helper.rb', File.dirname(__FILE__))

class CsvLoaderTest < Test::Unit::TestCase
  context "helper" do

    should "build named_attribute_hash" do
      row = ['Bubbles  ', '2000', ' King Kong ']
      attrs = Loady.named_attribute_hash row, [:name, :year, :mom]
  
      assert_equal attrs.size, 3
      assert_equal attrs[:name], 'Bubbles'
      assert_equal attrs[:year], '2000'
      assert_equal attrs[:mom], 'King Kong'
    end

  end
end