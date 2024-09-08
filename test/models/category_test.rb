require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should save valid category" do
    category = Category.new(name: "Category test")
    assert category.save, "Failed to save valid category"
  end

  test "should not save unvalid category" do
    category = Category.new(name: "")
    assert_not category.save, "Saved the category with an empty name"
    assert_not_empty category.errors[:name], "No validation error for name present"
  end

  test "should not save duplicate name category" do
    category = Category.new(name: "Category test")
    category1 = Category.new(name: "Category test")
    assert category.save, "Failed to save valid category"
    assert_not category1.save, "Saved the category with repeatable name"
  end

  test "should have many ingredient" do
    category = Category.reflect_on_association(:ingredients)
    assert_equal(category.macro, :has_many, "Category does not have a has_many association with ingredients") 
  end
end
