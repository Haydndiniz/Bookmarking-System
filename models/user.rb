require 'sqlite3'

module User
    def User.find_user(email, pass)
       
       verified = false
       if !email.empty? && !pass.empty? 
          user = $db.execute "SELECT email FROM users WHERE email = '"+email+"'"                #search for an email given in the form
          user_password = $db.execute "SELECT password FROM users WHERE email = '"+email+"'"    #search for password assigned to a given email
          password = $db.execute "SELECT password FROM users WHERE password = '"+pass+"'"       #search for a password given in the form
          if !user.empty? && !password.empty? && user_password == password
             verified = true
          end
       end        
          return verified
    end
      
    def User.logged_in?(session)
        session.nil? ? false : true
    end
    
    def User.new(first_name, last_name, email, password, admin)
        
    end
end