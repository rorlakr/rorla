class PodcastsController < ApplicationController
  # GET /podcasts
  def index
    @podcasts = Podcast.order(uid: :desc).paginate(:page => params[:page], :per_page => 20)
  end

  # GET /podcasts/1
  def show
    @podcast = Podcast.find(params[:id])
  end
end
