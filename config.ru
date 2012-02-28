require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require 'haml'
require 'dalli'
require 'date'
require './awfulnauts'
require './rss'
require './sk'

set :cache, Dalli::Client.new
configure(:production){ run Sinatra::Application }
