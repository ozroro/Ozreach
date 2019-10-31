FactoryBot.define do
  factory :user_seeker_profile, class: 'User::SeekerProfile' do
    user { nil }
    content { "MyText" }
  end
end
