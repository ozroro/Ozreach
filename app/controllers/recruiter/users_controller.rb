class Recruiter::UsersController < UsersController
  def create
    @recruiter_user = Recruiter::User.new(user_params(:recruiter))
    if @recruiter_user.save
      create_profile(@recruiter_user)
      redirect_to root_url, notice: "ユーザ「#{@recruiter_user.name}」を登録しました。"
    else
      render template: 'users/new', layout: 'sessions'
    end
  end

  def home
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def profile
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def articles
    @user = User.find(params[:id])
    if @user.recruiter?
      @articles = @user.articles
    else
      redirect_to root_url
    end
  end

  private

    def create_profile(user)
      user.create_profile(corporate_name: '未設定', content: '設定されていません')
    end
end
