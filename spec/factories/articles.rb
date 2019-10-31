FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "記事タイトル#{n}" } 
    content {}
  end
end
