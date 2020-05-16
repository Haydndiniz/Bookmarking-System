get'/admin' do
    erb :admin_dashboard
end

get '/admin_users' do 
     @user_list = $db.execute "SELECT * FROM users ORDER BY user_id ASC"
    erb :admin_user_mgmt
end

get '/admin_bookmarks' do 
   @admin_bookmark_list = $db.execute "SELECT * FROM bookmarks ORDER BY bookmark_id ASC"
    erb :admin_bookmark_mgmt
end

get '/admin_feedback' do 
    erb :admin_feedback
end