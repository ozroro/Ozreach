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
