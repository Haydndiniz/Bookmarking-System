before do
   @ids_in_history = Array.new
   @bookmark_list_array = Array.new
   @last_visit = Array.new
    
   query = "SELECT bookmark_id FROM bookmark_history WHERE user_id = ?"
   @ids_in_history = $db.execute query, session[:user_id]
     
   @bookmark_list_array.clear
   @ids_in_history.each do |id|
       @bookmark_list_array.insert(0, Bookmark.find_by_id(id))
   end
   
   @bookmark_list_history = @bookmark_list_array
   #puts "#{@bookmark_list_history}"
   $users_signed_in = 0 
   @tags_list = $db.execute "SELECT * FROM tags ORDER BY name ASC"
end

##--------------------Get Methods--------------------#

get '/history' do
    @search = params[:search].strip
    erb :history 
end

##--------------------Post Methods--------------------#

#search
post '/history' do
    @search = params[:search].strip
    
    #checks if tags have been input
    if params[:tags].nil?
        @tags = 0
    else
        @tags = params[:tags].strip
    end
    
    @bookmark_list_history = Bookmark.find_by(@search, @tags)
    erb :history
end

post '/add_to_history' do
    @user_id = session[:user_id]
    @visited_bookmark_id = params[:bookmark_id].to_i
    @visit_time = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    #Bookmark.updateLastVisited(@visited_bookmark_id, @visit_time)
    
    #if !@bookmark_list_array.include? (Bookmark.find_by_id(@visited_bookmark_id))  
        History.new(@user_id, @visited_bookmark_id, @visit_time)
    #else
        #History.update_date(@visited_bookmark_id, @visit_time)
    #end
   
    
    puts "#{@user_id} #{@visited_bookmark_id} #{@visit_time} added to history"
    redirect'/'
end