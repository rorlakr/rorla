class ApplicationController < ActionController::Base
  include MeritHelper
  before_action :resource_refresh  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_bulletins

  layout :dynamic_layout

  def authority_forbidden(error)
    Authority.logger.warn(error.message)
    redirect_to request.referrer.presence || root_path, :alert => 'You are not authorized to complete that action.'
  end

  private
    def dynamic_layout
      devise_controller? ? 'devise_layout' : 'general_layout'
    end

    def set_bulletins
      # nav_bar 메뉴 Bulletins의 항목을 가져옴.
      @bulletin_titles = Bulletin.all.map { |bulletin| bulletin.title }
    end
end
