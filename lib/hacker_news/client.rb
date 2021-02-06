require_relative 'request'
require_relative 'connection'
require_relative 'configuration'

module HackerNews
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

  end
end
