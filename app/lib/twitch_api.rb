require 'net/http'
require 'uri'

class TwitchApi
  if Rails.env.development?
    TWITCH_ACCESS_TOKEN = ENV.fetch('TWITCH_ACCESS_TOKEN')
  elsif Rails.env.production?
    TWITCH_ACCESS_TOKEN = Rails.application.credentials.api_key[:twitch_access_token]
  end

  class << self
    def get_json(location, limit = 10)
      raise ArgumentError, 'too many HTTP redirects' if limit == 0
      logger = Logger.new('./log/twitchapi.log')

      uri = URI.parse(location)
      begin
        req = Net::HTTP::Get.new(uri.request_uri)
        req['Client-ID'] = TWITCH_ACCESS_TOKEN
        response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.open_timeout = 5
          http.read_timeout = 10
          http.request(req)
        end
        case response
        when Net::HTTPSuccess
          json = response.body
          return JSON.parse(json)
        when Net::HTTPRedirection
          location = response['location']
          warn "redirected to #{location}"
          get_json(location, limit - 1)
          logger.warn("Redirection: code=#{response.code} message=#{response.message}")
        else
          logger.error("HTTP ERROR: code=#{response.code} message=#{response.message}")
        end
      rescue IOError => e
        logger.error(e.message)
      rescue TimeoutError => e
        logger.error(e.message)
      rescue JSON::ParserError => e
        logger.error(e.message)
      rescue => e
        logger.error(e.message)
      end
    end

    def get_game_id(game_name)
      uri = "https://api.twitch.tv/helix/games?name=#{game_name}"
      game = get_json(uri)
      game['data'][0]['id']
    end

    def get_streams(game_name, first)
      language = 'ja'
      game_id = get_game_id(game_name)
      uri = "https://api.twitch.tv/helix/streams?game_id=#{game_id}&first=#{first}&language=#{language}"
      get_json(uri)
    end

    def get_streams_with_cache(game_name, first)
      Rails.cache.fetch("twitch_#{game_name}", expires_in: 5.minutes) do
        get_streams(game_name, first)
      end
    end

    def get_user(user_id)
      uri = "https://api.twitch.tv/helix/users?id=#{user_id}"
      get_json(uri)
    end

    def get_user_with_cache(user_id)
      Rails.cache.fetch("twitch_#{user_id}", expires_in: 1.month) do
        get_user(user_id)
      end
    end
  end
end
