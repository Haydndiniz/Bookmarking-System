
get '/new_bookmark' do
    erb :new_bookmark
end

post '/new_bookmark' do
    insert = "INSERT INTO bookmarks (bookmark_name, link, description) VALUES (?,?,?)"
    $db.execute insert, params[:name_of_bookmark], params[:link], params[:description]
    
    puts params
    redirect '/'
end