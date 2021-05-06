require 'test_helper'

class SecurityTest < ActiveSupport::TestCase
  test "test_encrypt_data_change" do
    user_privacy = user_privacies(:one)

    encrypted_latitude = user_privacy.latitude
    encrypted_longitude = user_privacy.longitude

    crypt = ActiveSupport::MessageEncryptor.new(ENV['ENCRYPTION_KEY'])
    encrypted_latitude = crypt.encrypt_and_sign(user_privacy.latitude)
    encrypted_longitude = crypt.encrypt_and_sign(user_privacy.longitude)

    assert_not_equal user_privacy.latitude, encrypted_latitude
    assert_not_equal user_privacy.longitude, encrypted_longitude
  end
end