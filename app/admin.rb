get'/admin' do
   if !session[:admin]  
      flash[:warning] = "You wandered into protected space, please login to continue"
       redirect '/login'
   else
    erb :admin_dashboard
   end
end

#get method for admin users, retrieves users from db and stores it in an array
get '/admin_users' do 
   if !session[:admin]  
       flash[:warning] = "You wandered into protected space, please login to continue"
       redirect '/login'
   else
     @user_list = $db.execute "SELECT * FROM users ORDER BY user_id ASC"
      @new_user_list = $db.execute "SELECT * FROM users WHERE new = 1 ORDER BY user_id ASC"
    erb :admin_user_mgmt
   end
end

#get method for admin bookmarks, retrieves bookmarks from db and stores it in an array
get '/admin_bookmarks' do
   if !session[:admin]  
      flash[:warning] = "You wandered into protected space, please login to continue"
       redirect '/login'
   else
   @admin_bookmark_list = $db.execute "SELECT * FROM bookmarks ORDER BY bookmark_id ASC"
    erb :admin_bookmark_mgmt
   end
end

#get method for feedback, retrieves feedback from db and stores it in an array
get '/admin_feedback' do 
   if !session[:admin]  
      flash[:warning] = "You wandered into protected space, please login to continue"
       redirect '/login'
   else
      @admin_feedback_list = $db.execute "SELECT * FROM feedback ORDER BY feedback_id ASC"   
    erb :admin_feedback
   end
end

#get method to edit specific user
get '/admin_edit_user/:id' do
    if !session[:admin]  
      flash[:warning] = "You wandered into protected space, please login to continue"
       redirect '/login'
    end   
    
    redirect '/index' if !session[:admin]
    
    session[:editing_id] = params["id"]
   
    redirect '/admin_edit_user'
end

get '/admin_edit_user' do
   if !session[:admin]  
      flash[:warning] = "You wandered into protected space, please login to continue"
       redirect '/login'
   else   
      @admin_editing_user = User.admin_find_user(session[:editing_id])
    erb :admin_edit_user
   end
end

##--------------------Post Methods--------------------#


post '/admin_add_user' do
     User.approve(params[:userid])
    redirect '/admin_users'
end

post '/admin_update_user' do
    @user_id = params[:user_id]
    @first_name = params[:fname].strip
    @last_name = params[:lname].strip
    @username = params[:username].strip
    @email = params[:email].strip
    @active_status = params[:active_status].strip
   
   
      User.update(@user_id,@username, @first_name, @last_name, @email, @active_status)
      redirect '/admin_users'
end

post '/admin_resolve_feedback' do
     Feedback.approve(params[:feedbackid])
    redirect '/admin_feedback'
end