class Recruiter::ApplicantsController < ApplicationController
  include Pagy::Backend
  before_action :only_recruiter

  def index
    @q = current_user.applicants.ransack(sort_params)
    @applicants = @q.result.includes(:user, :recruiter_article)
    @pagy, @applicants = pagy(@applicants, items: 20)
  end

  # TODO: destroy作成
  # def destroy
  # end

  def update
    # change state
    id = params[:id]
    @applicant = Seeker::Applicant.find_by(id: id)
    if @applicant&.recruiter == current_user
      @applicant.status = status_params[:status]
      @applicant.save
    end
  end

  def show
    @applicant = current_user.applicants.find_by(id: params[:id])
    @seeker = @applicant.user
  end

  private

    def status_params
      params.require(:seeker_applicant).permit(:status)
    end

    def sort_params
      params.fetch(:q, {}).permit(:s)
    end
end
