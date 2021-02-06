class ApplicationController < ActionController::API
  def client
    @client ||= Hackernews::Client.new
  end
end
