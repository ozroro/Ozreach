module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    if (user_id = session[:user_id])
      # User::Baseでfindしてもオブジェクトはtypeで判別されたオブジェクトが返るので大丈夫
      @current_user ||= User::Base.find_by(id: user_id)
    end
  end

  def logged_in?
    !current_user.nil?
  end


  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end



end
