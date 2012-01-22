require 'nokogiri'
require 'open-uri'

class Rss

  #### Pod Casts ####
  def self.update_gamebreaker
    doc = Nokogiri::XML(open("http://feeds.feedburner.com/TheRepublic-TheStarWarsTheOldRepublicPodcast?format=xml"))
    newest = doc.xpath('//item').first
    data = {}
    data[:title] = newest.xpath('title').text
    data[:link] = newest.xpath('link').text
    data[:image_url] = newest.xpath('blip:picture').text
    data[:pubdate] = Date.parse(newest.xpath('pubDate').text).to_s rescue nil
    settings.cache.set('gamebreaker', data, 3600)
    data
  end

  def self.get_gamebreaker
    data = settings.cache.get('gamebreaker')
    data = self.update_gamebreaker if data.nil?
    data
  end

  def self.update_darthhater_cast
    doc = Nokogiri::XML(open("http://www.darthhater.com/articles/podcast.rss"))
    newest = doc.xpath('//item').first
    data = {}
    data[:title] = newest.xpath('title').text
    data[:link] = newest.xpath('link').text
    data[:image_url] = doc.xpath('//image/url').text
    data[:pubdate] = Date.parse(newest.xpath('pubDate').text).to_s rescue nil
    settings.cache.set('darthhater_cast', data, 3600)
    data
  end

  def self.get_darthhater_cast
    data = settings.cache.get('darthhater_cast')
    data = self.update_darthhater_cast if data.nil?
    data
  end

  #### News Feeds ####
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

  def expire_cache
    settings.cache.flush
  end
end