class Seeker::ApplicantsController < ApplicationController
  before_action :login_required
  before_action :only_seeker

  def index
    @applicants = current_user.applicants
  end


  def create
    @applicant = current_user.applicants.build(recruiter_article_id: params[:article_id])

    if (@applicant.user == current_user) && @applicant.save
      # ToDo: 
      flash[:notice] = "応募しました。"
      redirect_to seeker_applicants_path
    else
      # ToDo: エラー表示
      redirect_to root_path
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

  

end
