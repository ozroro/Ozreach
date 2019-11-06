class Recruiter::UsersController < UsersController
  def create
    @user = Recruiter::User.new(user_params :recruiter)
    if @user.save
      create_profile(user)
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
    @user = Recruiter::User.new

  end

  def edit
  end

  def update
  end

  def destroy
  end

  def profile

  end

  def articles
    
  end

  private
  def create_profile(user)
    user.create_profile(corporate_name: '未設定', content: '設定されていません')
    
  end
  


end
