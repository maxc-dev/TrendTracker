class UserPrivaciesController < ApplicationController
  # GET /user_privacies
  # GET /user_privacies.json
  def index
    if current_user.present?
      if UserPrivacy.exists?(user_id: current_user.id)
        @agreedment_date = UserPrivacy.user_agreement(current_user.id).first.authorization
      else
        @agreedment_date = nil
      end
    end
  end
end
