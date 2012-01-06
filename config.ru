require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require 'haml'
require './awfulnauts'
configure(:production){ run Sinatra::Application }
