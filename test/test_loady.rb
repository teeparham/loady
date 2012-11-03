require File.expand_path('test_helper.rb', File.dirname(__FILE__))

class LoadyTest < Test::Unit::TestCase
  context "#to_attributes" do

    should "return named attributes" do
      row = ['Bubbles  ', '2000', ' King Kong ']
      row.extend Loady::Array
      attrs = row.to_attributes [:name, :year, :mom]
  
      assert_equal attrs.size, 3
      assert_equal attrs[:name], 'Bubbles'
      assert_equal attrs[:year], '2000'
      assert_equal attrs[:mom], 'King Kong'
    end

    should "return named attributes when missing values" do
      row = ['Bubbles  ', '2000']
      row.extend Loady::Array
      attrs = row.to_attributes [:name, :year, :mom]

      assert_equal attrs.size, 3
      assert_equal attrs[:name], 'Bubbles'
      assert_equal attrs[:year], '2000'
      assert_nil attrs[:mom]
    end

  end
end