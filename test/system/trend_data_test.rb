require "application_system_test_case"

class TrendDataTest < ApplicationSystemTestCase
  setup do
    @trend_datum = trend_data(:one)
  end

  test "visiting the index" do
    visit trend_data_url
    assert_selector "h1", text: "Trend Data"
  end

  test "creating a Trend datum" do
    visit trend_data_url
    click_on "New Trend Datum"

    fill_in "Trend", with: @trend_datum.trend_id
    fill_in "Woeid", with: @trend_datum.woeid
    click_on "Create Trend datum"

    assert_text "Trend datum was successfully created"
    click_on "Back"
  end

  test "updating a Trend datum" do
    visit trend_data_url
    click_on "Edit", match: :first

    fill_in "Trend", with: @trend_datum.trend_id
    fill_in "Woeid", with: @trend_datum.woeid
    click_on "Update Trend datum"

    assert_text "Trend datum was successfully updated"
    click_on "Back"
  end

  test "destroying a Trend datum" do
    visit trend_data_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trend datum was successfully destroyed"
  end
end
