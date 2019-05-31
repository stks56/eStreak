require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@exmple.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@exmple.com') }
  let(:game_a) { FactoryBot.create(:game, name: 'ゲームA') }

  describe 'FactoryBotが有効であること' do
    it 'user_aが有効であること' do
      expect(user_a).to be_valid
    end

    it 'user_bが有効であること' do
      expect(user_b).to be_valid
    end

    it 'game_aが有効であること' do
      expect(game_a).to be_valid
    end
  end

  describe 'Postモデルが有効であること' do
    it '記事のタイトル、本文、user_id、game_idが有効であること' do
      user = user_a
      post = user.posts.create(
        title: 'テストタイトル',
        content: 'テスト本文',
        game_id: game_a.id
      )
      expect(post).to be_valid
    end

    it '記事のタイトルがなければ無効であること' do
      post = Post.create(title: nil)
      post.valid?
      expect(post.errors[:title]).to include 'を入力してください'
    end

    it '記事の本文がなければ無効であること' do
      post = Post.create(content: nil)
      post.valid?
      expect(post.errors[:title]).to include 'を入力してください'
    end

    it '記事のuser_idがなければ無効であること' do
      post = Post.create(user_id: nil)
      post.valid?
      expect(post.errors[:title]).to include 'を入力してください'
    end

    it '記事のgame_idがなければ無効であること' do
      post = Post.create(game_id: nil)
      post.valid?
      expect(post.errors[:title]).to include 'を入力してください'
    end
  end
end
