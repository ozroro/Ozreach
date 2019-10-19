class User::BaseController < ApplicationController
  private
  def user_params(type)
    type ||= :base
    params.require("user_#{type}".to_sym).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end