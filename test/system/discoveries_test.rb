require "application_system_test_case"

class DiscoveriesTest < ApplicationSystemTestCase
  setup do
    @discovery = discoveries(:one)
  end

  test "visiting the index" do
    visit discoveries_url
    assert_selector "h1", text: "Discoveries"
  end

  test "creating a Discovery" do
    visit discoveries_url
    click_on "New Discovery"

    click_on "Create Discovery"

    assert_text "Discovery was successfully created"
    click_on "Back"
  end

  test "updating a Discovery" do
    visit discoveries_url
    click_on "Edit", match: :first

    click_on "Update Discovery"

    assert_text "Discovery was successfully updated"
    click_on "Back"
  end

  test "destroying a Discovery" do
    visit discoveries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Discovery was successfully destroyed"
  end
end
