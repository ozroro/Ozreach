class UsersController < ApplicationController
  private
  def user_params(type=:seeker)
    params.require("#{type}_user".to_sym).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end