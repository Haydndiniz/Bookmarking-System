get '/signup' do
    Bookmark.getTags(2)
    erb :signup
end

post '/signup' do
    
    @first_name = params[:first_name].strip
    @last_name = params[:last_name].strip
    @username = params[:username].strip
    @email = params[:email].strip
    @confirmed_email = params[:email_confirm].strip
    @confirmed_password = params[:password_confirm].strip
    @password = params[:password].strip
    @email_used = User.find_email(@email)
    @username_used = User.find_username(@username)
    
    if @email_used 
        flash[:info] = "Sorry, this email is already registered"
        redirect '/signup'
    elsif @username_used
        flash[:info] = "Sorry, this username is already used by a different user"
        redirect '/signup'
    elsif @email == @confirmed_email && @password == @confirmed_password
        User.new(@username, @first_name, @last_name, @password, @email)
        flash[:info] = "Your account is waiting for admin verification"
        redirect '/login'
    else
        redirect '/signup'
    end
    
end