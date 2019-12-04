class Recruiter::ApplicantsController < ApplicationController
  include Pagy::Backend
  before_action :only_recruiter

    def index
    @q = current_user.applicants.ransack(params[:q])
    @applicants = @q.result.includes(:user, :recruiter_article)
    @pagy, @applicants = pagy(@applicants)
  end

  def destroy
  end
end
