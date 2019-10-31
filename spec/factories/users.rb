FactoryBot.define do

  factory :user_base, class: User::Base do
    sequence(:email) { |n| "user#{n}@test.com" }
    password { 'password' }
  end

  factory :recruiter, parent: :user_base, class: User::Recruiter do
    sequence(:name) { |n| "リクルーター#{n}" } 
  end

  factory :seeker, parent: :user_base, class: User::Seeker do
    sequence(:name) { |n| "シーカー#{n}" }
  end


end