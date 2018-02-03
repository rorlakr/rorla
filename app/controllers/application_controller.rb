class ApplicationController < ActionController::Base
  before_action :set_bulletins
  before_action :set_metatags

  layout :dynamic_layout

  def authority_forbidden(error)
    Authority.logger.warn(error.message)
    redirect_to request.referrer.presence || root_path, :alert => '회원님은 이 작업에 대한 권한이 없습니다.'
  end

  def default_url_options
    if Rails.env.production?
      {:host => 'rorlab.org', :port => nil}
    else
      {}
    end
  end

  private
    def dynamic_layout
      devise_controller? ? 'devise_layout' : 'general_layout'
    end

    def set_bulletins
      # nav_bar 메뉴 Bulletins의 항목을 가져옴.
      @bulletin_titles = Bulletin.all.map { |bulletin| bulletin.title }
    end

    def set_metatags
      set_meta_tags fb: {
          app_id: '140309816373762'
      }
      set_meta_tags :og => {
        :type         => 'website',
        :description  => 'Ruby & Rails Lectures for Startups',
        :image        =>  root_url[0..-2] + ActionController::Base.helpers.asset_url('rorlab_logo_158x158.png'),
        :site_name    => 'RORLAB'
      }
    end
end
