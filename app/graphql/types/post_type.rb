module Types
  class PostType < Types::BaseObject
    description 'A post data'
    field :id, ID, null: false
    field :title, String, null: false
    field :content, String, null: false
    field :user, Types::UserType, null: false
    field :game, Types::GameType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
