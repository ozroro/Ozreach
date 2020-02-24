FactoryBot.define do
  factory :article, class: 'Recruiter::Article' do
    sequence(:title) {|n| "記事タイトル#{n}" }
    content { '記事内容' }
    association :user, factory: :recruiter
  end
end
