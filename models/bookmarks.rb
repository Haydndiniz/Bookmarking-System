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
    
    def Bookmark.find_by(search, tags)
        # something is wrong, wont filter if 2 selected, only works for 1 at a time
        # issue probably to do with dynamic generation of query
        # the sql statement works perfectly in db browser
        searchTerm = '%' + search + '%'
        if tags == 0
            query = "SELECT DISTINCT * FROM bookmarks WHERE bookmark_name LIKE (?) OR link LIKE (?);"
            result = $db.execute query, searchTerm, searchTerm
        else 
            tagsString = ""
            tags.each_value do |tag|
                tagsString =  tagsString + tag.to_s + ', '
            end
            #get rid of extra ", " at the end of string
            tagsString = tagsString.chop
            tagsString = tagsString.chop
            
            #puts tags
            puts tagsString
            
            #build the query
            query = "SELECT DISTINCT bookmarks.bookmark_id, bookmark_name, link, description, creator, last_updated, report_status, rating, num_ratings 
                    FROM bookmarks 
                    JOIN tagged_bookmarks ON bookmarks.bookmark_id = tagged_bookmarks.bookmark_id 
                    JOIN tags ON tagged_bookmarks.tag_id = tags.tag_id 
                    WHERE tags.name IN ((?)) 
                    AND (bookmark_name LIKE (?) OR link LIKE (?));"

            result = $db.execute query, tagsString, searchTerm, searchTerm
        end
        
        return result
    end
    
    def Bookmark.find_by_id(bookmark_id)
        result = Array.new
        query = "SELECT * FROM bookmarks WHERE bookmark_id = (?);"
        result = $db.execute query, bookmark_id
        return result[0]
    end
    
    def Bookmark.update(bookmark_name, link, description, last_updated, bookmark_id)
        result = false
        query = "UPDATE bookmarks SET bookmark_name = ?, link = ?,
                description = ?, last_updated = ? WHERE  bookmark_id = ?;"
        begin
            $db.execute query, bookmark_name, link, description, last_updated, bookmark_id
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
    
    def Bookmark.reportBookmark(bookmark_id)
        query = "UPDATE bookmarks SET report_status = 1 where bookmark_id = ?;"
        begin
            $db.execute query, bookmark_id
            result = true
            puts "Insertion success"
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
    
   def Bookmark.updateRating(bookmark_id, submitted_rating, num_ratings, current_rating)
        query = "UPDATE bookmarks SET rating = ?, num_ratings = ? WHERE bookmark_id = ?;"
        rating = ((current_rating*num_ratings)+submitted_rating)/(num_ratings +1)
        num_ratings = num_ratings + 1
        begin
            $db.execute query, rating, num_ratings, bookmark_id
            result = true
            puts "New rating submitted"
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
    
    def Bookmark.updateLastVisited(bookmark_id, last_visited)
        query = "UPDATE bookmarks SET last_visited = ? WHERE bookmark_id = ?;"
        begin
            $db.execute query, last_visited, bookmark_id
            result = true
            puts "Last visit date updated"
        rescue SQLite3::ConstraintException
            puts "Insertion Failed"
        end
        return result
    end
    
   #method to get the truncated url without subpages
   def Bookmark.getHost(url)
      uri = URI(url)  
      return uri.host      
   end
end