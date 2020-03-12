# == Schema Information
#
# Table name: seeker_applicants
#
#  id                   :bigint           not null, primary key
#  status               :integer          default("0"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  recruiter_article_id :bigint
#  user_id              :bigint
#
# Indexes
#
#  index_seeker_applicants_on_recruiter_article_id  (recruiter_article_id)
#  index_seeker_applicants_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (recruiter_article_id => recruiter_articles.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :seeker_applicant, class: 'Seeker::Applicant' do
    user { nil }
    recruiter_article { nil }
  end
end
