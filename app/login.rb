VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
                    
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
    @login = true
    
    
    @email = params[:email]
    @pass = params[:password]
    @userFound = User.find_user(@email, @pass) 
    
    @email_ok = !@email.nil? && @email != "" && @email =~ VALID_EMAIL_REGEX
    @pass_ok = !@pass.nil? && @pass != ""
    @all_ok = @email_ok && @pass_ok
       
    if @userFound
    #Gather all user data
    query = "SELECT * FROM users WHERE email = ?;"
    @userInfo = $db.execute query, @email 
    @active = @userInfo[0][5]
        puts @active
    end
        
    if  @active == 0
        session[:logged_in] = true #User now logged in
        session[:admin] = false #User is not an admin until confirmed
        
    #   store user info in session data
        session[:email] = @userInfo[0][4]
        session[:user_id] = @userInfo[0][0]
        session[:first_name] = @userInfo[0][1]

        if @userInfo[0][6] == 1
            session[:admin] = true #User is an admin
            redirect'/admin'
        end
        redirect '/index'
    else
        session[:logged_in] = false
        erb :login
    end
    
end
