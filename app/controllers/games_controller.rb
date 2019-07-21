class GamesController < ApplicationController
  def index
    @games = Game.all.includes(:game_image).limit(20)
  end

  def show
    @game = Game.find_by(name: params[:game_name])
    @posts = Post.where(game_id: @game.id)
                 .page(params[:page])
                 .per(10)
                 .order('created_at desc')
                 .includes(:user, :game)
    @posts_rank = Post.where(game_id: @game.id).order('likes_count desc').limit(3)
    @twitch_streams = TwitchApi.get_streams_with_cache(@game.name, 8)
  end
end
