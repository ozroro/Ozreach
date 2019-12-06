class ArticlesController < ApplicationController
  include Pagy::Backend

  before_action :login_required


  def index
    @q = Recruiter::Article.all.ransack(search_params)
    @articles = @q.result.includes(user: :profile, image_attachment: :blob ).recent

    @pagy, @articles = pagy(@articles)

  end

  def show
    @article = Recruiter::Article.find(params[:id])

  end




  private
    


  def search_params
    search_conditions = %i(
      all_atr_cont_terms
      corporate_cont_terms title_cont_terms content_cont_terms
      created_at_gteq created_at_lteq_end_of_day
    )
    params.fetch(:q, {}).permit(search_conditions)
  end


    
end
