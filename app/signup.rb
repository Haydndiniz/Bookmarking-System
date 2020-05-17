get '/signup' do
    erb :signup
end

post '/signup' do
    
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @username = params[:username]
    @email = params[:email]
    @confirmed_email = params[:email_confirm]
    @confirmed_password = params[:password_confirm]
    @password = params[:password]
    @email_used = User.find_email(@email)
    @username_used = User.find_username(@username)
    
    if @email_used 
        flash[:info] = "Sorry, this email is already registered"
        redirect '/signup'
    elsif @username
        flash[:info] = "Sorry, this username is already used by a different user"
        redirect '/signup'
    elsif @email == @confirmed_email && @password == @confirmed_password
        User.new(@username, @first_name, @last_name, @password, @email)
        #flash[:info] = "Your account is created. You can now log in"
        redirect '/login'
    else
        redirect '/signup'
    end
    
end