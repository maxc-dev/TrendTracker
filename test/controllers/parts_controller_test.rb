require 'test_helper'

class PartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:cpu)
    @manufacturer = manufacturers(:intel)
    @part = parts(:i9_9900k)
    @part.manufacturer_id = @manufacturer.id
    @part.category_id = @category.id
  end

  # tests that the index has no error
  test "should get index" do
    get parts_url
    assert_response :success
  end
end
