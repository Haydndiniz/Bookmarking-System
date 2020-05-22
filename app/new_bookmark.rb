get '/new_bookmark' do
   if !session[:logged_in]  
      flash[:warning] = "Please login to create a bookmark"
      redirect '/login'
   else
      erb :new_bookmark
   end
end

post '/new_Bookmark' do
    redirect '/index' unless session[:logged_in]
    
    #date-time format (YYYY/MM/DD HH:MM)
    @last_updated = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    
    @bookmark_name = params[:bookmark_name].strip
    @link = params[:link].strip
    @description = params[:description].strip
    @report_status=2
    
     uri = URI::parse(@link)
      if uri.scheme.nil? && uri.host.nil?
        unless uri.path.nil?
          uri.scheme = "http"
          uri.host = uri.path
          uri.path = ""
        end
      end
      @link_parsed = uri.to_s
   
    Bookmark.new(@bookmark_name, @link_parsed, @description, session[:user_id], @last_updated)  
    redirect '/'
end