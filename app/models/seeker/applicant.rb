class Seeker::Applicant < ApplicationRecord
  belongs_to :user
  belongs_to :recruiter_article, class_name: '::Recruiter::Article'

  validates :user_id, uniqueness: { scope: :recruiter_article_id, message: "すでに応募しています" }

  def corporate_name
    return self.recruiter_article.user.profile.corporate_name
  end

  def title
    return self.recruiter_article.title
  end
end
