class Recruiter::User < User
  has_many :articles, dependent: :destroy
  has_one :profile, dependent: :destroy
end
