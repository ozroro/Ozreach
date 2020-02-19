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
