require 'test_helper'

class UserPrivaciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_privacy = user_privacies(:one)
  end

  test "should get index" do
    get user_privacies_url
    assert_response :success
  end

  test "should get new" do
    get new_user_privacy_url
    assert_response :success
  end

  test "should create user_privacy" do
    assert_difference('UserPrivacy.count') do
      post user_privacies_url, params: { user_privacy: { authorization: @user_privacy.authorization, tracking: @user_privacy.tracking } }
    end

    assert_redirected_to user_privacy_url(UserPrivacy.last)
  end

  test "should show user_privacy" do
    get user_privacy_url(@user_privacy)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_privacy_url(@user_privacy)
    assert_response :success
  end

  test "should update user_privacy" do
    patch user_privacy_url(@user_privacy), params: { user_privacy: { authorization: @user_privacy.authorization, tracking: @user_privacy.tracking } }
    assert_redirected_to user_privacy_url(@user_privacy)
  end

  test "should destroy user_privacy" do
    assert_difference('UserPrivacy.count', -1) do
      delete user_privacy_url(@user_privacy)
    end

    assert_redirected_to user_privacies_url
  end
end
