# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  description :string(255)
#  link_option :string(255)
#  link_type   :string(255)
#  read_flag   :boolean          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user

  validate :limit_notifications_size
  MAX_SIZE = 100

  scope :recent, -> { order(created_at: :desc) }
  scope :unread, -> { where(read_flag: false) }

  # TODO: このサイズ制限を確認するテストを作成する
  def limit_notifications_size
    notifications = user.notifications
    if notifications.size > MAX_SIZE
      notifications.first.destroy
    end
  end

  def path
    # links = {
    #   'my_profile'            => profile_path,
    #   'article'               => article_path(link_option),
    #   'recruiter_applicants'  => recruiter_applicants_path,
    #   'recruiter_applicant'   => recruiter_applicant_path(link_option),
    #   'seeker_applicants'     => seeker_applicants_path
    # }
    case link_type
    # 共通パス
    when 'my_profile'
      profile_path
    when 'article'
      article_path(link_option)

    # リクルーターパス
    when 'recruiter_applicants'
      recruiter_applicants_path
    when 'recruiter_applicant'
      recruiter_applicant_path(link_option)

    # シーカーパス
    when seeker_applicants
      seeker_applicants_path
    # TODO: seeker_applicant 個別のページを作ったら対応する

    else
      raise "Unknown Notification#link_type : (#{link_type})"
    end
  end
end
