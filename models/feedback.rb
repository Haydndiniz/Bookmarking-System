module Feedback
    
    def Feedback.new(user_id, date_time, feedback_topic, feedback)
        result = false
        insert = "INSERT INTO feedback (user_id, date_time, feedback_topic, feedback) VALUES(?, ?, ?, ?);"
        begin
            $db.execute insert, user_id, date_time, feedback_topic, feedback
            result = true
            puts "Insertion success"
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
   
   def Feedback.getNumber(resolved)
       query = "SELECT COUNT(*)FROM feedback WHERE resolved = ?;"
       result = $db.execute query, resolved
       return result[0][0]
   end
   
   def Feedback.getType(type)
       query = "SELECT COUNT(*)FROM feedback WHERE feedback_topic LIKE (?);"
       result = $db.execute query, '%' + type + '%'
       return result[0][0]
   end
    
end