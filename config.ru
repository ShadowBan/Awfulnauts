require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require 'haml'
require 'dalli'
require 'date'
require './awfulnauts'
require './rss'

set :cache, Dalli::Client.new
configure(:production){ run Sinatra::Application }
