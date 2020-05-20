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
    
    def History.get_last_visit_date(bookmark_id)
        result = Array.new
        query = "SELECT date FROM bookmark_history WHERE bookmark_id = ?;"
        result = $db.execute query, bookmark_id
        return result[result.length-1]
    end
    
    def History.update_date(bookmark_id, date)
        query = "UPDATE bookmark_history SET date = ? WHERE bookmark_id = ?;"
        begin
            $db.execute query, date, bookmark_id
            result = true
            puts "Last visit date updated"
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
    
end