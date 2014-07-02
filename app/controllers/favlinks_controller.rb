class FavlinksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_bundlelink, only: [:index]
  before_action :set_favlink, only: [:show, :edit, :update, :destroy]

  # GET /favlinks
  # GET /favlinks.json
  def index

  end

  # GET /favlinks/1
  # GET /favlinks/1.json
  def show
  end

  # GET /favlinks/new
  def new
    @favlink = Favlink.new
  end

  # GET /favlinks/1/edit
  def edit
    authorize_action_for @favlink
  end

  # POST /favlinks
  # POST /favlinks.json
  def create
    @favlink = current_user.favlinks.new(favlink_params)
    # @favlink.writer = current_user
    @favlink.capture_loc = rand_str
    respond_to do |format|
      if @favlink.save
        format.html { redirect_to @favlink, notice: 'Favlink was successfully created.' }
        format.json { render :show, status: :created, location: @favlink }
      else
        format.html { render :new }
        format.json { render json: @favlink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favlinks/1
  # PATCH/PUT /favlinks/1.json
  def update
    authorize_action_for @favlink
    @favlink.capture_loc = rand_str if @favlink.capture_loc.blank?
    respond_to do |format|
      if @favlink.update(favlink_params)
        format.html { redirect_to @favlink, notice: 'Favlink was successfully updated.' }
        format.json { render :show, status: :ok, location: @favlink }
      else
        format.html { render :edit }
        format.json { render json: @favlink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favlinks/1
  # DELETE /favlinks/1.json
  def destroy
    authorize_action_for @favlink
    @favlink.destroy
    respond_to do |format|
      format.html { redirect_to favlinks_url, notice: 'Favlink was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_bundlelink
      if params[:bundle_id]
        # @bundlelink = Bundlelink.find(params[:bundlelink_id])
        @favlinks = @bundlelink.favlinks
      else
        @favlinks = Favlink.all
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_favlink
      @favlink = Favlink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favlink_params
      params.require(:favlink).permit(:title, :description, :linkurl, :shared)
    end

    def rand_str(len=20)
      rand(36**len).to_s(36) + ".png"
    end

end
