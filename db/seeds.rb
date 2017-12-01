# require 'random_data'
require 'faker'
 # Create Wikis
 50.times do
 # #1
   Wiki.create!(
 # #2
     title:  Faker::HowIMetYourMother.quote,
     body:   Faker::TheFreshPrinceOfBelAir.quote,
     private: false
   )
 end
 wikis = Wiki.all


 # Create an admin user
admin = User.create!(
  email:    Faker::Internet.email,
  password: Faker::Internet.password,
  role:     'admin'
)

# Create a member
member = User.create!(
  email:    Faker::Internet.email,
  password: Faker::Internet.password,
  role:     'member'
)

premium = User.create!(
  email:    Faker::Internet.email,
  password: Faker::Internet.password,
  role:     'premium'
)

users = User.all



 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
 puts "#{User.count} users created"
