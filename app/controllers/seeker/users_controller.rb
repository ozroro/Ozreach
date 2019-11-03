class Seeker::UsersController < UserController
  def create
    @user = Seeker::User.new(user_params :seeker)
    if @user.save
      create_profile(@user)
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
    @user = User::Seeker.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def create_profile(user)
    user.create_profile(content: '設定されていません')
end
