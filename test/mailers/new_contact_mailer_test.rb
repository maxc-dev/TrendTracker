require 'test_helper'

class NewContactMailerTest < ActionMailer::TestCase
  # tests that email contacts are correct
  test "test contact confirm email to" do
    user = users(:one)
    email = NewContactMailer.contact_confirm_email(user).deliver

    assert_equal [user.email], email.to
  end

  # tests that email subject is correct
  test "test contact confirm email subject" do
    user = users(:two)
    email = NewContactMailer.contact_confirm_email(user).deliver

    assert_equal 'Confirmation of Contact Support Ticket', email.subject
  end
end