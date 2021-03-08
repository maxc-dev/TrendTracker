require 'test_helper'

class ManufacturersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manufacturer = manufacturers(:nvidia)
  end

  # tests that there is no error in the index
  test "should get index" do
    get manufacturers_url
    assert_response :success
  end
end
