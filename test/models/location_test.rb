require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test valid creation of a location
  test "valid location create" do
    location = Location.new
    location.woeid = 12345
    location.name = 'City'
    location.country = 'Country'
    location.countryCode = 'GB'

    location.save
    assert location.valid?
  end

  # test valid creation of a location to fixture
  test "valid location fixture" do
    location = Location.new
    location.woeid = 12345
    location.name = 'London'
    location.country = 'Country'
    location.countryCode = 'GB'

    location.save
    assert_equal location.name, locations(:gb).name
  end

  # test valid name
  test "valid location name" do
    location = Location.new
    location.name = nil
    location.save
    refute location.valid?
  end
end
