
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

some_password = Faker::Internet.password

User.create!(email: Faker::Internet.email, password: some_password, password_confirmation: some_password)
users = User.all



 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
 puts "#{User.count} users created"
