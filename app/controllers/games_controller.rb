class GamesController < ApplicationController
  def index
    @games = Game.all.includes(:game_image).limit(20)
  end

  def show
    @game = Game .find_by(name: params[:game_name])

    @posts = Post.where(game_id: @game.id)
                 .page(params[:page])
                 .per(10)
                 .order('created_at desc')
                 .includes(:user, :game)

    like_ranks = Like.where(game_id: @game.id)
                     .group(:post_id)
                     .order(Arel.sql('count(post_id) desc'))
                     .limit(5)
                     .pluck(:post_id)
    @posts_rank = Post.find(like_ranks)

    @twitch_streams = TwitchApi.get_streams_with_cache(@game.name, 8)
  end
end
