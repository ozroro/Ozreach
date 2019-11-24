class HomeController < ApplicationController
  before_action :login_required
  def home_selector
    user = current_user

    if user.recruiter?
      @articles = user.articles
      render :recruiter_home
    elsif user.seeker?
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
