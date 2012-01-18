require 'nokogiri'
require 'open-uri'

class Rss

  def update_gamebreaker
    settings.cache.set('gamebreaker', '')
  end

  def get_gamebreaker
    settings.cache.get('gamebreaker')
  end

  def update_darthhater
    settings.cache.set('darthhater', '')
  end

  def get_darthhater
    settings.cache.get('darthhater')
  end

  def update_devtracker
    settings.cache.set('devtracker', '')
  end

  def get_devtracker
    settings.cache.get('devtracker')
  end

  def update_guild_twitter
    settings.cache.set('guild_twitter', '')
  end

  def get_guild_twitter
    settings.cache.get('guild_twitter')
  end

  def update_guild_reddit
    settings.cache.set('guild_reddit', '')
  end

  def get_guild_reddit
    settings.cache.get('guild_reddit')
  end

  def update_swtor_reddit
    settings.cache.set('swtor_reddit', '')
  end

  def get_swtor_reddit
    settings.cache.get('swtor_reddit')
  end

  def update_news
  	update_gamebreaker
  	update_darthhater
  	update_devtracker
  end

  def update_site_news
    update_guild_twitter
    update_guild_reddit
  end

  def update_reddit
    update_guild_reddit
    update_swtor_reddit
  end

  def update_all
    update_gamebreaker
    update_darthhater
    update_devtracker
    update_guild_twitter
    update_guild_reddit
    update_swtor_reddit
  end



end