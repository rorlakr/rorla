class TagsController < ApplicationController

  def list
    tags = ActsAsTaggableOn::Tag.where("name like ?", "%#{params[:q]}%")
    if tags.empty?
      render json: [{id: "<<<#{params[:q]}>>>", name: "New: \"#{params[:q]}\""}].to_json
      # ActsAsTaggableOn::Tag.create!(name: params[:q] )
    else
      tags
      render json: tags
    end
  end

end