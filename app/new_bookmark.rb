
get '/new_Bookmark' do
    redirect '/index' if !session[:logged_in]
    erb :new_bookmark
end

post '/addBookmark' do
    redirect '/index' unless session[:logged_in]
    add_bookmark(params[:user_id], params[:bookmark_name], params[:link], params[:description])
    
    insert = "INSERT INTO bookmarks (bookmark_name, link, description) VALUES (?,?,?,?,?,?,?,?)"
    $db.execute insert, params[:bookmark_name], params[:link], params[:description]
    
    puts params
    redirect '/'
end