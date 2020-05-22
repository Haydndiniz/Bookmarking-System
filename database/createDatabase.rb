require 'sqlite3'
require 'csv'

csv_text_feedback = File.read("public/csv/feedback.csv")
csvFeedback = CSV.parse(csv_text_feedback, :headers => true)

csv_text_bookmark_history = File.read("public/csv/bookmark_history.csv")
csvBookmarkHistory = CSV.parse(csv_text_bookmark_history, :headers => true)

csv_text_bookmarks = File.read("public/csv/bookmarks.csv")
csvBookmarks = CSV.parse(csv_text_bookmarks, :headers => true)

csv_text_users = File.read("public/csv/users.csv")
csvUsers = CSV.parse(csv_text_users, :headers => true)

csv_text_favourites = File.read("public/csv/favourites.csv")
csvFavourites = CSV.parse(csv_text_favourites, :headers => true)

csv_text_login_history = File.read("public/csv/login_history.csv")
csvLoginHistory = CSV.parse(csv_text_login_history, :headers => true)

csv_text_tags = File.read("public/csv/tags.csv")
csvTags = CSV.parse(csv_text_tags, :headers => true)

csv_text_tagged_bookmarks = File.read("public/csv/tagged_bookmarks.csv")
csvTaggedBookmarks = CSV.parse(csv_text_tagged_bookmarks, :headers => true)

inputs = ARGV
if inputs[0] == "testdb"
  DB = SQLite3::Database.new 'database/acme_test_db.sqlite'
else
  DB = SQLite3::Database.new 'database/acme_db.sqlite'
end

# Create tables
DB.execute <<-SQL
CREATE TABLE IF NOT EXISTS "tagged_bookmarks" (
	"bookmark_id"	INTEGER,
	"tag_id"	INTEGER,
	FOREIGN KEY("tag_id") REFERENCES "tags"("tag_id"),
	FOREIGN KEY("bookmark_id") REFERENCES "bookmarks"("bookmark_id")
);
SQL

DB.execute <<-SQL
CREATE TABLE IF NOT EXISTS "tags" (
	"tag_id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"name"	TEXT
);

SQL

DB.execute <<-SQL
CREATE TABLE IF NOT EXISTS "bookmark_history" (
	"user_id"	INTEGER,
	"bookmark_id"	INTEGER,
	"date"	INTEGER,
	FOREIGN KEY("user_id") REFERENCES "users"("user_id"),
	FOREIGN KEY("bookmark_id") REFERENCES "bookmarks"("bookmark_id")
);
SQL

DB.execute <<-SQL
CREATE TABLE IF NOT EXISTS "login_history" (
	"user_id"	INTEGER,
	"date"	INTEGER,
	PRIMARY KEY("user_id","date")
);
SQL

DB.execute <<-SQL
CREATE TABLE IF NOT EXISTS "favourites" (
	"user_id"	INTEGER,
	"bookmark_id"	INTEGER,
	FOREIGN KEY("user_id") REFERENCES "users"("user_id"),
	PRIMARY KEY("user_id","bookmark_id"),
	FOREIGN KEY("bookmark_id") REFERENCES "bookmarks"("bookmark_id")
);
SQL

DB.execute <<-SQL
CREATE TABLE IF NOT EXISTS "bookmarks" (
	"bookmark_id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"bookmark_name"	TEXT,
	"link"	TEXT UNIQUE,
	"description"	TEXT,
	"creator"	INTEGER,
	"last_updated"	TEXT,
	"report_status"	INTEGER DEFAULT 2,
	"rating"	INTEGER DEFAULT 0,
	"num_ratings"	INTEGER DEFAULT 0
);
SQL

DB.execute <<-SQL
CREATE TABLE IF NOT EXISTS "users" (
	"user_id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"username"  TEXT NOT NULL UNIQUE,
	"first_name"	TEXT,
	"last_name"	TEXT,
	"password"	TEXT NOT NULL,
	"email"	TEXT NOT NULL,
	"active_status"	INTEGER NOT NULL DEFAULT 0,
	"admin"	INTEGER NOT NULL DEFAULT 0,
   "new"	INTEGER NOT NULL DEFAULT 1
);
SQL

DB.execute <<-SQL
CREATE TABLE IF NOT EXISTS "feedback" (
	"feedback_id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"user_id"	TEXT NOT NULL,
	"date_time"	TEXT NOT NULL,
   "feedback_topic" TEXT NOT NULL,
	"feedback"	TEXT NOT NULL,
	"resolved"	INTEGER NOT NULL DEFAULT 0,
	"bookmark_id" DEFAULT NULL,
	FOREIGN KEY("user_id") REFERENCES "users"("user_id")
  );
SQL



csvTaggedBookmarks.each do |row|
    DB.execute "insert into tagged_bookmarks values ( ?, ?)", row.fields
end

csvBookmarks.each do |row|
    DB.execute "insert into bookmarks values ( ?, ?, ?, ?, ?, ?, ?, ?, ?)", row.fields
end


csvBookmarkHistory.each do |row|
    DB.execute "insert into bookmark_history values ( ?, ?, ?)", row.fields
end

csvUsers.each do |row|
    DB.execute "insert into users values ( ?, ?, ?, ?, ?, ?, ?, ?,?)", row.fields
end

csvTags.each do |row|
    DB.execute "insert into tags values ( ?, ?)", row.fields
end

csvFeedback.each do |row|
    DB.execute "insert into feedback values (?, ?, ?, ?, ?, ?, ?)", row.fields
end

csvLoginHistory.each do |row|
    DB.execute "insert into login_history values ( ?, ?)", row.fields
end

csvFavourites.each do |row|
    DB.execute "insert into favourites values ( ?, ?)", row.fields
end
