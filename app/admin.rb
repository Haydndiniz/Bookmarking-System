get'/admin' do
    erb :admin_dashboard
end

get '/admin_users' do 
   
    erb :admin_user_mgmt
end

get '/admin_bookmarks' do 
   
    erb :admin_bookmark_mgmt
end

get '/admin_feedback' do 
    erb :admin_feedback
end