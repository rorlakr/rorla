class Api::AnswersController < ApplicationController
  before_action :set_question
  before_action :set_answer, only: [:show]

  def index
    @answers = @question.answers
  end

  def show
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_answer
      @answer = @question.answers.find(params[:id])
    end
end