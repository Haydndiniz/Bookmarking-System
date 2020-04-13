get '/feedback' do
    redirect '/index' if !session[:logged_in]
    erb :feedback
end

post '/sendFeedback' do
    redirect '/index' unless session[:logged_in]

    #get the date and time
    time = Time.new
    @date_time = time.day.to_s + "/" + time.month.to_s + "/" +  time.year.to_s + " " + time.hour.to_s + ":" + time.min.to_s
    
    @feedback = params[:feedback]
    
    send_feedback = "INSERT INTO feedback (user_id, date_time, feedback) VALUES (?,?,?)"
    $db.execute send_feedback, session[:user_id],  @date_time, params[:feedback]

    puts params
    redirect '/'
end