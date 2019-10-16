class User::Recruiter < User::Base
  has_many :articles, foreign_key: 'user_id'
end
