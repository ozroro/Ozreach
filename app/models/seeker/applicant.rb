# == Schema Information
#
# Table name: seeker_applicants
#
#  id                   :bigint           not null, primary key
#  status               :integer          default("0"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  recruiter_article_id :bigint
#  user_id              :bigint
#
# Indexes
#
#  index_seeker_applicants_on_recruiter_article_id  (recruiter_article_id)
#  index_seeker_applicants_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (recruiter_article_id => recruiter_articles.id)
#  fk_rails_...  (user_id => users.id)
#

# HACK: seekerのnamespceに置く必要ないし、拡張するときに複雑になるのでrootに移行させたい
class Seeker::Applicant < ApplicationRecord
  extend Enumerize
  extend ActiveModel::Naming
  belongs_to :user
  belongs_to :recruiter_article, class_name: '::Recruiter::Article'

  validates :user_id, uniqueness: { scope: :recruiter_article_id, message: 'すでに応募しています' }

  scope :recent, -> { order(created_at: :desc) }
  enumerize :status, in: { applied: 0, review: 1, done: 2 }

  def corporate_name
    self.recruiter_article.user.profile.corporate_name
  end

  def recruiter
    self.recruiter_article.user
  end

  def title
    self.recruiter_article.title
  end
end
