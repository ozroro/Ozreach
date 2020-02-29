class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      log_in(@user)
      session_params[:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to root_path, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private

    def session_params
      params.require(:session).permit(:email, :password, :remember_me)
    end
end
