class HomeController < ApplicationController
  def top_selector
    if (user = current_user)
      if user.recruiter?
        render :recruiter_top
      elsif user.seeker?
        render :seeker_top
      else
        raise "Unknown User.type:(#{user.type})"
      end
    else
      render :guest_top, layout: false
    end
    
  end

  def recruiter_top
  end

  def seeker_top
  end

  def guest_top
    layout false
  end
end
