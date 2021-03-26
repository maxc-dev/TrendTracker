class HomeController < ApplicationController
  def home
    # temp redirect to map page until home page complete
    redirect_to discoveries_path
  end
end
