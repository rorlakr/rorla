# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  taggings_count :integer          default(0)
#

class TagsController < ApplicationController

  def list
    @tags = Tag.order(:name)
    render json: @tags.tokens(params[:q])
  end

end
