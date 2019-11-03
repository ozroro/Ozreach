FactoryBot.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    password { 'password' }
  end

  factory :recruiter, parent: :user, class: Recruiter::User do
    sequence(:name) { |n| "リクルーター#{n}" } 
  end

  factory :seeker, parent: :user, class: Seeker::User do
    sequence(:name) { |n| "シーカー#{n}" }
  end


end