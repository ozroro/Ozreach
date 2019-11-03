class Seeker::User < User
  has_one :profile, class_name: 'SeekerProfile'
end
