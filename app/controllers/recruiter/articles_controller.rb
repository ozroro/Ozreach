class Recruiter::ArticlesController < ApplicationController
  before_action :login_required
  before_action :only_recruiter, except: [:index, :show]

  def index
    @articles = Article.all.recent
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to articles_path
    else
      render :new
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  
    def article_params
      params.require(:article).permit(:title, :content, :image)
    end

end
