#get login request and redirect to login page
get '/login' do
    redirect '/index' if session[:logged_in]
    erb :login
end


#get logout request and redirect to index page
get '/logout' do 
    query = "UPDATE users SET active_status = 0 WHERE email = ?;"  #set active status to 0 after logout
    $db.execute query, session[:email]                            
  	session.clear
  	redirect '/index'
end

post '/login' do 
    session.clear
    @email = params[:email]
    @pass = params[:password]
    session[:logged_in] = User.find_user(@email, @pass)
    puts session[:logged_in]
   
    if session[:logged_in]
        session[:email] = params[:email]
        puts session[:email]
        query = "UPDATE users SET active_status = 1 WHERE email = ?;"  #set active status to 1 after log in
        $db.execute query, session[:email]
        redirect '/index'
    else
        erb :login
    end
end

#get '/logged' do
    #@user_email = session[:email]
    #if @user_email
       #erb :logged 
    #else
        #redirect '/'
    #end
#end


