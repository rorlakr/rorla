class FavlinksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_bundlelink
  before_action :set_favlink, except: [:index, :new, :create]

  # GET /favlinks
  # GET /favlinks.json
  def index

    @favlinks = Favlink.shared
    @favlinks = Favlink.search(params[:search]) if params[:search]
    @favlinks = @bundlelink.favlinks if params[:bundlelink_id]
    @favlinks = Favlink.whose(current_user) if params[:whose]
    @favlinks = @favlinks.tagged_with(params[:tag]) if params[:tag]

    @favlinks = @favlinks.paginate(page: params[:page], per_page: 10)
    if request.xhr?
      sleep(3)
      render :partial => @favlinks
    end
  end

  # GET /favlinks/1
  # GET /favlinks/1.json
  def show
    @comment = @favlink.comments.build
    impressionist(@favlink, "message...") if !user_signed_in? or (user_signed_in? and current_user != @favlink.writer)
  end

  # GET /favlinks/new
  def new
    @favlink = @bundlelink ? @bundlelink.favlinks.new : Favlink.new
  end

  # GET /favlinks/1/edit
  def edit
    authorize_action_for @favlink
  end

  # POST /favlinks
  # POST /favlinks.json
  def create
    if @bundlelink
      @favlink = @bundlelink.favlinks.new(favlink_params)
      @favlink.writer = current_user
    else
      @favlink = current_user.favlinks.new(favlink_params)
    end
    @favlink.capture_loc = rand_str
    respond_to do |format|
      if @favlink.save
        if @bundlelink
          format.html { redirect_to [@favlink.bundlelink, @favlink], notice: 'Favlink was successfully created.' }
          format.json { render :show, status: :created, location: [@favlink.bundlelink, @favlink] }
        else
          format.html { redirect_to @favlink, notice: 'Favlink was successfully created.' }
          format.json { render :show, status: :created, location: @favlink }
        end
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
        format.html { redirect_to (@bundlelink ? [@bundlelink, @favlink] : @favlink), notice: 'Favlink was successfully updated.' }
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
      format.html { redirect_to @bundlelink ? bundlelink_favlinks_url : favlinks_url, notice: 'Favlink was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_bundlelink
      if params[:bundlelink_id]
        @bundlelink = Bundlelink.friendly.find(params[:bundlelink_id])
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_favlink
      @favlink = @bundlelink ? @bundlelink.favlinks.find(params[:id]) : Favlink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favlink_params
      params.require(:favlink).permit(:title, :description, :linkurl, :shared, :bundlelink_id, :with_screen_shot, :tag_list)
    end

    def rand_str(len=20)
      rand(36**len).to_s(36) + ".png"
    end

end
