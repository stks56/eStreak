require 'rails_helper'

RSpec.describe 'game_query', type: :request do
  subject { post graphql_path, params: { query: query } }
  let!(:game_a) { FactoryBot.create(:game, name: 'gameA') }
  let!(:game_b) { FactoryBot.create(:game, name: 'gameB') }

  describe 'find game by id' do
    let(:query) do
      <<~QUERY
        {
          game(id: #{game_a.id}) {
            id
            name
          }
        }
      QUERY
    end

    it 'response body is Game data' do
      subject
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:game][:id].to_i).to eq game_a.id
      expect(json[:data][:game][:name]).to eq game_a.name
    end
  end

  describe 'find game by name' do
    let(:query) do
      <<~QUERY
        {
          game(name: #{game_a.name}) {
            id
            name
          }
        }
      QUERY
    end

    it 'response body is Game data' do
      subject
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:game][:id].to_i).to eq game_a.id
      expect(json[:data][:game][:name]).to eq game_a.name
    end
  end

  describe 'find all games' do
    let(:query) do
      <<~QUERY
        {
          games {
            id
            name
          }
        }
      QUERY
    end

    it 'response body is Game data' do
      subject
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:games][0][:id].to_i).to eq game_a.id
      expect(json[:data][:games][0][:name]).to eq game_a.name
      expect(json[:data][:games][1][:id].to_i).to eq game_b.id
      expect(json[:data][:games][1][:name]).to eq game_b.name
    end
  end
end
