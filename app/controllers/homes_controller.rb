    class HomesController < ApplicationController
      # GET /homes
      def index
        @stories = client.topstories(0, 10)
        render json: @stories
      end
    end

