require 'json'
require 'hashie'
require 'faraday_middleware'
module HackerNews
  module Configuration
    VALID_CONFIGURATION_KEYS = [:api_url, :headers]
    attr_accessor *VALID_CONFIGURATION_KEYS
    #DEFAULT_API_URL  = 'https://hacker-news.firebaseio.com/v0/'
    DEFAULT_API_URL  = 'https://community-hacker-news-v1.p.rapidapi.com'
    DEFAULT_HEADERS  = { accept:     'application/json',
                         "x-rapidapi-key": "a1fe41ba72msh720397065df6c9dp1c4973jsn6fed9033fc00",
                         "x-rapidapi-host": "community-hacker-news-v1.p.rapidapi.com",
                         user_agent: "HackerNews_api gem #{HackerNews::VERSION}" }

    def configure
      yield self
    end

    def reset
      self.api_url     = DEFAULT_API_URL
      self.headers     = DEFAULT_HEADERS
      self
    end
  end
  module Connection

    private

    def connection
      options = {
        headers: headers,
        ssl:     { verify: false },
        url:     api_url
      }

      Faraday.new(options) do |connection|
        connection.use Faraday::Request::UrlEncoded
        connection.use Faraday::Response::RaiseError
        connection.adapter(Faraday.default_adapter)
      end
    end
  end
  module Request
    def get(path, options = {})
      request(:get, path, options)
    end

    private

    def request(method, path, options)
      response = connection.send(method) do |request|
        request.url(path, options)
      end
      prepare(response)
    end

    def prepare(response)
      result = JSON.parse(response.body) rescue response.body
      result.is_a?(Hash) ? Hashie::Mash.new(result) : result
    end
  end
  class Client
    include HackerNews::Request
    include HackerNews::Connection
    include HackerNews::Configuration

    def initialize
      reset
    end

    def item(id, options = {})
      get("item/#{id}.json", options)
    end

    def user(id, options = {})
      get("user/#{id}.json", options)
    end

    def top_stories(options = {})
      get('topstories.json', options)
    end

  end
end
