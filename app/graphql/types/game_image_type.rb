module Types
  class GameImageType < Types::BaseObject
    description 'A game image data'
    field :icon_image, String, null: true
    field :background_image, String, null: true
  end
end
