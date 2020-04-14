get '/new_bookmark' do
    redirect '/index' if !session[:logged_in]
    erb :new_bookmark
end

post '/addBookmark' do
    redirect '/index' unless session[:logged_in]
    
    time = Time.new
    
    #if the time is 0-9 write in 2 digits
    @last_updated = time.strftime("%Y%m%d") + time.strftime("%k").tr(" ", "0") + time.strftime("%M")
    
    @bookmark_name = params[:bookmark_name]
    @link = params[:link]
    @description = params[:description]
    
    add_bookmark = "INSERT INTO bookmarks (bookmark_name, link, description, creator, last_updated) VALUES (?,?,?,?,?)"
    
    $db.execute add_bookmark, params[:bookmark_name], params[:link], params[:description], session[:user_id], @last_updated
    
    redirect '/'
end