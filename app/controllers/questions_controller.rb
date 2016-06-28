# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  sash_id    :integer
#  level      :integer          default(0)
#

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all

    set_meta_tags og: {
      title: "Q&A",
      description: "루비와 레일스 관련 질문과 답변",
      image: root_url[0..-2] + ActionController::Base.helpers.asset_url('q_&_a.png'),
      url: questions_url
    }, title: "Q&A"

  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    impressionist(@question, "message...") if !user_signed_in? or (user_signed_in? and current_user != @question.user)

    set_meta_tags og: {
      title: @question.title,
      description: @question.content,
      image: root_url[0..-2] + ActionController::Base.helpers.asset_url('q_&_a.png'),
      url: question_path(@question)
    }, title: @question.title

  end

  # GET /questions/new
  def new
    authorize_action_for Question
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    authorize_action_for @question
  end

  # POST /questions
  # POST /questions.json
  def create
    authorize_action_for Question
    @question = current_user.questions.new(question_params)
    @question.user = current_user

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    authorize_action_for @question
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    authorize_action_for @question
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = current_user.questions.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :content)
    end
end
