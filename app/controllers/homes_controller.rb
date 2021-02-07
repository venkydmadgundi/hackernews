    class HomesController < ApplicationController
      # GET /homes
      def index
 #       hacker_client = Hackernews::Client.new
#        puts hacker_client.methods.sort
        @stories = client.askstories(0, 10)
        render json: @stories
      end
    end

