before do
    @bookmark_list = $db.execute "SELECT * FROM bookmarks ORDER BY bookmark_name ASC"
end

##--------------------Get Methods--------------------#
get '/' do
  	redirect '/index'
end

get '/index' do
    @search = params[:search]
#   Bookmark.find_by(@search)
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

get'/edit_bookmark' do
   
    erb :edit_bookmark
end

