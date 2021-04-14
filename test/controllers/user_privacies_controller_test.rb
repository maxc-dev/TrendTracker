require 'test_helper'

class UserPrivaciesControllerTest < ActionDispatch::IntegrationTest
  # makes sure unsigned users are redirected to the sign in before they can accept/reject the privacy agreement
  test "should redirect from user_privacy" do
    get user_privacies_url
    assert_redirected_to new_user_session_path
  end
end
