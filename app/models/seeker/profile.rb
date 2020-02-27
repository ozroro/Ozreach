# == Schema Information
#
# Table name: seeker_profiles
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_seeker_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Seeker::Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :image
  validate :image_type

  def thumbnail
    self.image.variant(resize: '320x100!').processed
  end

  def icon
    self.image.variant(resize: '60x60!').processed
  end
end
