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
get'/my_account' do
   
   if !session[:logged_in]  
      flash[:warning] = "Please login to continue"
      redirect '/login'
   else   
      @editing_user = User.admin_find_user(session[:user_id])
      erb :user_account
   end
end

#not_found page
not_found do
   erb :not_found404
end


##--------------------Post Methods--------------------#

#search
post '/index' do
    @search = params[:search]
    
    #checks if tags have been input
    if params[:tags].nil?
        @tags = 0
    else
        @tags = params[:tags]
    end
    
    @bookmark_list = Bookmark.find_by(@search, @tags)
    erb :index
end

# update users account
post '/my_account_update' do
    @user_id = params[:user_id]
    @first_name = params[:fname].strip
    @last_name = params[:lname].strip
    @username = params[:username].strip
    @email = params[:email].strip
      
      User.user_update(@user_id,@username, @first_name, @last_name, @email)
   flash[:success]="user updated"
      redirect '/my_account'
end