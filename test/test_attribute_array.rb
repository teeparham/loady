# frozen_string_literal: true

require 'test_helper'

class AttributeArrayTest < MiniTest::Spec
  it "respond to to_attributes" do
    aa = Loady::AttributeArray.new
    assert aa.respond_to? :to_attributes
  end

  it "initialize with Array" do
    aa = Loady::AttributeArray.new([1, 2])
    assert_equal [1, 2], aa
  end

  describe "#to_attributes" do
    it "return named attributes" do
      row = Loady::AttributeArray.new(['Bubbles  ', '2000', ' King Kong '])
      attrs = row.to_attributes [:name, :year, :mom]
      assert_equal attrs.size, 3
      assert_equal attrs[:name], 'Bubbles'
      assert_equal attrs[:year], '2000'
      assert_equal attrs[:mom], 'King Kong'
    end

    it "return named attributes when missing values" do
      row = Loady::AttributeArray.new(['Bubbles  ', '2000'])
      attrs = row.to_attributes [:name, :year, :mom]
      assert_equal attrs.size, 3
      assert_equal attrs[:name], 'Bubbles'
      assert_equal attrs[:year], '2000'
      assert_nil attrs[:mom]
    end
  end
end
