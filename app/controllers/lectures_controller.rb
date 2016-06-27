# == Schema Information
#
# Table name: lectures
#
#  id           :integer          not null, primary key
#  course_id    :integer
#  title        :string(255)      not null
#  content      :text(65535)
#  youtube_url  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  published    :boolean          default(FALSE)
#  published_at :datetime
#

class LecturesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_course
  before_action :set_lecture, only: [ :show, :edit, :update, :destroy]

  def index
    @lectures = @course.lectures.published
    @my_lectures = @course.lectures.my_lectures(current_user)

    set_meta_tags og: {
      title: @course.title,
      description: @course.summary,
      image: root_url[0..-2] + ActionController::Base.helpers.asset_url('lecture.png'),
      url: course_lectures_url(@course)
    }, title: @course.title
  end

  def new
    @lecture = @course.lectures.new
  end

  def show

    set_meta_tags og: {
      title: @lecture.title,
      description: @lecture.content,
      image: root_url[0..-2] + ActionController::Base.helpers.asset_url('lecture.png'),
      url: course_lectures_url(@lecture.course, @lecture)
    }, title: @lecture.title

  end

  def edit
    authorize_action_for @lecture
  end

  def create
    @lecture = @course.lectures.new(lecture_params)
    @lecture.user = current_user
    @lecture.save
    redirect_to [@course, @lecture], notice: "강의록이 생성되었습니다."
  end

  def update
    authorize_action_for @lecture
    @lecture.update(lecture_params)
    @lecture.save
    redirect_to [@course, @lecture], notice: "강의록이 생성되었습니다."
  end

  def destroy
    authorize_action_for @lecture
    @lecture.destroy
    redirect_to course_lectures_path(@course), notice: "강의록이 삭제되었습니다."
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lecture
    @lecture = @course.lectures.find(params[:id])
  end

  def lecture_params
    params.require(:lecture).permit( :title, :content, :youtube_url, :published, :published_at, :user_id, :course_id)
  end

end
