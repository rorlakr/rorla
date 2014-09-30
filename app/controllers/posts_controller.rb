class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_bulletin
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = @bulletin.posts.all
    @posts = @posts.paginate(page: params[:page], per_page: 10)

    if request.xhr?
      sleep(3)
      render :partial => @plazas
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    impressionist(@post, "message...") if !user_signed_in? or (user_signed_in? and current_user != @post.writer)
  end

  # GET /posts/new
  def new
    authorize_action_for Post, for: @bulletin
    @post = @bulletin.posts.new
  end

  # GET /posts/1/edit
  def edit
    authorize_action_for @post
  end

  # POST /posts
  # POST /posts.json
  def create
    authorize_action_for Post, for: @bulletin
    @post = @bulletin.posts.new(post_params)
    @post.writer = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to [@post.bulletin, @post], notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    authorize_action_for @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to [@post.bulletin, @post], notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    authorize_action_for @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to bulletin_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_bulletin
      @bulletin = Bulletin.friendly.find(params[:bulletin_id])
    end

    def set_post
      @post = @bulletin.posts.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :picture, :picture_cache, :published)
    end
end
