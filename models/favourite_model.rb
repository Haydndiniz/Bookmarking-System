module Favourite

    def Favourite.new(user_id, bookmark_id)
        result = false
        insert = "INSERT INTO favourites (user_id, bookmark_id) VALUES (?,?,?)"
        begin
            $db.execute insert, user_id, bookmark_id
            result = true
            puts "Insertion success"
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
   
   def Favourite.check_if_favourite(user_id, bookmark_id)
       result = false
       query = "SELECT * FROM favourites WHERE user_id = ? AND bookmark_id = ?"
       rows = $db.execute query, user_id, bookmark_id
       if (rows.count == 1)
          result = true
       end
      
      return result
   end 
   
end
