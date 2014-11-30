class WeeklynewsController < ApplicationController
  def index
    @items = Weeklynews.order(sended_at: :desc).paginate(:page => params[:page], :per_page => 20)    
  end

  def grap
    if current_user.has_role?(:admin)
      WeeklynewsJob.new.async.perform
      flash.now[:notice] = "주간뉴스 수집요청 완료"
    else
      flash.now[:alert] = "admin만 가능한 기능입니다"
    end
  end
end
