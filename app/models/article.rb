class Article < ApplicationRecord
  belongs_to :user, class_name: 'User::Recruiter'
end
