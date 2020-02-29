# == Schema Information
#
# Table name: recruiter_profiles
#
#  id             :bigint           not null, primary key
#  content        :text(65535)
#  corporate_name :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_recruiter_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Recruiter::Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validate :image_type

  def thumbnail
    return self.image.variant(resize: '320x100!').processed if self.image.attached?
  end

  def icon
    return self.image.variant(resize: '60x60!').processed if self.image.attached?
  end
end
