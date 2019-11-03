FactoryBot.define do
  factory :recruiter_profile, class: 'Recruiter::Profile' do
    user { nil }
    corporate_name { "MyString" }
    content { "MyText" }
  end
end
