class NewslettersController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :authenticate_user!, except: [:index, :show, :preview, :new_subscribe, :subscribe, :unsubscribe]
  before_action :set_newsletter, only: [:show, :preview, :sendmail, :edit, :update, :destroy]

  # GET /newsletters
  # GET /newsletters.json
  def index
    @newsletters = Newsletter.order( created_at: :desc )

    set_meta_tags default_meta_tags
  end

  # GET /newsletters/1
  # GET /newsletters/1.json
  def show
    set_meta_tags build_meta_tags(@newsletter)
  end

  def preview
    set_meta_tags build_meta_tags(@newsletter)
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

  def new_subscribe
    if params[:email]
      @user_email = email_param
    end
  end

  def subscribe
    flash.delete :recaptcha_error
    user_email = User.find_by(id: params[:user_id]).email || email_param
    flash[:notice] = subscribe_user(user_email)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def unsubscribe
    user_email = User.find_by(id: params[:user_id]).email || email_param

    flash[:notice] = \
      if Newsletter.unsubscribe(user_email)
        UserMailer.confirm_unsubscribe_newsletter(user_email).deliver_later
        '구독 해제되었습니다. 잠시 후 이메일을 확인하시기 바랍니다.'
      else
        '이미 구독해제 상태입니다.'
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
      params.require(:newsletter)
        .permit(:title, :title_color, :greeting, :published_at,
                :editor_id, :poster, :remove_poster)
    end

    def subscribe_user(user_email)
      return '로봇이 아니면 로봇여부를 체크해 주세요.' unless verify_recaptcha
      result = Newsletter.subscribe(user_email) || '이미 구독 중입니다.'
      if result == 'added'
        UserMailer.confirm_subscribe_newsletter(user_email).deliver_later
        '구독 신청이 완료되었습니다. 잠시 후 이메일을 확인하시기 바랍니다.'
      else
        result
      end
    end

    def email_param
      Base64.urlsafe_decode64(params[:email])
    rescue => e
      params[:email]
    end

    def default_meta_tags
      {
        og: {
          title: '뉴스레터',
          description: '1주간의 루비와 레일스 관련기사를 공개 모집하여 발송하는 신개념의 뉴스레터',
          image: root_url[0..-2] + ActionController::Base.helpers.asset_url('newsletter.png'),
          url: newsletters_url
        },
        title: '뉴스레터'
      }
    end

    def build_meta_tags(newsletter)
      default_meta_tags.merge(
        og: {
          title: newsletter.title.presence,
          description: truncate(newsletter.greeting, length: 300, separator: /\w/, omission: '&hellip;'),
          image: root_url[0..-2] + ActionController::Base.helpers.asset_url('newsletter.png'),
          url: preview_newsletter_url(newsletter)
        }, title: newsletter.title)
    end
end
