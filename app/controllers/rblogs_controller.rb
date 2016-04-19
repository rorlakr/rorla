class RblogsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_rblog, only: [:show, :edit, :update, :destroy]

  # GET /rblogs
  # GET /rblogs.json
  def index
    if params[:whose]
      @rblogs = Rblog.my_blogs(params[:whose])
      if params[:private]
        @rblogs = @rblogs.my_private_blogs(params[:whose])
      else
        @rblogs = @rblogs.my_shared_blogs(params[:whose])
      end
    else
      @rblogs = Rblog.shared
    end
    @rblogs = @rblogs.paginate(page: params[:page], per_page: 10)
    if request.xhr?
      sleep(3)
      render :partial => @rblogs
    end
  end

  # GET /rblogs/1
  # GET /rblogs/1.json
  def show
    @comment = @rblog.comments.build
    impressionist(@rblog, "message...") if !user_signed_in? or (user_signed_in? and current_user != @rblog.writer)

    set_meta_tags og: {
      title: "RORLab | #{@rblog.title}",
      description: truncate(@rblog.content, :length   => 300, :separator => /\w/, :omission => "&hellip;"),
      url: rblog_path(@rblog)
    }, title: @rblog.title
  end

  # GET /rblogs/new
  def new
    @rblog = Rblog.new
  end

  # GET /rblogs/1/edit
  def edit
    authorize_action_for @rblog
  end

  # POST /rblogs
  # POST /rblogs.json
  def create
    @rblog = Rblog.new(rblog_params)
    @rblog.writer = current_user

    respond_to do |format|
      if @rblog.save
        format.html { redirect_to @rblog, notice: 'Rblog was successfully created.' }
        format.json { render :show, status: :created, location: @rblog }
      else
        format.html { render :new }
        format.json { render json: @rblog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rblogs/1
  # PATCH/PUT /rblogs/1.json
  def update
    authorize_action_for @rblog
    respond_to do |format|
      if @rblog.update(rblog_params)
        format.html { redirect_to @rblog, notice: 'Rblog was successfully updated.' }
        format.json { render :show, status: :ok, location: @rblog }
      else
        format.html { render :edit }
        format.json { render json: @rblog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rblogs/1
  # DELETE /rblogs/1.json
  def destroy
    authorize_action_for @rblog
    @rblog.destroy
    respond_to do |format|
      format.html { redirect_to rblogs_url, notice: 'Rblog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rblog
      @rblog = Rblog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rblog_params
      params.require(:rblog).permit(:title, :content, :writer_id, :shared, :tag_tokens)
    end
end
