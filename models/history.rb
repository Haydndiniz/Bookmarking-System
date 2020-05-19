module History

def History.new(user_id, bookmark_id, date)
        result = false
        insert = "INSERT INTO bookmark_history (user_id, bookmark_id, date) VALUES (?,?,?)"
        begin
            $db.execute insert, user_id, bookmark_id, date
            result = true
            puts "Insertion success"
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
    
end