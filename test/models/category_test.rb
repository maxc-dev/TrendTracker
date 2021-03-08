require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test valid creation of a category
  test "valid category creation" do
    category = Category.new
    category.name = "Monitor"
    category.description = "Displays the computers graphical output"

    category.save
    assert category.valid?
  end

  # test invalid creation of a category with no name
  test "invalid category creation name" do
    category = Category.new
    category.description = "Displays the computers graphical output"

    category.save
    refute category.valid?
  end

  # test invalid creation of a category due to duplicated names
  test "no duplicate category names" do
    category1 = Category.new
    category1.name = "Monitor"
    category1.save
    assert category1.valid?

    category2 = Category.new
    category2.name = "Monitor"
    category2.save
    refute category2.valid?
  end
end
