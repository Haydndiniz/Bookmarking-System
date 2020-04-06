require 'sqlite3'

before do
  @db = SQLite3::Database.new '../database.sql'
end

module User
    def User.find_user(email, pass)
       
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
    
    def User.new(first_name, last_name, email, password, admin)
        
    end
end