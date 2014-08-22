class BundlelinksController < ApplicationController
  before_action :set_bundlelink, only: [:show, :edit, :update, :destroy]

  # GET /bundlelinks
  # GET /bundlelinks.json
  def index
    @bundlelinks = Bundlelink.my_bundles(current_user)
  end

  # GET /bundlelinks/1
  # GET /bundlelinks/1.json
  def show
  end

  # GET /bundlelinks/new
  def new
    @bundlelink = Bundlelink.new
  end

  # GET /bundlelinks/1/edit
  def edit
  end

  # POST /bundlelinks
  # POST /bundlelinks.json
  def create
    @bundlelink = current_user.bundlelinks.new(bundlelink_params)

    respond_to do |format|
      if @bundlelink.save
        format.html { redirect_to @bundlelink, notice: 'Bundlelink was successfully created.' }
        format.json { render :show, status: :created, location: @bundlelink }
      else
        format.html { render :new }
        format.json { render json: @bundlelink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bundlelinks/1
  # PATCH/PUT /bundlelinks/1.json
  def update
    respond_to do |format|
      if @bundlelink.update(bundlelink_params)
        format.html { redirect_to @bundlelink, notice: 'Bundlelink was successfully updated.' }
        format.json { render :show, status: :ok, location: @bundlelink }
      else
        format.html { render :edit }
        format.json { render json: @bundlelink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bundlelinks/1
  # DELETE /bundlelinks/1.json
  def destroy
    @bundlelink.destroy
    respond_to do |format|
      format.html { redirect_to bundlelinks_url, notice: 'Bundlelink was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bundlelink
      @bundlelink = Bundlelink.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bundlelink_params
      params.require(:bundlelink).permit(:title, :description, :shared)
    end
end
