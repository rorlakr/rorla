class AnswersController < ApplicationController
  before_action :set_question
  before_action :set_answer, only: [:update, :destroy]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save!

    # redirect_to question_path(@question)
  rescue ActiveRecord::RecordInvalid
    @errors = @answer.errors.messages.map { |field, messages|
      messages.map { |message| [t("labels.answer.#{field}"), message].join }
    }.flatten

    # redirect_to question_path(@question), flash: { error: errors }
  end

  def update
    @answer.useful!(current_user, params[:useful] == "true")

    # redirect_to question_path(@question)
  rescue ActiveRecord::RecordInvalid
    #TODO: 에러 처리
    # redirect_to question_path(@question)
  end

  def destroy
    @answer.destroy
    # redirect_to question_path(@question)
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_answer
      @answer = @question.answers.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:content)
    end
end
