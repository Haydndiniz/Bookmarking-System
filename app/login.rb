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
    @userFound = User.find_user(@email, @pass)
    

    #Gather all user data
    query = "SELECT * FROM users WHERE email = ?;"
    @userInfo = $db.execute query, @email 
    @active = @userInfo[0][5]
    
    if @active && @userFound
        session[:logged_in] = true #User now logged in
        session[:admin] = false #User is not an admin until confirmed
        
#         store user info in session data
         session[:email] = @userInfo[0][5]
         session[:user_id] = @userInfo[0][0]
         session[:first_name] = @userInfo[0][1]

        if @userInfo[0][7] == 1
            session[:admin] = true #User is an admin
            redirect'/admin'
        end
        redirect '/index'
    else
        session[:logged_in] = false
        erb :login
    end
end
