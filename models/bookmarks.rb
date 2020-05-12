module Bookmark
    
    def Bookmark.new(bookmark_name, link, description, creator, last_updated)
        result = false
        insert = "INSERT INTO bookmarks (bookmark_name, link, description, creator, last_updated, report_status) VALUES (?,?,?,?,?,?)"
        begin
            $db.execute insert, bookmark_name, link, description, creator, last_updated, 1
            result = true
            puts "Insertion success"
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
    
    def Bookmark.find_by(search)
        if search
            db = Sqlite::Database.new '../database/acme_db.sqlite'
            query = "SELECT * FROM bookmarks WHERE bookmark_name LIKE ?;"
            result = $db.execute query, '%' + @search + '%'
            return result
        end
    end
        
end