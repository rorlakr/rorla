class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show]
  before_action :set_question
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # respond_to :json

  def index
    @answers = @question.answers
    render json: @answers
  end

  def show
  end

  def new
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save!

    redirect_to question_path(@question)
  rescue ActiveRecord::RecordInvalid
    render "new"
  end

  def update
    @answer.update!(answer_params)

    redirect_to question_path(@question)
  rescue ActiveRecord::RecordInvalid
    render "edit"
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@question)
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_answer
      @answer = @question.answers.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:title, :content)
    end
end
