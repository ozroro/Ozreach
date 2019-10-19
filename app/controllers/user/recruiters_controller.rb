class User::RecruitersController < User::BaseController
  def create
    @user = User::Recruiter.new(user_params :recruiter)
    if @user.save
      redirect_to root_url, notice: "ユーザ「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def home

  end

  def show
  end

  def new
    @user = User::Recruiter.new

  end

  def edit
  end

  def update
  end

  def destroy
  end



end
