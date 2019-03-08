# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name: "Alice",
  email: "a",
  password: "a",
  image_name: "default_user.jpg",
)

User.create!(
  name: "Bub",
  email: "b",
  password: "b",
  image_name: "default_user.jpg",
)

Game.create!(name: "League_of_Legends")
Game.create!(name: "APEX_Legends")
Game.create!(name: "PLAYERUNKNOWN'S_BATTLEGROUNDS")
Game.create!(name: "Fortnite")
Game.create!(name: "Hearthstone")

(1..5).each do |i|
  (1..10).each do |ii|
    Post.create!(
     title: "タイトル#{ii}",
     content: "内容#{ii}",
     game_id: i,
     user_id: 1,
   )
  end
end
