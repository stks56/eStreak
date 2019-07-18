module Types
  class GameType < Types::BaseObject
    description 'A game data'
    field :id, ID, null: false
    field :name, String, null: false
    field :game_image, Types::GameImageType, null: true
    field :posts, [Types::PostType], null: true
  end
end
