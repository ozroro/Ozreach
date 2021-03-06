# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)      not null
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  remember_digest :string(255)
#  type            :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@test.com" }
    password { 'password' }
  end

  factory :recruiter, parent: :user, class: Recruiter::User do
    sequence(:name) {|n| "リクルーター#{n}" }
    after(:build) do |recruiter|
      recruiter.profile ||= FactoryBot.create(:recruiter_profile, user: recruiter)
    end
  end

  factory :recruiter_profile, class: 'Recruiter::Profile' do
    association :user, factory: :recruiter
    corporate_name { 'MyString' }
    content { 'MyText' }
  end

  factory :seeker, parent: :user, class: Seeker::User do
    sequence(:name) {|n| "シーカー#{n}" }
    after(:build) do |seeker|
      seeker.profile ||= FactoryBot.create(:seeker_profile, user: seeker)
    end
  end

  factory :seeker_profile, class: 'Seeker::Profile' do
    association :user, factory: :seeker
    content { 'MyText' }
  end
end
