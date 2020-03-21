class Seeker::ApplicantsController < ApplicationController
  include Pagy::Backend

  before_action :login_required
  before_action :only_seeker

  def index
    @q = current_user.applicants.ransack(sort_params)
    @applicants = @q.result.includes(recruiter_article: { user: :profile })
    @pagy, @applicants = pagy(@applicants, items: 20)
  end

  def create
    @applicant = current_user.applicants.build(recruiter_article_id: params[:article_id])
    if @applicant.save
      redirect_to seeker_applicants_path, flash: { success: "#{@applicant.title}に応募しました。" }
    else
      redirect_to root_path, flash: { error: 'エラーが発生しました。' }
    end
  end

  def destroy
    if (@applicant = current_user.applicants.find_by(id: params[:id])) && @applicant.destroy
      redirect_to seeker_applicants_path, alert: '応募を取り消しました'
    else
      flash.now[:error] = 'エラーが発生しました。'
      render :index
    end
  end

  private

    def sort_params
      params.fetch(:q, {}).permit(:s)
    end
end
