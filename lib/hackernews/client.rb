module Hackernews
  class Client
    def initialize
      @host = 'community-hacker-news-v1.p.rapidapi.com'
      @host = 'hacker-news.firebaseio.com/v0'
      @key = 'a1fe41ba72msh720397065df6c9dp1c4973jsn6fed9033fc00'
    end

    def item(id)
      get("item/#{id}")
    end

    def topstories(start = 0, per_page = 25) 
      story('top', start, per_page)
    end

    def askstories(start = 0, per_page = 25)                                                                                 story('ask', start, per_page)
    end

    def shostories(start = 0, per_page = 25)                                                                                 story('show', start, per_page)
    end

    def jobstories(start = 0, per_page = 25)                                                                                 story('job', start, per_page)
    end

    def story(type_story = 'topstories', start = 0, per_page = 25)
 #     stories = get('topstories')[start...start + per_page]
      stories = get("#{type_story}stories")[start...start + per_page]
      #puts Time.now
      #hacker_stories = []
      stories.map! do |story|
#          hacker_stories << [score: item(story)['score'], title: item(story)['title'], user: item(story)['by'], time: Time.at(item(story)['time']), url: item(story)['url']]
        item(story)
      end
      #puts Time.now
 #     hacker_stories.flatten
      stories
    end

#   ["top", "ask", "show", "job"].each do |method|
 #    define_method "self.#{method}stories(start = 0, per_page = 25)" do
  #     stories = get('#{method}stories')[start...start + per_page]
   #    stories.map! do |story|
    #     item(story)
     #  end  
      # stories
#     end
 #  end

    private

    def get(path)
      response = Excon.get(
        'https://' + @host + '/' + path + '.json?print=pretty',
        headers: {
          'x-rapidapi-host' => @host,
          'x-rapidapi-key' => @key,
        }
      )

      return false if response.status != 200

      JSON.parse(response.body)
    end
  end
end
