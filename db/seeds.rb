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

 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
