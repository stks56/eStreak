class GamesController < ApplicationController
  def index
    @games = Game.all.limit(20)
  end

  def show
  end
end
