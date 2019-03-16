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
  image: File.open("./db/data/user/image/default.jpg"),
)

User.create!(
  name: "Bub",
  email: "b",
  password: "b",
  image: File.open("./db/data/user/image/default.jpg"),
)

Game.create!(name: "League of Legends")
GameImage.create!(game_id: 1, icon_image: File.open("./db/data/game_image/icon_image/1.jpg"), background_image: File.open("./db/data/game_image/background_image/1.jpg") )
Game.create!(name: "APEX Legends")
GameImage.create!(game_id: 2, icon_image: File.open("./db/data/game_image/icon_image/2.jpg"), background_image: File.open("./db/data/game_image/background_image/2.jpg") )
Game.create!(name: "PLAYERUNKNOWN'S BATTLEGROUNDS")
GameImage.create!(game_id: 3, icon_image: File.open("./db/data/game_image/icon_image/3.jpg"), background_image: File.open("./db/data/game_image/background_image/3.jpg") )
Game.create!(name: "Fortnite")
GameImage.create!(game_id: 4, icon_image: File.open("./db/data/game_image/icon_image/4.jpg"), background_image: File.open("./db/data/game_image/background_image/4.jpg") )
Game.create!(name: "Hearthstone")
GameImage.create!(game_id: 5, icon_image: File.open("./db/data/game_image/icon_image/5.jpg"), background_image: File.open("./db/data/game_image/background_image/5.jpg") )

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

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
