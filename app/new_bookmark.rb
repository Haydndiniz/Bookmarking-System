get '/new_bookmark' do
   if !session[:logged_in]  
      flash[:warning] = "Please login to create a bookmark"
       redirect '/login'
   else
    erb :new_bookmark
   end
end

post '/new_Bookmark' do
    redirect '/index' unless session[:logged_in]
    
    #date-time format (YYYY/MM/DD HH:MM)
    @last_updated = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    
    @bookmark_name = params[:bookmark_name].strip
    @link = params[:link].strip
    @description = params[:description].strip
    @report_status=2
    
    Bookmark.new(@bookmark_name, @link, @description, session[:user_id], @last_updated)
    
#     add_bookmark = "INSERT INTO bookmarks (bookmark_name, link, description, creator, last_updated) VALUES (?,?,?,?,?)"
    
#     $db.execute add_bookmark, params[:bookmark_name], params[:link], params[:description], session[:user_id], @last_updated
    
    redirect '/'
end