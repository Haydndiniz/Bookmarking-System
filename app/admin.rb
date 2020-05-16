get'/admin' do
    erb :admin_dashboard
end

get '/admin_users' do 
     @user_list = $db.execute "SELECT * FROM users ORDER BY user_id ASC"
      @new_user_list = $db.execute "SELECT * FROM users WHERE new = 1 ORDER BY user_id ASC"
    erb :admin_user_mgmt
end

get '/admin_bookmarks' do 
   @admin_bookmark_list = $db.execute "SELECT * FROM bookmarks ORDER BY bookmark_id ASC"
    erb :admin_bookmark_mgmt
end

get '/admin_feedback' do 
      @admin_feedback_list = $db.execute "SELECT * FROM feedback ORDER BY feedback_id ASC"   
    erb :admin_feedback
end

post '/admin_add_user' do
     User.approve(params[:userid])
    redirect '/admin_user'
end

post '/admin_resolve_feedback' do
     Feedback.approve(params[:feedbackid])
    redirect '/admin_feedback'
end