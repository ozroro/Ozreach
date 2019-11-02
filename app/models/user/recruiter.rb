class User::Recruiter < User::Base
  has_many :articles, foreign_key: 'user_id', inverse_of: 'user', dependent: :destroy
  has_one :profile, class_name: 'RecruiterProfile'
end
