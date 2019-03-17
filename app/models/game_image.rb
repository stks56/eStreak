class GameImage < ApplicationRecord
  belongs_to :game

  mount_uploader :icon_image, ImageUploader
  mount_uploader :background_image, ImageUploader
end
