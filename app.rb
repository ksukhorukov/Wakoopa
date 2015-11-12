#!/usr/bin/env ruby

require 'sinatra'
require 'pp'
require './app_helper.rb'

get '/' do 
  erb :index
end

get '/unique' do 
  erb :unique, :locals => { :report => Facebook.all }  
end

get '/google' do 
  erb :google, :locals => { :report => Google.all }  
end

get '/deviation' do 
  erb :deviation, :locals => { :report => Deviation.last }  
end



