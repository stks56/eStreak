require 'rails_helper'

RSpec.describe 'user_query', type: :request do
  subject { post graphql_path, params: { query: query } }
  let!(:user_a) { FactoryBot.create(:user, name: 'userA', email: 'user_a@example.com') }
  let!(:user_b) { FactoryBot.create(:user, name: 'userB', email: 'user_b@example.com') }
  let!(:game_a) { FactoryBot.create(:game) }
  let!(:post_a) { FactoryBot.create(:post, title: 'post_aのタイトル', content: 'post_aの内容', game: game_a, user: user_a) }
  let!(:post_b) { FactoryBot.create(:post, title: 'post_bのタイトル', content: 'post_bの内容', game: game_a, user: user_a) }

  describe 'find user by id' do
    let(:query) do
      <<~QUERY
        {
          user(id: #{user_a.id}) {
            id
            name
            image
            posts {
              title
              content
            }
          }
        }
      QUERY
    end

    it 'response body is User data' do
      subject
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:user][:id].to_i).to eq user_a.id
      expect(json[:data][:user][:name]).to eq user_a.name
      expect(json[:data][:user][:image]).to eq '/images/users/default_user.png'
      expect(json[:data][:user][:posts][0][:title]).to eq post_a.title
      expect(json[:data][:user][:posts][0][:content]).to eq post_a.content
      expect(json[:data][:user][:posts][1][:title]).to eq post_b.title
      expect(json[:data][:user][:posts][1][:content]).to eq post_b.content
    end
  end

  describe 'find all users' do
    let(:query) do
      <<~QUERY
        {
          users {
            id
            name
          }
        }
      QUERY
    end

    it 'response body is all users data' do
      subject
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:users][0][:id].to_i).to eq user_a.id
      expect(json[:data][:users][0][:name]).to eq user_a.name
      expect(json[:data][:users][1][:id].to_i).to eq user_b.id
      expect(json[:data][:users][1][:name]).to eq user_b.name
    end
  end
end
