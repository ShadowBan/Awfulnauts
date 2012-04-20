require 'nokogiri'
require 'open-uri'

class Rss

  #### Pod Casts ####
  def self.update_gamebreaker
    doc = Nokogiri::XML(open("http://www.gamebreaker.tv/video-game-shows/star-wars-the-old-republic-video/the-republic-swtor-show/feed/"))
    newest = doc.xpath('//item').first
    data = {}
    data[:title] = newest.xpath('title').text
    data[:link] = newest.xpath('link').text 
    data[:pubdate] = Date.parse(newest.xpath('pubDate').text).to_s rescue nil
    data[:last_update] = (Date.today - Date.parse(newest.xpath('pubDate').text)).to_i rescue nil
    settings.cache.set('gamebreaker', data, 3600)
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
    data[:last_update] = (Date.today - Date.parse(newest.xpath('pubDate').text)).to_i rescue nil
    settings.cache.set('darthhater_cast', data, 3600)
    data
  end

  #### News Feeds ####
  def self.update_darthhater
    doc = Nokogiri::XML(open("http://www.darthhater.com/articles.rss"))
    items = doc.xpath('//item')
    pfeed = []
    items.each do |item|
      data = {} 
      data[:title] = item.xpath('title').text
      data[:url] = item.xpath('link').text
      pfeed << data
    end
    settings.cache.set('darthhater', pfeed, 3600)
    pfeed
  end

  def self.update_devtracker
    doc = Nokogiri::XML(open("http://www.darthhater.com/devtracker.rss"))
    items = doc.xpath('//item')
    pfeed = []
    items.each do |item|
      data = {} 
      data[:title] = item.xpath('title').text
      data[:url] = item.xpath('link').text
      pfeed << data
    end
    settings.cache.set('devtracker', pfeed, 3600)
    pfeed
  end

  def self.update_guild_twitter
    settings.cache.set('guild_twitter', '')
  end

  def self.update_guild_reddit
    settings.cache.set('guild_reddit', '')
  end

  def self.update_swtor_reddit
    settings.cache.set('swtor_reddit', '')
  end

  def self.get_feed(feed)
    data = settings.cache.get(feed)
    data = send("update_#{feed}") if data.nil?
    data
  end

  def self.expire_cache
    settings.cache.flush
  end
end