class Seeker::Applicant < ApplicationRecord
  belongs_to :user
  belongs_to :recruiter_article, class_name: '::Recruiter::Article'
end
