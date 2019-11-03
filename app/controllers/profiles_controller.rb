#ログインしている自分のプロファイルの表示、編集
class ProfilesController < ApplicationController
  def show
    @user = current_user
    @profile = current_user.profile
  end

  def edit

  end

  def update

  end


  def seeker_profile
  end

  def recruiter_profile

  end

  private 
  def set_user
    id = params[recruiter_id] || params[seeker_id] 
    User.find(id)
  end
end
