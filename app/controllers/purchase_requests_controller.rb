class PurchaseRequestsController < ApplicationController
  before_action :set_purchase_request, only: [:show, :edit, :update, :destroy]

  # GET /purchase_requests
  # GET /purchase_requests.json
  def index
    @purchase_requests = PurchaseRequest.all
  end

  # GET /purchase_requests/1
  # GET /purchase_requests/1.json
  def show
  end

  # GET /purchase_requests/new
  def new
    @purchase_request = PurchaseRequest.new
  end

  # GET /purchase_requests/1/edit
  def edit
  end

  # POST /purchase_requests
  # POST /purchase_requests.json
  def create
    @purchase_request = PurchaseRequest.new(purchase_request_params)

    respond_to do |format|
      if @purchase_request.save
        format.html { redirect_to @purchase_request, notice: 'Purchase request was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_request }
      else
        format.html { render :new }
        format.json { render json: @purchase_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_requests/1
  # PATCH/PUT /purchase_requests/1.json
  def update
    respond_to do |format|
      if @purchase_request.update(purchase_request_params)
        format.html { redirect_to @purchase_request, notice: 'Purchase request was successfully updated.' }
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
    @purchase_request.destroy
    respond_to do |format|
      format.html { redirect_to purchase_requests_url, notice: 'Purchase request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_request
      @purchase_request = PurchaseRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_request_params
      params.require(:purchase_request).permit(:user_id, :req_date, :send_date, :sender_name, :amount, :confirmed, :confirmed_at)
    end
end
