class Post < ApplicationRecord
  validates :title, {presence: true}
  validates :content, {presence: true}
  validates :game_id, {presence: true}
  validates :user_id, {presence: true}

  belongs_to :user
  belongs_to :game

  has_many :likes
  has_many :users, through: :likes
end
