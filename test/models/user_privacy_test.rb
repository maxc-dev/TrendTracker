require 'test_helper'

class UserPrivacyTest < ActiveSupport::TestCase
  test "valid user privacy initialise" do
    user1 = users(:one)
    privacy = UserPrivacy.new
    privacy.user_id = user1.id
    privacy.longitude = 1
    privacy.latitude = 1
    privacy.authorization = DateTime.current
    privacy.save

    assert privacy.valid?
  end

  test "refute user privacy initialise without user" do
    privacy = UserPrivacy.new
    privacy.longitude = 1
    privacy.latitude = 1
    privacy.authorization = DateTime.current
    privacy.save

    refute privacy.valid?
  end
end
