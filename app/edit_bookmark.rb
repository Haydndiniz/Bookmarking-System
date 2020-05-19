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
    
    #date-time format (YYYY/MM/DD HH:MM)
    @last_updated = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    
    
    Bookmark.update(@bookmark_name, @link, @description, @last_updated, session[:editing_id])
    
    redirect '/'
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