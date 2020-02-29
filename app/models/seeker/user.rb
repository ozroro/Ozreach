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
class Seeker::User < User
  has_one :profile, dependent: :destroy

  has_many :applicants, dependent: :destroy
  has_many :recruiter_articles,
           through: :applicants,
           class_name: '::Recruiter::Article'
end
