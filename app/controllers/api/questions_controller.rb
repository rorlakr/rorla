class Api::QuestionsController < ApplicationController
  before_filter :set_question, only: [:show]
  
  def index
    @questions = Question.all
  end

  def show
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end
end