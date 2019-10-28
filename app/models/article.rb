class Article < ApplicationRecord
  belongs_to :user, class_name: 'User::Recruiter'

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 140}
  validates :content,  presence: true

  scope :recent, -> { order(created_at: :desc) }
end
