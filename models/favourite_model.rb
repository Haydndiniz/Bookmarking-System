module Favourite

    def Favourite.new(user_id, bookmark_id)
        result = false
        insert = "INSERT INTO favourites (user_id, bookmark_id) VALUES (?,?)"
        begin
            $db.execute insert, user_id, bookmark_id
            result = true
            puts "Insertion success"
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
   
end
