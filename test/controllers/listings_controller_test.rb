require 'test_helper'

class ListingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @listing = listings(:one)
    @user = users(:one)
    @listing.user_id = @user.id
  end

  # should return listing index
  test "should get index" do
    get listings_url
    assert_response :success
  end

  # test redirects if not signed in
  test "should redirect from listing" do
    get listing_url(@listing)
    assert_redirected_to new_user_session_path
  end
end
