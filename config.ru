require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require './app_helper.rb'
require './app.rb'

run Sinatra::Application