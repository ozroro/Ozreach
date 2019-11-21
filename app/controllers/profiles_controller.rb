#ログインしている自分のプロファイルの表示、編集
class ProfilesController < ApplicationController
 before_action :profile_is_present
  def show
    @user = current_user
    @profile = @user.profile
  end

  def edit
    @user = current_user
    @profile = @user.profile
  end

  def update
    @user = current_user
    @profile = @user.profile

    if @profile.update(profile_params)
      redirect_to profile_path
    else
      render :edit
    end
    


  end


  def seeker_profile
  end

  def recruiter_profile

  end

  private 
  def profile_is_present
    if current_user.profile.nil?
      current_user.create_profile(default_profile)
    end
  end

  def default_profile
    return {corporate_name: 'not set', content: 'not set'} if current_user.recruiter? 
    return {content: 'not set'} if current_user.seeker?
  end

  def profile_params
    user = current_user
    return params.require(:recruiter_profile).permit(:corporate_name, :content, :image) if user.recruiter?
    return params.require(:seeker_profile).permit(:content, :image) if user.seeker?
  end
end
