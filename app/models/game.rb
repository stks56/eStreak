class Game < ApplicationRecord
  validates :name, {presence: true}

  has_many :posts
  has_one :game_image, dependent: :destroy
  accepts_nested_attributes_for :game_image, allow_destroy: true
end
