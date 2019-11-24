# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

t = Time.current

50.times do |n| 
  recruiter = Recruiter::User.create!(name: Faker::Name.first_name, email: "recruiter#{n}@test.com", password: 'password', password_confirmation: 'password')
  recruiter.create_profile!(corporate_name: Faker::Company.name, content: Faker::Lorem.paragraph)
  article1 = recruiter.articles.create!(title: Faker::Company.catch_phrase, content: Faker::Lorem.paragraph)
  article2 = recruiter.articles.create!(title: Faker::Company.catch_phrase, content: Faker::Lorem.paragraph)
  article3 = recruiter.articles.create!(title: Faker::Company.catch_phrase, content: Faker::Lorem.paragraph)

  article1.image.attach(io: File.open('public/300x300.png'), filename: '300x300.png')
  article2.update!(created_at: 1.days.ago)
  article3.update!(created_at: 3.days.ago)


  seeker = Seeker::User.create!(name: Faker::Name.first_name, email: "seeker#{n}@test.com", password: 'password', password_confirmation: 'password')
  seeker.create_profile!(content: Faker::Lorem.paragraph)
  seeker.applicants.create!(recruiter_article_id: article1.id )

end