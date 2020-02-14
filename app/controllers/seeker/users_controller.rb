class Seeker::UsersController < UsersController
  include Pagy::Backend


  def create
    @seeker_user = Seeker::User.new(user_params :seeker)
    if @seeker_user.save
      create_profile(@seeker_user)
      redirect_to root_url, notice: "ユーザ「#{@seeker_user.name}」を登録しました。"
    else
      render template: "users/new", layout: "sessions"
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

  def recruiters
    @q = Recruiter::User.all.ransack(search_params)
    @recruiters = @q.result.includes(:profile, profile: :image_attachment)
    @pagy, @recruiters = pagy(@recruiters)
  end

  private
  def create_profile(user)
    user.create_profile(content: '設定されていません')
  end

  def search_params
    search_conditions = %i(
      s
      profile_corporate_name_cont
      profile_content_cont
    )
    params.fetch(:q,{}).permit(search_conditions)
  end
end
