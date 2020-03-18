# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)      not null
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  remember_digest :string(255)
#  type            :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :downcase_email

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_many :notifications, dependent: :destroy

  def recruiter?
    self.type == 'Recruiter::User'
  end

  def seeker?
    self.type == 'Seeker::User'
  end

  def type_text
    return 'recruiter' if self.recruiter?
    return 'seeker' if self.seeker?
  end

  def unsubscribed_seeker?(article)
    seeker? && !self.recruiter_articles.exists?(article&.id)
  end

  def remember
    @remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(@remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  private

    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email.downcase!
    end
end
