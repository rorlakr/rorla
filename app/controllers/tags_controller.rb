class TagsController < ApplicationController

  def list
    render json: ActsAsTaggableOn::Tag.select([:id, :name]).where("name like ?", "%#{params[:q]}%")
  end

end