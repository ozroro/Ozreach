# == Schema Information
#
# Table name: recruiter_articles
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_recruiter_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Recruiter::Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  ransack_alias :corporate, :user_profile_corporate_name
  ransack_alias :all_atr, :title_or_content_or_user_profile_corporate_name

  has_many :applicants,
           class_name: '::Seeker::Applicant',
           foreign_key: 'recruiter_article_id',
           dependent: :destroy

  has_many :seeker_users,
           through: :applicants,
           class_name: '::User',
           source: 'user'

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true
  validate :image_type

  scope :recent, -> { order(created_at: :desc) }

  def thumbnail
    self.image.variant(resize: '300x300!').processed
  end
end
