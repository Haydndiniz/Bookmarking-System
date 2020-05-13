get '/edit_bookmark/:id' do
    if !session[:logged_in]
        flash[:warning] = "Please login to edit bookmarks"
    end   
    redirect '/index' if !session[:logged_in]
    @bookmark_id = params[:id]
    @bookmark_info = Bookmark.find_by_id(@bookmark_id)
    @bookmark_name = @bookmark_info[0][1]
    @link = @bookmark_info[0][2]
    @description = @bookmark_info[0][3]
    @bookmark_name = @bookmark_info[0][4]
    erb :edit_bookmark
end

post '/EditBookmark' do
    redirect '/index' unless session[:logged_in]
    
    #date-time format (YYYY/MM/DD HH:MM)
    @last_updated = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    
    
    @bookmark_name = params[:bookmark_name]
    @link = params[:link]
    @description = params[:description]
    @report_status=0
    
    
    Bookmark.update(@bookmark_id, @bookmark_name, @link, @description, @last_updated)
    
    redirect '/'
end