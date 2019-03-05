class Post < ApplicationRecord
  validates :title, {presence: true}
  validates :content, {presence: true}
  validates :game_id, {presence: true}
  validates :user_id, {presence: true}

end
