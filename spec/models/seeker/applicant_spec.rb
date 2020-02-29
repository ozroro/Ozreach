# == Schema Information
#
# Table name: seeker_applicants
#
#  id                   :bigint           not null, primary key
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
require 'rails_helper'

RSpec.describe Seeker::Applicant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
