class Game < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :posts, dependent: :destroy
  has_one :game_image, dependent: :destroy
  accepts_nested_attributes_for :game_image, allow_destroy: true

  delegate :icon_image, to: :game_image
  delegate :background_image, to: :game_image
end
