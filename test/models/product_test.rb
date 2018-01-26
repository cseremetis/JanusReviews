require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
  	@product = Product.new(name: "Test", description: "lorem ipsum dolor sit amet")
  end

  test "should be valid" do
  	assert @product.valid?
  end

  test "name should exist" do
  	@product.name = ""
  	assert_not @product.valid?
  end

  test "desciption should exist" do
  	@product.description = "     "
  	assert_not @product.valid?
  end
end
