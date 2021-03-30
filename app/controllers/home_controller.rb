class HomeController < ApplicationController
  def home
    # user has selected the privacy agreement
    if params[:accept] == 'true' && params[:x].present? && params[:y].present?  # && current_user.present?
      latitude = params[:x].to_d
      longitude = params[:y].to_d

      if latitude.present? && longitude.present?
        privacy_agreement = UserPrivacy.create(
          user_id: current_user.id,
          latitude: latitude,
          longitude: longitude,
          authorization: DateTime.current
        )
        if privacy_agreement.save
          logger.info 'User Privacy Agreement Accepted Successfully'
        else
          logger.info 'Something went wrong!'
        end
      end

    else
      logger.info 'nay'
    end
  end
end
