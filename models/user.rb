module User
  DATABASE = './database_encrypted_passwords.sqlite'  
    
    #def User.find_user(email, pass)
       #verified = false
       #if !email.empty? && !pass.empty? 
          #user = $db.execute "SELECT email FROM users WHERE email = '"+email+"'"                #search for an email given in the form
          #user_password = $db.execute "SELECT password FROM users WHERE email = '"+email+"'"    #search for password assigned to a given email
          #password = $db.execute "SELECT password FROM users WHERE password = '"+pass+"'"       #search for a password given in the form
          #if !user.empty? && !password.empty? && user_password == password
             #verified = true
          #end
       #end        
          #return verified
    #end 
    
    def User.find_user(email, pass)
       result = false
       db = SQLite3::Database.new DATABASE
       query = "SELECT password FROM users WHERE email = ?;"
       rows = db.execute query, email
       if (rows.count == 1)
           hash_check = BCrypt::Password.new(rows[0][0])
           result = hash_check.is_password?(pass)
       end
       return result
    end 
    
      
    def User.logged_in?(session)
        session.nil? ? false : true
    end
    
    def User.new(user_id, first_name, last_name, email, password)
        result = false
        db = SQLite3::Database.new DATABASE
        query = "INSERT INTO users (user_id, first_name, last_name, email, password) VALUES(?, ?, ?, ?, ?);"
        begin
            db.execute query, user_id, first_name, last_name, email, BCrypt::Password.create(password)
            result = true
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
            
end