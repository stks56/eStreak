class Game < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :posts
  has_one :game_image, dependent: :destroy
  accepts_nested_attributes_for :game_image, allow_destroy: true
end
