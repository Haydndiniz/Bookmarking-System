get '/feedback' do
   
    erb :feedback
end

post '/sendFeedback' do

    #get the date and time
    
    @date_time = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    @feeback_topic = params[:topic]
    @feedback = params[:feedback]
    if session[:logged_in]
        @current_user = session[:user_id]
    else 
        @current_user = guest
    end
    
    insert = "INSERT INTO feedback (user_id, date_time, feedback) VALUES (?,?,?,?)"
    $db.execute send_feedback, @current_user,  @date_time, @feeback_topic, @feedback

    redirect '/'
end