class Recruiter::ApplicantsController < ApplicationController
  before_action :only_recruiter
  def index
    @q = current_user.applicants.ransack(params[:q])
    @applicants = @q.result
  end

  def destroy
  end
end
