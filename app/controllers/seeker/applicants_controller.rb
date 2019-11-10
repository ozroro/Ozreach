class Seeker::ApplicantsController < ApplicationController
  before_action :login_required
  before_action :only_seeker

  def index
    @applicants = current_user.applicants
  end

  def new
    @applicant = Seeker::Applicant.build(applicant_params)
  end

  def create
    @applicant = Seeker::Applicant.build(applicant_params)

    if (@applicant.user == current_user) && @applicant.save
      # ToDo: 
      flash[:notice] = "応募しました。"
      render :index
    else
      # ToDo: エラー表示
      render :index
    end

  end


  def destroy
    @applicant = Seeker::Applicant.find(params[:id])
    if @applicant.user == current_user && @applicant.destroy
      # ToDo: 
      flash[:notice] = "応募を取り消しました"
      render :index
    else
      # ToDo: エラー表示
      render :index
    end
  end

  private
  
    def applicant_params
      params.require(:applicant).permit(:user, :recruiter_article_id)
    end
end
