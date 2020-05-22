before do
       @bookmark_ids_in_favourites = Array.new
       @favourite_list_array = Array.new
     
       query = "SELECT bookmark_id FROM favourites WHERE user_id = ?"
       @bookmark_ids_in_favourites = $db.execute query, session[:user_id]

       @favourite_list_array.clear
       @bookmark_ids_in_favourites.each do |id|
           @favourite_list_array.insert(0, Bookmark.find_by_id(id))
       end
   
       @favourite_list = @favourite_list_array
       
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
    
    redirect '/'
end