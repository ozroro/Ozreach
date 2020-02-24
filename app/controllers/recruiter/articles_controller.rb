class Recruiter::ArticlesController < ApplicationController
  include Pagy::Backend

  before_action :login_required
  before_action :only_recruiter
  before_action :collect_user, only: [:edit, :update, :destroy]

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

  # TODO: 無いidを参照したときのエラー表示
  def edit
    @article = Recruiter::Article.find(params[:id])
  end

  def update
    @article = Recruiter::Article.find(params[:id])

    if @article.update(article_params)
      redirect_to home_path
    else
      render :fail
    end
  end

  def destroy
    @article = Recruiter::Article.find(params[:id])

    if @article.destroy
      redirect_to home_path, notice: '記事を削除しました。'
    else
      render :fail
    end
  end

  def articles
  end

  private

    def article_params
      params.require(:recruiter_article).permit(:title, :content, :image)
    end

    def search_params
      search_conditions = %i[
        all_atr_cont_terms
        corporate_cont_terms title_cont_terms content_cont_terms
        created_at_gteq created_at_lteq_end_of_day
      ]
      params.fetch(:q, {}).permit(search_conditions)
    end

    def collect_user
      redirect_to root_url unless current_user.articles.exists?(id: params[:id])
    end
end
