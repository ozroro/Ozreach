class Recruiter::ArticlesController < ApplicationController
  before_action :login_required
  before_action :only_recruiter, except: [:index, :show]

  def index
    @articles = Recruiter::Article.all.recent
  end

  def show
    @article = Recruiter::Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to home_path
    else
      render :fail
    end

  end

  def fail
    
  end


  def edit
  end

  def update
  end

  def destroy
  end

  private
  
    def article_params
      params.require(:recruiter_article).permit(:title, :content, :image)
    end

end
