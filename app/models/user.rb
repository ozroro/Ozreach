
# STIでReruiter::UserとSeeker::Userがそれぞれ継承する
# type には　Recruiter::User と　Seeker::Userがクラスに応じて入力される
# sessionではユーザーの種類をほとんど区別せずに扱う
# view等ではユーザー種類を区別するので　recruiter? seeker?のメソッドで判別できるようにする

class User < ApplicationRecord

  before_save :downcase_email

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}


  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  

  def recruiter?
    self.type == 'Recruiter::User'
  end

  def seeker?
    self.type == 'Seeker::User'
  end

  
  private


  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email.downcase!
  end
end
