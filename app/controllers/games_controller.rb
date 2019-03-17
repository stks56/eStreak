class GamesController < ApplicationController
  def index
    @games = Game.all.limit(20)
  end

  def show
    @game = Game.find_by(name: params[:game_name])
    @posts = Post.where(game_id: @game.id).page(params[:page]).per(10)
  end
end
