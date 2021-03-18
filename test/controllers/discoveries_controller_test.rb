require 'test_helper'

class DiscoveriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @discovery = discoveries(:one)
  end

  test "should get index" do
    get discoveries_url
    assert_response :success
  end

  test "should get new" do
    get new_discovery_url
    assert_response :success
  end

  test "should create discovery" do
    assert_difference('Discovery.count') do
      post discoveries_url, params: { discovery: {  } }
    end

    assert_redirected_to discovery_url(Discovery.last)
  end

  test "should show discovery" do
    get discovery_url(@discovery)
    assert_response :success
  end

  test "should get edit" do
    get edit_discovery_url(@discovery)
    assert_response :success
  end

  test "should update discovery" do
    patch discovery_url(@discovery), params: { discovery: {  } }
    assert_redirected_to discovery_url(@discovery)
  end

  test "should destroy discovery" do
    assert_difference('Discovery.count', -1) do
      delete discovery_url(@discovery)
    end

    assert_redirected_to discoveries_url
  end
end
