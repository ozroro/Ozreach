class Recruiter::ApplicantsController < ApplicationController
  include Pagy::Backend
  before_action :only_recruiter

  def index
    @q = current_user.applicants.ransack(sort_params)
    @applicants = @q.result.includes(:user, :recruiter_article)
    @pagy, @applicants = pagy(@applicants, items: 20)
  end

  def destroy
  end

  private

    def sort_params
      params.fetch(:q, {}).permit(:s)
    end
end
