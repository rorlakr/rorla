class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.writer_id = current_user.id
    if @comment.save
      flash[:alert] = ">> Comment successfully saved."
    else
      flash[:alert] = ">> Comment was not saved."
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    authorize_action_for @comment
    if @comment.destroy
      flash[:alert] = ">> Comment successfully deleted."
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
