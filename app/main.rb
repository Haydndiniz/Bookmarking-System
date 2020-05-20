before do
   @bookmark_list = $db.execute "SELECT * FROM bookmarks ORDER BY report_status DESC"
   $users_signed_in = 0 
   @tags_list = $db.execute "SELECT * FROM tags ORDER BY name ASC"
end

##--------------------Get Methods--------------------#
get '/' do
  	redirect '/index'
end

get '/index' do
    @search = params[:search]
    erb :index 
end

# my account page
get'/myAccount' do
    redirect '/index' unless session[:loggedin]

    erb :myAccount
end

#not_found page
not_found do
    erb :not_found404
end


##--------------------Post Methods--------------------#

#search
post '/index' do
    @search = params[:search].strip
    
    #checks if tags have been input
    if params[:tags].nil?
        @tags = 0
    else
        @tags = params[:tags]
    end
    
    @bookmark_list = Bookmark.find_by(@search, @tags)
    erb :index
end

