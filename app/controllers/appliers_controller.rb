class AppliersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_schedule
  before_action :set_applier, only: [:show, :edit, :update, :destroy]

  def index
    # @schedule = Schedule.find(params[:schedule_id])
    @appliers = @schedule.appliers.order( created_at: :desc)
    @applier = current_user.appliers.find_by('schedule_id', @schedule)
  end

  def show
  end

  def new
    # @schedule = Schedule.find(params[:schedule_id])
    # authorize_action_for Applier, for: @schedule

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
    # @schedule = Schedule.find(params[:schedule_id])
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
    respond_to do |format|
      format.html { redirect_to schedule_appliers_url, notice: '신청 취소되었습니다.' }
      format.json { head :no_content }
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
    params.require(:applier).permit(:schedule_id, :id, :name, :email, :cellphone, :remittor, :remit_date, :remit_money, :memo)
  end

end
