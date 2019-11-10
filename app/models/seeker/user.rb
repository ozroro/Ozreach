class Seeker::User < User
  has_one :profile, dependent: :destroy
  
  has_many :applicants, dependent: :destroy
  has_many :recruiter_articles,
            through: :applicants,
            class_name: '::Recruiter::Article'
end
