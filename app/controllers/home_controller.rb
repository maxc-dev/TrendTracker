class HomeController < ApplicationController
  def home
    # user has selected the privacy agreement
    if params[:accept] == 'true' && params[:x].present? && params[:y].present?
      if current_user.present?
        # if the user has already agreed, delete data so it can be remade
        if UserPrivacy.exists?(user_id: current_user.id)
          logger.info 'Already agreed, deleting and making again.'
          UserPrivacy.user_agreement(current_user.id).destroy_all
        end

        # parse lat and long coords to decimals
        latitude = params[:x].to_d
        longitude = params[:y].to_d

        if ENV['ENCRYPTION_KEY'].nil?
          puts 'ERROR Encryption Key not initialized.'
        end

        #encrypts the data
        crypt = ActiveSupport::MessageEncryptor.new(ENV['ENCRYPTION_KEY'])
        encrypted_latitude = crypt.encrypt_and_sign(latitude)
        encrypted_longitude = crypt.encrypt_and_sign(longitude)

        # validates that the coords are legit
        if encrypted_latitude.present? && encrypted_longitude.present?
          # creates new user privacy table
          privacy_agreement = UserPrivacy.create(
            user_id: current_user.id,
            latitude: encrypted_latitude,
            longitude: encrypted_longitude,
            authorization: DateTime.current
          )

          # log to server if data saves or not, then redirect
          if privacy_agreement.save
            puts 'User Privacy Agreement Accepted Successfully'
          else
            puts 'Something went wrong!'
          end
          redirect_to discoveries_path
        end
      else
        redirect_to discoveries_path
      end
      # if the user declines agreement, delete their data
    elsif params[:accept] == 'false' && current_user.present?
      if UserPrivacy.exists?(user_id: current_user.id)
        UserPrivacy.user_agreement(current_user.id).destroy_all
        logger.info 'Already agreed, but now deleting data'
        redirect_to discoveries_path
      end
    end
  end
end
