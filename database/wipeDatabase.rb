require 'sqlite3'
DB = SQLite3::Database.new 'acme_db.sqlite'

DB.execute <<-SQL
  DROP TABLE IF EXISTS "feedback";
SQL
DB.execute <<-SQL
  DROP TABLE IF EXISTS "users";
SQL
DB.execute <<-SQL
  DROP TABLE IF EXISTS "bookmarks";
SQL
DB.execute <<-SQL
  DROP TABLE IF EXISTS "tags";
SQL
DB.execute <<-SQL
  DROP TABLE IF EXISTS "tagged_bookmarks";
SQL
DB.execute <<-SQL
  DROP TABLE IF EXISTS "login_history";
SQL
DB.execute <<-SQL
  DROP TABLE IF EXISTS "bookmark_history";
SQL
DB.execute <<-SQL
  DROP TABLE IF EXISTS "favourites";
SQL