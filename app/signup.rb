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
    
    if @email == @confirmed_email && @password == @confirmed_password
        User.new(@username, @first_name, @last_name, @password, @email)
        redirect '/login'
    else
        redirect '/signup'
    end
    
end