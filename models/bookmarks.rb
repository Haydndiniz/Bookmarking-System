module Bookmark
    
    def Bookmark.new(bookmark_id, bookmark_name, link, description, creator, last_updated)
        result = false
        insert = "INSERT INTO bookmarks (bookmark_id, bookmark_name, link, description, creator, last_updated) VALUES(?, ?, ?, ?, ?, ?);"
        begin
            $db.execute insert, bookmark_id, bookmark_name, link, description, creator, last_updated
            result = true
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
    
    def Bookmark.find_by(search)
        result[]
        db = Sqlite::Database.new '../database/acme_db.sqlite'
        query = "SELECT"
    end
        
end