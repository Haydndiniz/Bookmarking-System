get '/signup' do
    erb :signup
end

post '/signup' do
    
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @username = params[:username]
    @email = params[:email]
    @password = params[:password]
    
    User.new(@username, @first_name, @last_name, @password, @email)
    
#     add_bookmark = "INSERT INTO bookmarks (bookmark_name, link, description, creator, last_updated) VALUES (?,?,?,?,?)"
    
#     $db.execute add_bookmark, params[:bookmark_name], params[:link], params[:description], session[:user_id], @last_updated
    
    redirect '/login'
end