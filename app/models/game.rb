class Game < ApplicationRecord
  validates :name, {presence: true}

  has_many :posts, dependent: :destroy
  has_one :game_images, dependent: :destroy
end
