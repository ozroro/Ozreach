# ログインしていないユーザー用のページ
class StaticPagesController < ApplicationController
  before_action :logout_required
  def top
  end

  def help
  end

  def about
  end

  def contact
  end
end
