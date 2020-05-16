get '/report/:id' do
    session[:reporting_id] = params["id"]
   
    redirect '/feedback'
end

get '/feedback' do
   
    erb :feedback
end

post '/sendFeedback' do

    #get the date and time
    @date_time = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    
    @feeback_topic = params[:feedback_topic]
    @feedback = params[:feedback]
    if session[:logged_in]
        @current_user = session[:user_id]
    else
        @current_user = guest
    end
    
    puts @feedback
    puts @feeback_topic
    
    if @feeback_topic == "Broken links"
        puts session[:reporting_id]
        Bookmark.reportBookmark(session[:reporting_id])
        Feedback.new(@current_user, @date_time, @feeback_topic, @feedback)
    else
        Feedback.new(@current_user, @date_time, @feeback_topic, @feedback)
    end
    
    redirect '/'
end