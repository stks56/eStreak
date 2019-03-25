require "net/http"
require "uri"

class TwitchApi
  TWITCH_ACCESS_TOKEN = ENV.fetch("TWITCH_ACCESS_TOKEN")

  def self.get_json(location, limit = 10)
    raise ArgumentError, 'too many HTTP redirects' if limit == 0
    uri = URI.parse(location)
    begin
      req = Net::HTTP::Get.new(uri.request_uri)
      req["Client-ID"] = TWITCH_ACCESS_TOKEN
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.open_timeout = 5
        http.read_timeout = 10
        res = http.request(req)
      end
      case response
      when Net::HTTPSuccess
        json = response.body
        return JSON.parse(json)
      when Net::HTTPRedirection
        location = response["location"]
        warn "redirected to #{location}"
        get_json(location, limit - 1)
      else
        puts [uri.to_s, response.value].join(" : ")
      end
    rescue => e
      puts [uri.to_s, e.class, e].join(" : ")
    end
  end

  def self.get_game_id(game_name)
    uri = "https://api.twitch.tv/helix/games?name=#{game_name}"
    game = get_json(uri)
    return game['data'][0]['id']
  end

  def self.get_streams(game_name, first)
    language = "ja"
    game_id = get_game_id(game_name)
    uri = "https://api.twitch.tv/helix/streams?game_id=#{game_id}&first=#{first}&language=#{language}"
    game = get_json(uri)
    return game['data']
  end

  def self.get_streams_with_cache(game_name, first)
    Rails.cache.fetch("twitch_#{game_name}", expires_in: 5.minutes) do
      get_streams(game_name, first)
    end
  end

  def self.get_user(user_id)
    uri = "https://api.twitch.tv/helix/users?id=#{user_id}"
    user = get_json(uri)
    return user['data']
  end

  def self.get_user_with_cache(user_id)
    Rails.cache.fetch("twitch_#{user_id}", expires_in: 24.hour) do
      get_user(user_id)
    end
  end
end
