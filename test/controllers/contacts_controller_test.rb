require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # sets up a user
  setup do
    @contact = contacts(:one)
    @user = users(:one)
    @contact.user_id = @user.id
    sign_in @user
  end

  # sends to index page
  test "should get index" do
    get contacts_url
    assert_response :success
  end

  # sends to new contacts
  test "should get new" do
    get new_contact_url
    assert_response :success
  end

  # creates a contact
  test "should create contact" do
    assert_difference('Contact.count') do
      post contacts_url, params: { contact: { body: @contact.body, title: @contact.title, user_id: @contact.user_id } }
    end

    assert_redirected_to contact_url(Contact.last)
  end

  # redirects unsigned users
  test "should redirect unsigned user show" do
    sign_out @user
    get contact_url(@contact)
    assert_redirected_to new_user_session_path
  end

  # redirects unsigned users
  test "should redirect unsigned user edit" do
    sign_out @user
    get edit_contact_url(@contact)
    assert_redirected_to new_user_session_path
  end

  # redirects unsigned users
  test "should redirect unsigned user update" do
    sign_out @user
    patch contact_url(@contact), params: { contact: { body: @contact.body, title: @contact.title, user_id: @contact.user_id } }
    assert_redirected_to new_user_session_path
  end

end
