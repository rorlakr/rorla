class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_newsletter

  def new
    @article = @newsletter.articles.build(news_section_id: params[:news_section_id])
  end

  def edit
    @article = @newsletter.articles.find(params[:id])
  end

  def create
    @article = @newsletter.articles.build(article_params)
    @article.reporter = current_user
    if @article.save
      respond_to do |format|
        format.html { redirect_to @newsletter, notice: "저장되었습니다." }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, flash: { error: @article.errors.full_messages.join(", ") } }
        format.js
      end
    end
  end

  def update
    @article = @newsletter.articles.find(params[:id])
    if @article.update(article_params)
      respond_to do |format|
        format.html
        format.js
      end
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def destroy
    @article = @newsletter.articles.find(params[:id])
    if @article.destroy
      respond_to do |format|
        format.html
        format.js
      end
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  private

  def set_newsletter
    @newsletter = Newsletter.find(params[:newsletter_id])
  end

  def article_params
    params.require(:article).permit( :title, :content, :reference_url, :poster, :news_section_id )
  end


end
