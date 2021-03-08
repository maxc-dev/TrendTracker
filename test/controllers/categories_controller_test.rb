require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:cpu)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end
end
