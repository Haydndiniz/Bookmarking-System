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
    
    def User.new( first_name, last_name, email, password)
        result = false
        query = "INSERT INTO users ( first_name, last_name, password, email, active_status,admin) VALUES(?, ?, ?, ?,?,?);"
        begin
            $db.execute query, user_id, first_name, last_name, BCrypt::Password.create(password),email,0,0
            result = true
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
   
   def User.getNumber(status)
       query = "SELECT COUNT(*)FROM users WHERE active_status = ?;"
       result = $db.execute query, status
       return result[0][0]
   end
   
   def User.getNew()
       query = "SELECT COUNT(new)FROM users WHERE new = 1;"
       result = $db.execute query
       return result[0][0]
   end
            
end