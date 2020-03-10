require 'sinatra'
require 'sinatra/reloader'
require_relative 'models/user.rb'

set :bind, '0.0.0.0'
enable :sessions

get '/' do
    erb :login
end

post '/' do 
    session.clear
    @email = params[:email]
    @pass = params[:password]
    verified_user = User.find_user(@email, @pass)
   
    if verified_user
        session[:email] = params[:email]
        redirect '/logged'
    else
        erb :login
    end
end

get '/logged' do
    @user_email = session[:email]
    if @user_email
       erb :logged 
    else
        redirect '/'
    end
end

get '/logout' do
  session.clear
  redirect '/'
end

