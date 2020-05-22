
get'/favourites' do
   
   if !session[:logged_in]  
      flash[:warning] = "Please login to continue"
      redirect '/login'
   else   
       @bookmark_ids_in_favourites = Array.new
       @favourite_list_array = Array.new
       @last_visit = Array.new

       query = "SELECT bookmark_id FROM favourites WHERE user_id = ?"
       @bookmark_ids_in_favourites = $db.execute query, session[:user_id]

       @favourite_list_array.clear
       @bookmark_ids_in_favourites.each do |id|
           @favourite_list_array.insert(0, Bookmark.find_by_id(id))
       end
   
       @favourite_list = @favourite_list_array
       erb:favourite 
    end 
end



get'/favourites' do
   
   if !session[:logged_in]  
      flash[:warning] = "Please login to continue"
      redirect '/login'
   else   
       erb :favourite 
    end 
    
end

post '/add_to_favourites' do
    @user_id = session[:user_id]
    @favourite_bookmark_id = params[:bookmark_id].to_i
 
    if !@favourite_list_array.include? (Bookmark.find_by_id(@favourite_bookmark_id))  
        Favourite.new(@user_id, @favourite_bookmark_id)
    end 

end

post '/add_favourite' do
    @user_id = session[:user_id]
    @favourite_bookmark_id = params[:bookmark_id].to_i
 
        Favourite.new(@user_id, @favourite_bookmark_id)
    
    redirect back
end

post '/remove_favourite' do
    @user_id = session[:user_id]
    @favourite_bookmark_id = params[:bookmark_id].to_i
 
   Favourite.remove(@user_id, @favourite_bookmark_id)
    
    redirect back

end