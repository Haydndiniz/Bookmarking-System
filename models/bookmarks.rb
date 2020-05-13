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
        #db = Sqlite::Database.new '../database/acme_db.sqlite'
        query = "SELECT * FROM bookmarks WHERE bookmark_name LIKE (?);"
        result = $db.execute query, '%' + search + '%'
        return result
    end
    
    def Bookmark.find_by_id(bookmark_id)
        result = Array.new
        query = "SELECT * FROM bookmarks WHERE bookmark_id = (?);"
        result = $db.execute query, bookmark_id
        return result
    end
    
    def Bookmark.update(bookmark_name, link, description, last_updated, bookmark_id)
        result = false
        updateQuery = "UPDATE bookmarks SET bookmark_name = ?, link = ?,
                description = ?, last_updated = ? WHERE  bookmark_id = ?;"
        begin
            $db.execute updateQuery, bookmark_name, link, description, last_updated, bookmark_id
            result = true
            puts "Insertion success"
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result        
    end
   
    def Bookmark.getStatus(status)
        query = "SELECT COUNT (*) FROM bookmarks WHERE report_status = ?;"
        result = $db.execute query, status
        return result[0][0]   
    end
    
end