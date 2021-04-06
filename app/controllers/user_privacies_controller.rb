class UserPrivaciesController < ApplicationController
  def index
    # validates that the user is present, then displays the time that their location data was stored
    if current_user.present?
      if UserPrivacy.exists?(user_id: current_user.id)
        @agreedment_date = UserPrivacy.user_agreement(current_user.id).first.authorization
      else
        @agreedment_date = nil
      end
    end
  end
end
