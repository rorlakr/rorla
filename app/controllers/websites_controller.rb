class WebsitesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_website, only: [:show, :edit, :update, :destroy]

  # GET /websites
  # GET /websites.json
  def index
    @websites = Website.search(params[:search])
    @websites_total = @websites.count
    @websites = @websites.paginate(page: params[:page], per_page: 10)

    set_meta_tags og: {
      title: "루비와 레일스 웹서비스",
      description: "국내 레일스 웹서비스 DB",
      image: root_url[0..-2] + ActionController::Base.helpers.asset_url('rails_sites.png'),
      url: websites_url
    }, title: "루비와 레일스 웹서비스"

  end

  # GET /websites/1
  # GET /websites/1.json
  def show

    set_meta_tags og: {
      title: @website.name,
      description: truncate(@website.memo, :length   => 300, :separator => /\w/, :omission => "&hellip;"),
      image: root_url[0..-2] + ActionController::Base.helpers.asset_url('rails_sites.png'),
      url: website_url(@website)
    }, title: @website.name

  end

  # GET /websites/new
  def new
    authorize_action_for Website
    @website = Website.new
  end

  # GET /websites/1/edit
  def edit
    authorize_action_for @website
  end

  # POST /websites
  # POST /websites.json
  def create
    authorize_action_for Website
    @website = Website.new(website_params)
    @website.user = current_user

    respond_to do |format|
      if @website.save
        format.html { redirect_to @website, notice: 'Website was successfully created.' }
        format.json { render :show, status: :created, location: @website }
      else
        format.html { render :new }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /websites/1
  # PATCH/PUT /websites/1.json
  def update
    authorize_action_for @website
    respond_to do |format|
      if @website.update(website_params)
        format.html { redirect_to @website, notice: 'Website was successfully updated.' }
        format.json { render :show, status: :ok, location: @website }
      else
        format.html { render :edit }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    authorize_action_for @website
    @website.destroy
    respond_to do |format|
      format.html { redirect_to websites_url, notice: 'Website was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_website
      @website = Website.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def website_params
      params.require(:website).permit(:name, :site_url, :service_state, :service_type, :user_id)
    end
end
