class WeeklynewsController < ApplicationController
  def index
    @items = Weeklynews.order(sended_at: :desc).paginate(:page => params[:page], :per_page => 20)
    set_meta_tags og: {
      title: "RORLab | 주간뉴스",
      description: "지난 한주간에 걸친 루비와 레일스 관련 정보를 정리하여 매주 일요일 자정에 주간뉴스 구독자에게 이메일을 발송하고 있습니다. 구독신청은 http://weekly.rorlab.org 입니다.",
      url: weeklynews_path
    }, title: "RORLab | 주간뉴스"    
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
