class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action -> { Time.zone = 'London' }

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private

  def render_404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
      format.xml {head :not_found}
      format.any {head :not_found}
    end
  end

end
