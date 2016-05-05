# == Schema Information
#
# Table name: group_purchases
#
#  id         :integer          not null, primary key
#  event_name :string(255)      not null
#  event_info :text(65535)
#  start_date :datetime         not null
#  end_date   :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupPurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_group_purchase, only: [:show, :edit, :update, :destroy]

  # GET /group_purchases
  # GET /group_purchases.json
  def index
    @group_purchases = GroupPurchase.order(created_at: :desc)
  end

  # GET /group_purchases/1
  # GET /group_purchases/1.json
  def show
  end

  # GET /group_purchases/new
  def new
    authorize_action_for GroupPurchase
    @group_purchase = GroupPurchase.new
  end

  # GET /group_purchases/1/edit
  def edit
    authorize_action_for @group_purchase
  end

  # POST /group_purchases
  # POST /group_purchases.json
  def create
    authorize_action_for GroupPurchase
    @group_purchase = GroupPurchase.new(group_purchase_params)
    @group_purchase.user = current_user

    respond_to do |format|
      if @group_purchase.save
        format.html { redirect_to @group_purchase, notice: 'Group purchase was successfully created.' }
        format.json { render :show, status: :created, location: @group_purchase }
      else
        format.html { render :new }
        format.json { render json: @group_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_purchases/1
  # PATCH/PUT /group_purchases/1.json
  def update
    authorize_action_for @group_purchase
    respond_to do |format|
      if @group_purchase.update(group_purchase_params)
        format.html { redirect_to @group_purchase, notice: 'Group purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_purchase }
      else
        format.html { render :edit }
        format.json { render json: @group_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_purchases/1
  # DELETE /group_purchases/1.json
  def destroy
    authorize_action_for @group_purchase
    @group_purchase.destroy
    respond_to do |format|
      format.html { redirect_to group_purchases_url, notice: 'Group purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_purchase
      @group_purchase = GroupPurchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_purchase_params
      params.require(:group_purchase).permit(:event_name, :event_info, :start_date, :end_date, :user_id)
    end
end
