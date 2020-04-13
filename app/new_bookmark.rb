get '/new_bookmark' do
    redirect '/index' if !session[:logged_in]
    erb :new_bookmark
end

post '/addBookmark' do
    redirect '/index' unless session[:logged_in]
    
    time = Time.new
    @last_updated = time.year.to_s + time.month.to_s + time.day.to_s
    
    @bookmark_name = params[:bookmark_name]
    @link = params[:link]
    @description = params[:description]
    
    
    
    add_bookmark = "INSERT INTO bookmarks (bookmark_name, link, description, creator, last_updated) VALUES (?,?,?,?,?)"
    
    $db.execute add_bookmark, params[:bookmark_name], params[:link], params[:description], session[:user_id], @last_updated
    
    puts params
    redirect '/'
end