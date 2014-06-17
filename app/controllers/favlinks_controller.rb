class FavlinksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_favlink, only: [:show, :edit, :update, :destroy]

  # GET /favlinks
  # GET /favlinks.json
  def index
    @favlinks = Favlink.all
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
    @favlink = Favlink.new(favlink_params)
    @favlink.writer = current_user
    @favlink.capture_loc = save_capture_image(@favlink.linkurl)
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
    @favlink.capture_loc = save_capture_image(@favlink.linkurl)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_favlink
      @favlink = Favlink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favlink_params
      params.require(:favlink).permit(:title, :description, :linkurl, :shared)
    end

    def save_capture_image(linkurl)
      tmp_capture_loc = Webshots::Processor.url_to_png linkurl
      capture_loc = tmp_capture_loc.split('/').last
      FileUtils.mv(tmp_capture_loc, 'public/uploads/capture_loc/' + capture_loc)
      capture_loc
    end
end
