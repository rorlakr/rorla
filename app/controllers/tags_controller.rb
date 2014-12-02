class TagsController < ApplicationController

  def list
    @tags = Tag.order(:name)
    render json: @tags.tokens(params[:q])
  end

end