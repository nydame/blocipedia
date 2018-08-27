# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'random_data'

# Create users at standard level
5.times do |index|
  User.create!(
    username: Faker::DragonBall.character,
    email: "user-#{index}@bloc.com",
    password: RandomData.random_password,
  )
end

# Create 1 admin user with known properties
User.create!(
  username: "adminuser",
  email: "admin1@bloc.com",
  password: "adminOne!",
  role: :admin
)

# Create 1 premium user with known properties
User.create!(
  username: "premiumuser",
  email: "premium1@bloc.com",
  password: "premiumOne!",
  role: :premium
)

User.find_each do |user|
  user.confirm
end

users = User.all

# Create wikis
10.times do
  Wiki.create!(
    title: Faker::Myst.game,
    body: Faker::HitchhikersGuideToTheGalaxy.quote + " " + Faker::Seinfeld.quote + " " + Faker::Simpsons.quote,
    private: [true, false, false].sample, #skew in favor of public wikis
    user: users.sample
  )
end

puts "Seeding finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
