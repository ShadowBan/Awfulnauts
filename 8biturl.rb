#8bitURL.rb
require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require 'dm-core'
require 'dm-migrations'
require 'haml'

### SETUP
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'mysql://localhost/biturl')

### MODELS

class Biturl
  include DataMapper::Resource
  
  property :id, Serial
  property :created_at, DateTime, :required=>true,:unique=>true
  property :tix, String, :required=>true,:unique=>true
  property :url, Text
  
  def self.gen_ticket(size=5)
    begin
      ticket = (1..size).map{([*('a'..'z')]+[*('A'..'Z')]+[*(1..9)].map{|n|n.to_s}).instance_eval{self[rand(self.size)]}}.join
      test = Biturl.first(:tix=>ticket)
      return ticket if test.nil? && !ticket.nil?
    end while false
  end
end

DataMapper.finalize

#DataMapper.auto_migrate!
DataMapper.auto_upgrade!

### CONTROLLER ACTIONS

layout :layout

#Home Page
get '/' do
  #"Hello World"
  haml :index
end

#Give URL Page
get '/bonus/:tix' do
  @biturl = Biturl.first(:tix=>params[:tix])
  haml :bonus
end

#Create a URL
post '/bonus' do
  url = params[:url] =~ /(^http:\/\/|^https:\/\/)/ ? params[:url] : "http://" + params[:url]
  @biturl = Biturl.first(:url=>url)
  if @biturl.nil?
    tix = Biturl.gen_ticket()
    @biturl = Biturl.create({:tix=>tix, :url=>url, :created_at=>Time.now})
  end
  redirect "/bonus/#{@biturl.tix}"
end

#Bounce Page
get '/:tix' do
  tix = params[:tix]
  biturl = Biturl.first(:tix=>tix)
  redirect biturl.nil? ? "/" : biturl.url
end
