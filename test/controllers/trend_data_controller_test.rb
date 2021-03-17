require 'test_helper'

class TrendDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trend_datum = trend_data(:one)
  end

  test "should get index" do
    get trend_data_url
    assert_response :success
  end

  test "should get new" do
    get new_trend_datum_url
    assert_response :success
  end

  test "should create trend_datum" do
    assert_difference('TrendDatum.count') do
      post trend_data_url, params: { trend_datum: { trend_id: @trend_datum.trend_id, woeid: @trend_datum.woeid } }
    end

    assert_redirected_to trend_datum_url(TrendDatum.last)
  end

  test "should show trend_datum" do
    get trend_datum_url(@trend_datum)
    assert_response :success
  end

  test "should get edit" do
    get edit_trend_datum_url(@trend_datum)
    assert_response :success
  end

  test "should update trend_datum" do
    patch trend_datum_url(@trend_datum), params: { trend_datum: { trend_id: @trend_datum.trend_id, woeid: @trend_datum.woeid } }
    assert_redirected_to trend_datum_url(@trend_datum)
  end

  test "should destroy trend_datum" do
    assert_difference('TrendDatum.count', -1) do
      delete trend_datum_url(@trend_datum)
    end

    assert_redirected_to trend_data_url
  end
end
