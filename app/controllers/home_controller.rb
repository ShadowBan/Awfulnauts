class HomeController < ApplicationController
  def index
    #  @gamebreaker = Rss.get_gamebreaker
    #  @darth_cast = Rss.get_darthhater_cast

    @gamebreaker = Rss.get_feed('gamebreaker')
    @darth_cast = Rss.get_feed('darthhater_cast')
    @darthhater = Rss.get_feed('darthhater')
    @devtracker = Rss.get_feed('devtracker')
    @guild_twitter = Rss.get_feed('guild_twitter')
    @guild_reddit = Rss.get_feed('guild_reddit')
    @swtor_reddit = Rss.get_feed('swtor_reddit')
  end

  def slideshow

  end

  def error

  end

  def expire
    Rss.expire_cache
    #redirect '/'
  end
end
