class Recruiter::UsersController < UsersController
  include Pagy::Backend
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
    if (@user = Recruiter::User.find_by(id: params[:id]))
      @profile = @user.profile
    else
      flash[:error] = 'ユーザーが存在しないか、削除されました。'
      redirect_to root_path
    end
  end

  def articles
    if (@user = Recruiter::User.find_by(id: params[:id]))
      @q = @user.articles.ransack(search_params)
      @articles = @q.result.includes(image_attachment: :blob).recent
      @pagy, @articles = pagy(@articles)
    else
      flash[:error] = 'ユーザーが存在しないか、削除されました。'
      redirect_to root_path
    end
  end

  private

    def search_params
      search_conditions = %i[
        all_atr_cont_terms
        corporate_cont_terms title_cont_terms content_cont_terms
        created_at_gteq created_at_lteq_end_of_day
      ]
      params.fetch(:q, {}).permit(search_conditions)
    end

    def create_profile(user)
      user.create_profile(corporate_name: '未設定', content: '設定されていません')
    end
end
