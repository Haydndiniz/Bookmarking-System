#--------------------Get Methods--------------------#
get '/' do
  	redirect '/index'
end

get '/index' do
       erb :index 
end
    



# my account page
get'/myAccount' do
    redirect '/index' unless session[:loggedin]

    erb :myAccount
end

#not_found page
not_found do
    "page not found"
#     erb :not_found404
end
