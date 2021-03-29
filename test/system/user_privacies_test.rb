require "application_system_test_case"

class UserPrivaciesTest < ApplicationSystemTestCase
  setup do
    @user_privacy = user_privacies(:one)
  end

  test "visiting the index" do
    visit user_privacies_url
    assert_selector "h1", text: "User Privacies"
  end

  test "creating a User privacy" do
    visit user_privacies_url
    click_on "New User Privacy"

    fill_in "Authorization", with: @user_privacy.authorization
    check "Tracking" if @user_privacy.tracking
    click_on "Create User privacy"

    assert_text "User privacy was successfully created"
    click_on "Back"
  end

  test "updating a User privacy" do
    visit user_privacies_url
    click_on "Edit", match: :first

    fill_in "Authorization", with: @user_privacy.authorization
    check "Tracking" if @user_privacy.tracking
    click_on "Update User privacy"

    assert_text "User privacy was successfully updated"
    click_on "Back"
  end

  test "destroying a User privacy" do
    visit user_privacies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User privacy was successfully destroyed"
  end
end
