class HomeController < ApplicationController
  before_action :login_required
  def home_selector
    user = current_user

    if user.recruiter?
      @articles = user.articles.recent.first(10)
      @applicants = user.applicants.includes(:user, :recruiter_article).recent.first(10)
      render :recruiter_home
    elsif user.seeker?
      @articles = Recruiter::Article.includes(user: :profile).recent.first(10)
      @applicants = user.applicants.includes(recruiter_article: { user: :profile }).recent.first(5)

      render :seeker_home
    else
      raise "Unknown User.type:(#{user.type})"
    end
  end

  def recruiter_home
  end

  def seeker_home
  end
end
