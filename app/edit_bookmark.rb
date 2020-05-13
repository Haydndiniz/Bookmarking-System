get '/edit_bookmark/:id' do
    session[:editing_id] = params["id"]
   
    redirect '/edit_bookmark'
end

get '/edit_bookmark' do  
    @bookmark_info = Bookmark.find_by_id(session[:editing_id])
    
    erb :edit_bookmark
end

post '/EditBookmark' do
    redirect '/index' unless session[:logged_in]
    
    @bookmark_name = params[:bookmark_name]
    @link = params[:link]
    @description = params[:description]
    
    #date-time format (YYYY/MM/DD HH:MM)
    @last_updated = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    
    
    puts @bookmark_name, @link, @description, @last_updated, session[:editing_id]
    
    Bookmark.update(@bookmark_name, @link, @description, @last_updated, session[:editing_id])
    
#     update_bookmark = "UPDATE bookmarks SET bookmark_name = ?, link = ?, description = ?, last_updated = ? WHERE  bookmark_id = ?" 
    
#     $db.execute update_bookmark, session[:bookmark_name], session[:link], session[:description], @last_updated, session[:editing_id]
    
    puts "AFTER"
    puts @bookmark_name, @link, @description, @last_updated, session[:editing_id]
    
    redirect '/'
end