class HomeController < ApplicationController
  def home
    # user has selected the privacy agreement
    if params[:accept] == 'true' && params[:x].present? && params[:y].present?  # && current_user.present?
      lat = params[:x].to_d
      long = params[:y].to_d
      logger.info "[#{lat}],[#{long}]"

      #search for nearest location or store coords in database?

    else
      logger.info 'nay'
    end
  end
end
