# == Schema Information
#
# Table name: podcasts
#
#  id             :integer          not null, primary key
#  uid            :string(255)
#  title          :string(255)
#  author         :string(255)
#  description    :text(65535)
#  enclosure_url  :text(65535)
#  enclosure_size :integer          default(0)
#  duration       :string(255)
#  published_at   :date
#  created_at     :datetime
#  updated_at     :datetime
#

class PodcastsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  # GET /podcasts
  def index
    @podcasts = Podcast.order(uid: :desc).paginate(:page => params[:page], :per_page => 20)
  end

  # GET /podcasts/1
  def show
    @podcast = Podcast.find(params[:id])
    @comment = @podcast.comments.build
    impressionist(@podcast, "message...")
  end

  # GET /podcasts/grap
  def grap
    if current_user.has_role?(:admin)
      PodcastJob.new.async.perform
      flash.now[:notice] = "팟캐스트 수집요청 완료"
    else
      flash.now[:alert] = "admin만 가능한 기능입니다"
    end
  end
end
