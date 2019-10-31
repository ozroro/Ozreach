class User::Seeker < User::Base
  has_one :profile, class_name: 'SeekerProfile'
end
