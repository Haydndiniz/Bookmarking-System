get '/edit_bookmark/:id' do
    session[:editing] = params["id"]

    redirect '/edit_bookmark'
end

get '/edit_bookmark' do  
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