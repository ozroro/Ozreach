FactoryBot.define do
  factory :seeker_profile, class: 'Seeker::Profile' do
    user { nil }
    content { 'MyText' }
  end
end
