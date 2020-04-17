get '/feedback' do
    redirect '/index' if !session[:logged_in]
    erb :feedback
end

post '/sendFeedback' do
    redirect '/index' unless session[:logged_in]

    #get the date and time
    time = Time.new
    @date_time = time.strftime("%Y%m%d") + time.strftime("%k").tr(" ", "0") + time.strftime("%M")
    
    @feedback = params[:feedback]
    
    send_feedback = "INSERT INTO feedback (user_id, date_time, feedback) VALUES (?,?,?)"
    $db.execute send_feedback, session[:user_id],  @date_time, params[:feedback]

    redirect '/'
end