class Recruiter::User < User
  has_many :articles, dependent: :destroy
  has_many :applicants, through: :articles

  has_one :profile, dependent: :destroy
end
