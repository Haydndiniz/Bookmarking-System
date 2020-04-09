module User
         
    def User.find_user(email, pass)
       result = false
       query = "SELECT password FROM users WHERE email = ?;"
       rows = $db.execute query, email
       if (rows.count == 1)
           hash_check = BCrypt::Password.new(rows[0][0])
           result = hash_check.is_password?(pass)
       end
       return result
    end 
    
      
    def User.logged_in?(session)      #not sure if we need separate function for this
        session.nil? ? false : true   #we can verify if user is logged using function find_user
    end
    
    def User.new(user_id, first_name, last_name, email, password)
        result = false
        query = "INSERT INTO users (user_id, first_name, last_name, email, password) VALUES(?, ?, ?, ?, ?);"
        begin
            $db.execute query, user_id, first_name, last_name, email, BCrypt::Password.create(password)
            result = true
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
            
end