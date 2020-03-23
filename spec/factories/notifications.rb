# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  description :string(255)
#  link_option :string(255)
#  link_type   :string(255)
#  read_flag   :boolean          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :notification do
    user
    read_flag { false }
    link_type { 'my_profile' }
    link_option { '' }
    sequence(:description) {|n| "Notification No:#{n}" }
  end
end
