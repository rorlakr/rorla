class PurchaseRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase_request, only: [:show, :edit, :update, :destroy, :confirm_request_toggle]

  # GET /purchase_requests
  # GET /purchase_requests.json
  def index
    @group_purchase = GroupPurchase.find(params[:group_purchase_id])
    @purchase_requests_all = @group_purchase.purchase_requests.order( created_at: :desc)
    @purchase_requests_shirts_all_count = @purchase_requests_all.includes(:items).sum(:count)
    @purchase_requests_shirts_white_count = @purchase_requests_all.includes(:items).where("items.shirts_color = 'W'").sum(:count)
    @purchase_requests_shirts_black_count = @purchase_requests_all.includes(:items).where("items.shirts_color = 'B'").sum(:count)
    @purchase_requests_confirmed = @purchase_requests_all.where(confirmed: true)
    @purchase_requests = @purchase_requests_all.paginate(:page => params[:page], :per_page => 10)

    set_meta_tags og: {
      title: "RORLab | #{@group_purchase.event_name}",
      description: @group_purchase.event_info,
      url: "/group_purchases/#{@group_purchase.id}/purchase_requests"
    }, title: @group_purchase.event_name
  end

  # GET /purchase_requests/1
  # GET /purchase_requests/1.json
  def show
    authorize_action_for @purchase_request
  end

  # GET /purchase_requests/new
  def new
    if params[:group_purchase_id]
      set_group_purchase
      authorize_action_for PurchaseRequest, for: @group_purchase
      @purchase_request = @group_purchase.purchase_requests.new
    else
      @purchase_request = PurchaseRequest.new
    end
  end

  # GET /purchase_requests/1/edit
  def edit
    authorize_action_for @purchase_request
  end

  # POST /purchase_requests
  # POST /purchase_requests.json
  def create
    if params[:group_purchase_id]
      set_group_purchase
      @purchase_request = @group_purchase.purchase_requests.new(purchase_request_params)
    else
      @purchase_request = PurchaseRequest.new(purchase_request_params)
    end
    @purchase_request.user = current_user

    respond_to do |format|
      if @purchase_request.save
        UserMailer.confirm_purchase_request(current_user).deliver_later
        format.html { redirect_to (params[:group_purchase_id] ? [@group_purchase, @purchase_request] : @purchase_request), notice: 'Purchase request was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_request }
      else
        flash.now[:error] = @purchase_request.errors.full_messages.join(" ")
        format.html { render :new }
        format.json { render json: @purchase_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_requests/1
  # PATCH/PUT /purchase_requests/1.json
  def update
    authorize_action_for @purchase_request
    respond_to do |format|
      if @purchase_request.update(purchase_request_params)
        format.html { redirect_to (params[:group_purchase_id] ? [@group_purchase, @purchase_request] : @purchase_request), notice: 'Purchase request was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_request }
      else
        format.html { render :edit }
        format.json { render json: @purchase_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_requests/1
  # DELETE /purchase_requests/1.json
  def destroy
    authorize_action_for @purchase_request
    @purchase_request.destroy
    respond_to do |format|
      format.html { redirect_to (params[:group_purchase_id] ? group_purchase_purchase_requests_url : purchase_requests_url), notice: 'Purchase request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm_request_toggle
    authorize_action_for @purchase_request
    if @purchase_request.confirmed
      @purchase_request.confirmed = false
      @purchase_request.confirmed_at = nil
    else
      @purchase_request.confirmed = true
      @purchase_request.confirmed_at = Time.now
    end
    @purchase_request.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_group_purchase
      @group_purchase = GroupPurchase.find(params[:group_purchase_id])
    end

    def set_purchase_request
      if params[:group_purchase_id]
        set_group_purchase
        @purchase_request = @group_purchase.purchase_requests.find(params[:id])
      else
        @purchase_request = PurchaseRequest.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_request_params
      params.require(:purchase_request).permit(:id, :user_id, :send_total_price, :send_date, :sender_name, :confirmed, :confirmed_at, :delivery, :parcel_zip, :parcel_addr, :parcel_receiver, :memo, items_attributes: [:id, :purchase_request_id, :shirts_color, :shirts_size, :count, :_destroy])
    end
end
