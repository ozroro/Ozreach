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

    if (@applicant.user == current_user) && @applicant.save
      # TODO: :notice
      flash[:notice] = '応募しました。'
      redirect_to seeker_applicants_path
    else
      # TODO: エラー表示
      redirect_to root_path
    end
  end

  def destroy
    @applicant = Seeker::Applicant.find(params[:id])
    if @applicant.user == current_user && @applicant.destroy
      # TODO: :notice
      flash[:notice] = '応募を取り消しました'
      # TODO: elseを加えて エラー表示
    end
    redirect_to seeker_applicants_path
  end

  private

    def sort_params
      params.fetch(:q, {}).permit(:s)
    end
end
