# Simple Sinatra application
require 'sinatra'
require 'sinatra/activerecord'
require 'json'

# Configure database
set :database, ENV['DATABASE_URL'] || 'postgresql://localhost/learn_something_development'

get '/' do
  content_type :json
  { message: "Welcome to learn_something (ROT101)" }.to_json
end

get '/health' do
  status 200
  'OK'
end
