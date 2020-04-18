module Feedback
    
    def Feedback.new(user_id, date_time, topic, feedback)
        result = false
        insert = "INSERT INTO feedback ( user_id, date_time, topic, feedback) VALUES(?, ?, ?, ?);"
        begin
            $db.execute insert, user_id, date_time, topic, feedback
            result = true
            puts "Insertion success"
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
    
end