class NewContactMailer < ApplicationMailer
  default from: 'maxc.helpme@gmail.com'

  def contact_confirm_email(user)
    mail(to: user.email, subject: 'Confirmation of Contact Support Ticket')
  end
end
