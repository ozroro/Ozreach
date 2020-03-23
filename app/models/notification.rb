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

  MAX_SIZE = 100

  scope :recent, -> { order(created_at: :desc) }
  scope :unread, -> { where(read_flag: false).order(created_at: :desc) }

  validates :link_type, inclusion: { in: %w[my_profile article recruiter_applicants recruiter_applicant seeker_applicants] }

  # notification > MAXSIZEの場合一番古いものを削除
  after_commit :destroy_oldest_notification, if: :reached_limit?

  def path
    case link_type
    when 'my_profile'           then profile_path
    when 'article'              then article_path(link_option)
    when 'recruiter_applicants' then recruiter_applicants_path
    when 'recruiter_applicant'  then recruiter_applicant_path(link_option)
    when 'seeker_applicants'    then seeker_applicants_path
    # TODO: seeker_applicant 個別のページを作ったら対応する
    else
      raise "Unknown Notification#link_type : (#{link_type})"
    end
  end

  private

    def reached_limit?
      self.user.notifications.size > MAX_SIZE
    end

    def destroy_oldest_notification
      num = self.user.notifications.size - MAX_SIZE
      oldest_notifications = self.user.notifications.order(:created_at).first(num)
      oldest_notifications.each(&:destroy)
    end
end
