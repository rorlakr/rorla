class NewslettersController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :authenticate_user!, except: [:index, :show, :preview]
  before_action :set_newsletter, only: [:show, :preview, :edit, :update, :destroy]

  # GET /newsletters
  # GET /newsletters.json
  def index
    @newsletters = Newsletter.where( created_at: :desc )

    set_meta_tags og: {
      title: '뉴스레터',
      description: "1주간의 루비와 레일스 관련기사를 공개 모집하여 발송하는 신개념의 뉴스레터",
      image: root_url[0..-2] + ActionController::Base.helpers.asset_url('newsletter.png'),
      url: newsletters_url
    }, title: '뉴스레터'

  end

  # GET /newsletters/1
  # GET /newsletters/1.json
  def show

    set_meta_tags og: {
      title: @newsletter.title,
      description: truncate(@newsletter.greeting, :length   => 300, :separator => /\w/, :omission => "&hellip;"),
      image: root_url[0..-2] + ActionController::Base.helpers.asset_url('newsletter.png'),
      url: preview_newsletter_url(@newsletter)
    }, title: @newsletter.title

  end

  def preview

    set_meta_tags og: {
      title: @newsletter.title,
      description: truncate(@newsletter.greeting, :length   => 300, :separator => /\w/, :omission => "&hellip;"),
      image: root_url[0..-2] + ActionController::Base.helpers.asset_url('newsletter.png'),
      url: preview_newsletter_url(@newsletter)
    }, title: @newsletter.title

  end

  # GET /newsletters/new
  def new
    @newsletter = Newsletter.new
  end

  # GET /newsletters/1/edit
  def edit
  end

  # POST /newsletters
  # POST /newsletters.json
  def create
    @newsletter = Newsletter.new(newsletter_params)
    @newsletter.editor = current_user

    respond_to do |format|
      if @newsletter.save
        format.html { redirect_to @newsletter, notice: 'Newsletter was successfully created.' }
        format.json { render :show, status: :created, location: @newsletter }
      else
        format.html { render :new }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newsletters/1
  # PATCH/PUT /newsletters/1.json
  def update
    respond_to do |format|
      if @newsletter.update(newsletter_params)
        format.html { redirect_to @newsletter, notice: 'Newsletter was successfully updated.' }
        format.json { render :show, status: :ok, location: @newsletter }
      else
        format.html { render :edit }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newsletters/1
  # DELETE /newsletters/1.json
  def destroy
    @newsletter.destroy
    respond_to do |format|
      format.html { redirect_to newsletters_url, notice: 'Newsletter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsletter_params
      params.require(:newsletter).permit(:title, :title_color, :greeting, :published_at, :editor_id, :poster, :remove_poster )
    end
end
