# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  writer_id        :integer
#  content          :text(65535)      not null
#  created_at       :datetime
#  updated_at       :datetime
#

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable

  def create
    @comment = @commentable.comments.build(comment_params)
    authorize_action_for Comment
    @comment.writer_id = current_user.id
    if @comment.save
      UserMailer.confirm_comment_sent(current_user, @comment).deliver_later
      flash[:notice] = ">> Comment successfully saved."
    else
      flash[:alert] = ">> 오류가 발생했습니다: " + @comment.errors.get(:content).join(', ')
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    authorize_action_for @comment
    if @comment.destroy
      flash[:notice] = ">> Comment successfully deleted."
    else
      flash[:alert] = ">> Comment was not deleted."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_commentable
    @commentable = find_commentable
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
