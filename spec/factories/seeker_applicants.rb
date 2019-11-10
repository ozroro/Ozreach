FactoryBot.define do
  factory :seeker_applicant, class: 'Seeker::Applicant' do
    user { nil }
    recruiter_article { nil }
  end
end
