require 'sqlite3'

module User
    def User.find_user(email, pass)
       @db = SQLite3::Database.new './Database.db'
       verified = false
       if !email.empty? && !pass.empty? 
          user = @db.execute "SELECT Email FROM Users WHERE Email = '"+email+"'"                #search for an email given in the form
          user_password = @db.execute "SELECT Password FROM Users WHERE Email = '"+email+"'"    #search for password assigned to a given email
          password = @db.execute "SELECT Password FROM Users WHERE Password = '"+pass+"'"       #search for a password given in the form
          if !user.empty? && !password.empty? && user_password == password
             verified = true
          end
       end
          
          return verified
    end
    
    def User.logged_in?(session)
        session.nil? ? false : true
    end
end