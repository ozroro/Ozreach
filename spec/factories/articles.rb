FactoryBot.define do
  factory :article, class: 'Recruiter::Article' do
    sequence(:title) {|n| "記事タイトル#{n}" }
    content {}
  end
end
