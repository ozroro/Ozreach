class Recruiter::Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  has_many :applicants,
            class_name: '::Seeker::Applicant',
            foreign_key: 'recruiter_article_id'

  has_many :seeker_users,
            through: :applicants,
            class_name: '::User',
            source: 'user'

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 140}
  validates :content,  presence: true
  validate :image_type

  scope :recent, -> { order(created_at: :desc) }


  def thumbnail
    return self.image.variant(resize: '300x300!').processed
  end
  
  private
  
  def image_type
    return unless image.attached?
    if image.blob.byte_size > 1.megabytes
      image.purge
      errors.add(:image, 'needs to be < 1 mega bytes')
    elsif !image.content_type.in?(%('image/jpec image/png'))
      iamge.purge
      errors.add(:image, 'needs to be a JPEG or PNG')
    end
  end

end
