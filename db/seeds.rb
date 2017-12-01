require 'random_data'

 # Create Wikis
 50.times do
 # #1
   Wiki.create!(
 # #2
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph,
     private: false
   )
 end
 wikis = Wiki.all


 # Create an admin user
admin = User.create!(
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

# Create a member
member = User.create!(
  email:    'member@example.com',
  password: 'helloworld',
  role:     'member'
)

premium = User.create!(
  email:    'premium@example.com',
  password: 'helloworld',
  role:     'premium'
)




 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
