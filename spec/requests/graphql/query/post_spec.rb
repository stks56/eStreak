require 'rails_helper'

RSpec.describe 'post_query', type: :request do
  subject { post graphql_path, params: { query: query } }
  let!(:user_a) { FactoryBot.create(:user, name: 'userA', email: 'user_a@example.com') }
  let!(:user_b) { FactoryBot.create(:user, name: 'userB', email: 'user_b@example.com') }
  let!(:game_a) { FactoryBot.create(:game) }
  let!(:post_a) { FactoryBot.create(:post, title: 'post_aのタイトル', content: 'post_aの内容', game: game_a, user: user_a) }
  let!(:post_b) { FactoryBot.create(:post, title: 'post_bのタイトル', content: 'post_bの内容', game: game_a, user: user_a) }

  describe 'find post by id' do
    let(:query) do
      <<~QUERY
        {
          post(id: #{post_a.id}) {
            id
            title
            content
            createdAt
            user {
              id
              name
            }
            game {
              id
              name
            }
          }
        }
      QUERY
    end

    it 'response body is Post data' do
      subject
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:post][:id].to_i).to eq post_a.id
      expect(json[:data][:post][:title]).to eq post_a.title
      expect(json[:data][:post][:content]).to eq post_a.content
      created_at = Time.zone.parse(json[:data][:post][:createdAt])
      expect(created_at).to eq game_a.created_at
      expect(json[:data][:post][:user][:id].to_i).to eq user_a.id
      expect(json[:data][:post][:user][:name]).to eq user_a.name
      expect(json[:data][:post][:game][:id].to_i).to eq game_a.id
      expect(json[:data][:post][:game][:name]).to eq game_a.name
    end
  end

  describe 'find all posts' do
    let(:query) do
      <<~QUERY
        {
          posts {
            id
            title
            content
          }
        }
      QUERY
    end

    it 'response body is Posts data' do
      subject
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:posts][0][:id].to_i).to eq post_a.id
      expect(json[:data][:posts][0][:title]).to eq post_a.title
      expect(json[:data][:posts][0][:content]).to eq post_a.content
      expect(json[:data][:posts][1][:id].to_i).to eq post_b.id
      expect(json[:data][:posts][1][:title]).to eq post_b.title
      expect(json[:data][:posts][1][:content]).to eq post_b.content
    end
  end
end
