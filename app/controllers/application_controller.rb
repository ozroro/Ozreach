class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def login_required
      unless logged_in?
        flash[:danger] = 'Please log in'
        redirect_to login_url
      end
    end

    def logout_required
      if logged_in?
        redirect_to home_path
      end
    end

    def only_recruiter
      redirect_to root_url unless current_user.recruiter?
    end

    def only_seeker
      redirect_to root_url unless current_user.seeker?
    end

  # docker comment test
end
