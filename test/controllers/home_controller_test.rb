require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get home_index_url
    assert_response :success
  end

  # makes sure user gets redirected to map if they try to register a privacy agreement without signing in
  test 'should redirect to sign in' do
    get home_index_url(x: 45, y: 12, accept: 'true')
    assert_redirected_to discoveries_path
  end
end
