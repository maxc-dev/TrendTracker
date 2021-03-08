require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test valid creation of contact ticket
  test "valid contact create" do
    contact = Contact.new
    contact.user_id = users(:one).id
    contact.title = "Title"
    contact.body = "Body"

    contact.save
    assert contact.valid?
  end

  # test valid creation of contact ticket against a fixture
  test "contact create valid fixture" do
    contact = Contact.new
    contact.user_id = 1
    contact.title = "More products"
    contact.body = "Can more products be added to the website please?"

    contact.save
    assert_equal contact.user_id, contacts(:one).user_id
    assert_equal contact.title, contacts(:one).title
    assert_equal contact.body, contacts(:one).body
  end

  # test invalid creation of contact ticket from invalid user id
  test "invalid contact create" do
    contact = Contact.new
    contact.user_id = 0
    contact.title = "Title"
    contact.body = "Body"

    contact.save
    refute contact.valid?
  end
end
