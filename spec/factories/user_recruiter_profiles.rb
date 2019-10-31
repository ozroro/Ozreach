FactoryBot.define do
  factory :user_recruiter_profile, class: 'User::RecruiterProfile' do
    user { nil }
    corporate_name { "MyString" }
    content { "MyText" }
  end
end
