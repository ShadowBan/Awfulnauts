require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require 'haml'
require 'dalli'
require './awfulnauts'

set :cache, Dalli::Client.new(:expires_in => 600)
configure(:production){ run Sinatra::Application }
