before do
   @bookmark_list_history = $db.execute "SELECT * FROM bookmark_history ORDER BY date ASC"
   $users_signed_in = 0 
   @tags_list = $db.execute "SELECT * FROM tags ORDER BY name ASC"
end

##--------------------Get Methods--------------------#

get '/history' do
    @search = params[:search]
    erb :history 
end

##--------------------Post Methods--------------------#

#search
post '/history' do
    @search = params[:search]
    
    #checks if tags have been input
    if params[:tags].nil?
        @tags = 0
    else
        @tags = params[:tags]
    end
    
    @bookmark_list_history = Bookmark.find_by(@search, @tags)
    erb :history
end