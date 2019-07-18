module Types
  class UserType < Types::BaseObject
    description 'A user data'
    field :id, ID, null: false
    field :name, String, null: false
    field :image, String, null: false
    field :posts, [Types::PostType], null: true
  end
end
