require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #index' do
    before do
      FactoryBot.create(:post)
    end

    it 'リクエストが成功する' do
      get posts_path
      expect(response.status).to eq 200
    end

    it '記事のタイトルが表示されていること' do
      get posts_path
      expect(response.body).to include 'テストタイトル'
    end
  end

  describe 'GET #show' do
    let(:post) { FactoryBot.create(:post) }

    it 'リクエストが成功すること' do
      get post_url post.id
      expect(response.status).to eq 200
    end

    it '記事の本文が表示されていること' do
      get post_url post.id
      expect(response.body).to include 'テストコンテンツ'
    end
  end
end
