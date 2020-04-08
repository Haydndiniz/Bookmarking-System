#get login request and redirect to login page
get '/login' do
    redirect '/index' if session[:logged_in]
    erb :login
end


#get logout request and redirect to index page
get '/logout' do
  	session.clear
  	redirect '/index'
end

post '/login' do 
    session.clear
    @email = params[:email]
    @pass = params[:password]
    session[:logged_in] = User.find_user(@email, @pass)
   
    if session[:logged_in]
        session[:email] = params[:email]
        redirect '/index'
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


