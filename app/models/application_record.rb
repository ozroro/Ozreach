class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private
  
  def image_type
    return unless image.attached?
    if image.blob.byte_size > 1.megabytes
      image.purge
      errors.add(:image, 'needs to be < 1 mega bytes')
    elsif !image.content_type.in?(%('image/jpeg image/png'))
      image.purge
      errors.add(:image, 'needs to be a JPEG or PNG')
    end
  end

end
