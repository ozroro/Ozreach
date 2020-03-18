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
require 'rails_helper'

RSpec.describe Notification, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
