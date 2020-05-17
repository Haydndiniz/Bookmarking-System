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
    
    def User.find_email(email)  #method cheks if there's a user with given email
       result = false
       query = "SELECT email FROM users WHERE email = ?;"
       rows = $db.execute query, email
       if (rows.count == 1)
           result = true
       end
       return result
    end 
    
    def User.find_username(username)  #method cheks if there's a user with given username
       result = false
       query = "SELECT username FROM users WHERE username = ?;"
       rows = $db.execute query, username
       if (rows.count == 1)
           result = true
       end
       return result
    end
    
      
    def User.logged_in?(session)      #not sure if we need separate function for this
        session.nil? ? false : true   #we can verify if user is logged using function find_user
    end
    
    def User.new(username, first_name, last_name, password, email)
        result = false
        query = "INSERT INTO users (username, first_name, last_name, password, email) VALUES(?,?,?,?,?);"
        begin
            $db.execute query, username, first_name, last_name, BCrypt::Password.create(password), email
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
   
    def User.approve(user_id)
       query = "UPDATE users SET active_status = 1, new = 0
                 WHERE user_id = ?;"
        begin
            $db.execute query, user_id
            result = true
            puts "user added"
        rescue SQLite3::ConstraintException
            puts "failed to add user"
        end
   end
            
end