get '/edit_bookmark/:id' do
    if !session[:logged_in]
        flash[:warning] = "Please login to edit bookmarks"
    end
    
    redirect '/index' if !session[:admin]
    
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
    @report_status=params[:active_status]
    
    #date-time format (YYYY/MM/DD HH:MM)
    @last_updated = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    
   #parses link and adds url scheme to the link if it is missing
    uri = URI::parse(@link)
      if uri.scheme.nil? && uri.host.nil?
        unless uri.path.nil?
          uri.scheme = "http"
          uri.host = uri.path
          uri.path = ""
        end
      end
     @link_parsed = uri.to_s
    
    Bookmark.update(@bookmark_name, @link_parsed, @description, @last_updated, session[:editing_id], @report_status)
    
    redirect '/admin_bookmarks'
end

post '/submit_rating' do
    @id = params[:bookmark_id].to_i
    @rating = params[:stars].to_i
    @numRatings = params[:num_ratings].to_i
    @currentRating = params[:current_rating].to_f
    Bookmark.updateRating(@id, @rating, @numRatings, @currentRating)
    puts ((@currentRating*@numRatings)+@rating)/(@numRatings +1)
    puts ("added rating " + @rating.to_s + "to bookmark with id: " + @id.to_s)
    redirect '/'
end