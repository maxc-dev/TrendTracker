require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # test a valid listing with a user id
  test "test valid listing" do
    listing = Listing.new
    listing.user_id = users(:one).id
    listing.save
    assert listing.valid?
  end

  # test a valid listing against a fixture
  test "test listing fixture" do
    listing = Listing.new
    listing.user_id = users(:two).id
    listing.save
    assert_equal listing.user_id, listings(:two).id
  end

  # test that a listing is refuted if there is no user id
  test "test listing user id present" do
    listing = Listing.new
    listing.save
    refute listing.valid?
  end
end
