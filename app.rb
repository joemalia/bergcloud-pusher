require 'sinatra'
require 'json'
require 'pusher'

Pusher.url = ENV['PUSHER_URL']
PUSHER_KEY = ENV['PUSHER_KEY']

post '/device-event/:event_name' do |event_name|
  address = params[:address]
  payload = JSON.parse(params[:payload])
  Pusher[address].trigger('device-event', :name => event_name, :payload => payload)
  204
end

get '/' do
  erb :index
end

get '/device' do
  address = params[:address]
  erb :device, :locals => { :pusher_key => PUSHER_KEY, :address => address }
end
