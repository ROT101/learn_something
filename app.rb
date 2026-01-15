# Simple Sinatra application
require 'sinatra'
require 'json'

get '/' do
  content_type :json
  { message: "Welcome to learn_something (ROT101)" }.to_json
end

get '/health' do
  status 200
  'OK'
end
