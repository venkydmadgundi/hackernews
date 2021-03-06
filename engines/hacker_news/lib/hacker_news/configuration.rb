module HackerNews
  module Configuration

    VALID_CONFIGURATION_KEYS = [:api_url, :headers]

    attr_accessor *VALID_CONFIGURATION_KEYS

    DEFAULT_API_URL  = 'https://hacker-news.firebaseio.com/v0/'
    DEFAULT_HEADERS  = { accept:     'application/json',
                         user_agent: "HackerNews_api gem #{HackerNews::Version}" }

    def configure
      yield self
    end

    def reset
      self.api_url     = DEFAULT_API_URL
      self.headers     = DEFAULT_HEADERS
      self
    end
  end
end
