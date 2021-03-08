require 'test_helper'

class ListItemTest < ActiveSupport::TestCase
  # test valid creation of list item
  test "create valid list item" do
    list_item1 = ListItem.new
    list_item1.listing_id = listings(:one).id
    list_item1.part_id = parts(:i9_9900k).id
    list_item1.save
    assert list_item1.valid?
  end

  # test invalid listing id in list item creation
  test "invalid listing id in list item" do
    list_item1 = ListItem.new
    list_item1.listing_id = 0
    list_item1.part_id = parts(:i9_9900k).id
    list_item1.save
    refute list_item1.valid?
  end

  # test invalid part id in list item creation
  test "invalid part id in list item" do
    list_item1 = ListItem.new
    list_item1.listing_id = listings(:one).id
    list_item1.part_id = 0
    list_item1.save
    refute list_item1.valid?
  end
end
