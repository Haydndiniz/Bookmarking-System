require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/cookies'
set :bind, '0.0.0.0'
enable :sessions

get '/' do
    erb :new_bookmark
end

post '/new_bookmark' do
    puts params
    redirect '/'
end