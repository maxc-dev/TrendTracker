require 'test_helper'

class DiscoveriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get discoveries_url
    assert_response :success
  end
end
