# == Schema Information
#
# Table name: appliers
#
#  id          :integer          not null, primary key
#  schedule_id :integer
#  user_id     :integer
#  name        :string(255)      not null
#  email       :string(255)      not null
#  cellphone   :string(255)
#  remittor    :string(255)
#  remit_date  :datetime
#  remit_money :integer          default(0)
#  memo        :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  accepted    :boolean          default(FALSE)
#

class AppliersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_schedule
  before_action :set_applier, only: [:show, :edit, :update, :destroy, :accept, :recommand]

  def index
    # @schedule = Schedule.find(params[:schedule_id])
    @appliers = @schedule.appliers.order( created_at: :desc).paginate(page: params[:page], per_page: 10)
    @my_applier = current_user.appliers.find_by_schedule_id(@schedule.id) if user_signed_in?
  end

  def show
  end

  def new
    if @schedule.pre_start_date && Time.now < @schedule.pre_start_date
      flash[:error] =  '죄송합니다. 2016-05-23 00:00:00 +0900 부터 신청가능합니다. '
      redirect_to schedule_appliers_path(@schedule) and return
    end
    if @schedule.pre_end_date && Time.now >= @schedule.pre_end_date
      flash[:error] =  '죄송합니다. 사전등록이 마감되었습니다.  '
      redirect_to schedule_appliers_path(@schedule) and return
    end
    authorize_action_for Applier
    if @schedule.appliers.map(&:user).include?(current_user)
      @applier = current_user.appliers.find_by('schedule_id', @schedule)
      redirect_to edit_schedule_applier_path(@schedule, @applier), notice: '회원님은 이미 등록하셨습니다. 변경을 원하시면 수정 후 저장하시면 됩니다.' and return
    else
      @applier = @schedule.appliers.new(user_id: current_user.id, email: current_user.email)
    end
  end

  def edit
  end

  def create
    if @schedule.pre_start_date && Time.now < @schedule.pre_start_date
      flash[:error] =  '죄송합니다. 2016-05-23 00:00:00 +0900 부터 신청가능합니다. '
      redirect_to schedule_appliers_path(@schedule) and return
    end
    if @schedule.pre_end_date && Time.now >= @schedule.pre_end_date
      flash[:error] =  '죄송합니다. 사전등록이 마감되었습니다.  '
      redirect_to schedule_appliers_path(@schedule) and return
    end
    @applier = @schedule.appliers.new(applier_params)
    authorize_action_for Applier
    @applier.user = current_user

    respond_to do |format|
      if @applier.save
        UserMailer.confirm_application(current_user, @applier).deliver_later
        format.html { redirect_to [@schedule, @applier], notice: '신청접수가 완료되었습니다. 잠시후 확인메일이 발송됩니다.' }
        format.json { render :show, status: :created, location: @applier }
      else
        format.html { render :new }
        format.json { render json: @applier.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize_action_for @applier
    respond_to do |format|
      if @applier.update(applier_params)
        format.html { redirect_to [@schedule, @applier], notice: '접수내용이 변경되었습니다. ' }
        format.json { render :show, status: :created, location: @applier }
      else
        format.html { render :new }
        format.json { render json: @applier.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    authorize_action_for @applier
    @applier.destroy
    UserMailer.confirm_application_withdraw(current_user).deliver_later
    respond_to do |format|
      format.html { redirect_to schedule_appliers_url, notice: '신청 취소되었습니다.' }
      format.json { head :no_content }
    end
  end

  def accept
    authorize_action_for @applier
    @applier.toggle! :accepted
    UserMailer.confirm_application_accept(current_user, @applier).deliver_later if @applier.accepted
    respond_to do |format|
      format.html { redirect_to [@schedule, @applier], notice: ( @applier.accepted ? "최종승인되었습니다." : "승인취소되었습니다.")}
      format.json { render json: @applier }
      format.js
    end
  end

  def recommand
    authorize_action_for @applier
    if @applier.recommanded_by? current_user
      @applier.recommanders.delete current_user
    else
      @applier.recommanders << current_user
    end
    respond_to do |format|
      format.html { redirect_to [@schedule, @applier], notice: ( @applier.accepted ? "추천했습니다." : "추천을 취소했습니다.")}
      format.json { render json: @applier }
      format.js
    end
  end


  private

  def set_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end

  def set_applier
    @applier = @schedule.appliers.find(params[:id])
  end

  def applier_params
    params.require(:applier).permit(:schedule_id, :id, :name, :email, :cellphone, :remittor, :remit_date, :remit_money, :memo, :accepted)
  end

end
