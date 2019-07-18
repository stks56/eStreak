module Types
  class QueryType < Types::BaseObject
    field :post, PostType, null: true do
      description 'Find a post by id'
      argument :id, ID, required: true
    end
    def post(id:)
      Post.find_by(id: id)
    end

    field :posts, [Types::PostType], null: true, description: 'Find all posts'
    def posts
      Post.all
    end

    field :user, UserType, null: true do
      description 'Find a user by id'
      argument :id, ID, required: true
    end
    def user(id:)
      User.find_by(id: id)
    end

    field :users, [Types::UserType], null: true, description: 'Find all users'
    def users
      User.all
    end

    field :game, GameType, null: true do
      description 'Find a game by id or name'
      argument :id, ID, required: false
      argument :name, String, required: false
    end
    def game(*arg)
      Game.find_by(*arg)
    end

    field :games, [Types::GameType], null: true, description: 'Find all games'
    def games
      Game.all
    end
  end
end
