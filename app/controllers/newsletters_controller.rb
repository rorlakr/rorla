class NewslettersController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :authenticate_user!, except: [:index, :show, :preview, :subscribe, :unsubscribe ]
  before_action :set_newsletter, only: [:show, :preview, :sendmail, :edit, :update, :destroy]

  # GET /newsletters
  # GET /newsletters.json
  def index
    @newsletters = Newsletter.order( created_at: :desc )

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

  def sendmail
    to = params[:to]
    UserMailer.send_newsletter(to, @newsletter).deliver_later
    respond_to do |format|
      format.html
      format.js
    end
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

  def subscribe
    begin
      user_email = params[:user_id] ? User.find(params[:user_id]).email : Base64.urlsafe_decode64(params[:email])
    rescue => e
      user_email = params[:email]
    end
    if Newsletter.subscribe(user_email)
      UserMailer.confirm_subscribe_newsletter(user_email).deliver_later
      flash[:notice] = '구독 신청이 완료되었습니다. 잠시 후 이메일을 확인하시기 바랍니다. '
    else
      flash[:notice] = "이미 구독 중입니다."
    end
    respond_to do |format|
      format.html { redirect_to newsletters_url }
      format.js
    end
  end

  def unsubscribe
    begin
      user_email = params[:user_id] ? User.find(params[:user_id]).email : Base64.urlsafe_decode64(params[:email])
    rescue => e
      user_email = params[:email]
    end
    if Newsletter.unsubscribe(user_email)
      UserMailer.confirm_unsubscribe_newsletter(user_email).deliver_later
      flash[:notice] = '구독 해제되었습니다. 잠시 후 이메일을 확인하시기 바랍니다.'
    else
      flash[:notice] = "이미 구독해제 상태입니다."
    end
    respond_to do |format|
      format.html { redirect_to newsletters_url}
      format.js
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
