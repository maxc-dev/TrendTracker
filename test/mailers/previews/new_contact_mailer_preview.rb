class NewContactMailerPreview < ActionMailer::Preview
  def contact_confirm_email
    NewContactMailer.contact_confirm_email(User.first)
  end
end