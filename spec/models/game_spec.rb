require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'ゲーム名が有効であること' do
    game = Game.create(
      name: 'モデルテストゲーム'
    )
    expect(game).to be_valid
  end

  it 'ゲーム名がなければ無効であること' do
    game = Game.create(name: nil)
    game.valid?
    expect(game.errors[:name]).to include 'を入力してください'
  end

  it 'ゲーム名のユニーク制約が有効であること' do
    game_a = Game.create(name: 'モデルテストゲーム')
    expect(game_a).to be_valid
    game_b = Game.create(name: 'モデルテストゲーム')
    game_b.valid?
    expect(game_b.errors[:name]).to include 'はすでに存在します'
  end
end
