# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
RECORD = 50
SAMPLE = 3

# t = Time.current
# サンプルデータを作成するクラス
class RecruiterSampleData
  @number = 0
  attr_reader :profile, :articles, :name, :full_name
  def initialize(corporation_name)
    @full_name = corporation_name
    @name = corporation_name.gsub(/株式会社|有限会社|合名会社|合資会社|合同会社/, '')
    file = File.expand_path("sample/#{self.class.loop_number}.yml", __dir__)
    doc = YAML.load(File.read(file), symbolize_names: true)
    @profile = doc[:profile].gsub('[corp_name]', @name)
    # articleの型
    # [{hash}, {hash}・・・・]
    # {hash} = {title:'foo', content: 'buzz'}
    @articles = doc[:article].map do |hash|
      hash.map {|key, val| [key, val.gsub('[corp_name]', @name)] }.to_h
    end
  end

  def self.loop_number
    @number = (@number % SAMPLE) + 1
  end
end

# Recruiterサンプルデータの登録　それぞれランダムな会社名とサンプルから記事を３つ作成する
RECORD.times do |n|
  data = RecruiterSampleData.new(Faker::Company.name)
  recruiter = Recruiter::User.create!(name: data.name, email: "recruiter#{n}@test.com", password: 'password', password_confirmation: 'password')
  recruiter.create_profile!(corporate_name: data.full_name, content: data.profile)
  article1 = recruiter.articles.create!(title: data.articles[0][:title], content: data.articles[0][:content])
  article2 = recruiter.articles.create!(title: data.articles[1][:title], content: data.articles[1][:content])
  article3 = recruiter.articles.create!(title: data.articles[2][:title], content: data.articles[2][:content])

  article1.image.attach(io: File.open('public/300x300.png'), filename: '300x300.png')
  article2.update!(created_at: 1.days.ago)
  article3.update!(created_at: 3.days.ago)
end
# Seekerサンプルデータの登録　ランダムに募集する
RECORD.times do |n|
  seeker = Seeker::User.create!(name: Faker::Name.name, email: "seeker#{n}@test.com", password: 'password', password_confirmation: 'password')
  seeker.create_profile!(content: 'Seeker Profile')
  (1..Recruiter::Article.count).to_a.sample(30).each {|article_id| seeker.applicants.create!(recruiter_article_id: article_id) }
end
