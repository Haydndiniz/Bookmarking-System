BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "TaggedBookmarks" (
	"BookmarkID"	INTEGER,
	"TagID"	INTEGER,
	FOREIGN KEY("TagID") REFERENCES "Tags"("TagID"),
	FOREIGN KEY("BookmarkID") REFERENCES "Bookmarks"("BookmarkID"),
	PRIMARY KEY("BookmarkID","TagID")
);
CREATE TABLE IF NOT EXISTS "Tags" (
	"TagID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"Name"	TEXT
);
CREATE TABLE IF NOT EXISTS "BookmarkHistory" (
	"UserID"	INTEGER,
	"BookmarkID"	INTEGER,
	"Date"	INTEGER,
	FOREIGN KEY("UserID") REFERENCES "Users"("UserID"),
	FOREIGN KEY("BookmarkID") REFERENCES "Bookmarks"("BookmarkID"),
	PRIMARY KEY("Date","BookmarkID","UserID")
);
CREATE TABLE IF NOT EXISTS "LoginHistory" (
	"UserID"	INTEGER,
	"Date"	INTEGER,
	PRIMARY KEY("UserID","Date")
);
CREATE TABLE IF NOT EXISTS "Favourites" (
	"UserID"	INTEGER,
	"BookmarkID"	INTEGER,
	FOREIGN KEY("UserID") REFERENCES "Users"("UserID"),
	PRIMARY KEY("UserID","BookmarkID"),
	FOREIGN KEY("BookmarkID") REFERENCES "Bookmarks"("BookmarkID")
);
CREATE TABLE IF NOT EXISTS "Bookmarks" (
	"BookmarkID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"BookmarkName"	TEXT,
	"Link"	TEXT UNIQUE,
	"Description"	TEXT,
	"Creator"	INTEGER,
	"LastUpdated"	TEXT,
	"ReportStatus"	INTEGER DEFAULT 0,
	"Rating"	INTEGER DEFAULT 0,
	"NumRatings"	INTEGER DEFAULT 0
);
CREATE TABLE IF NOT EXISTS "Users" (
	"UserID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"FirstName"	TEXT,
	"LastName"	TEXT,
	"Password"	TEXT NOT NULL,
	"Email"	TEXT NOT NULL,
	"ActiveStatus"	INTEGER NOT NULL DEFAULT 1,
	"Admin"	INTEGER NOT NULL DEFAULT 0
);
INSERT INTO "TaggedBookmarks" VALUES (2,2);
INSERT INTO "TaggedBookmarks" VALUES (1,1);
INSERT INTO "TaggedBookmarks" VALUES (1,2);
INSERT INTO "TaggedBookmarks" VALUES (2,1);
INSERT INTO "Tags" VALUES (1,'Tag 1');
INSERT INTO "Tags" VALUES (2,'Tag 2');
INSERT INTO "Bookmarks" VALUES (1,'Important Link','https://www.youtube.com/watch?v=dQw4w9WgXcQ','This link is very important',3,'202003101339',0,5,69);
INSERT INTO "Bookmarks" VALUES (2,'Bookmark1','http://tabs.ultimate-guitar.com/p/panic_at_the_disco/this_is_gospel_ver2_crd.htm','test 1
',1,'202003101339',0,0,0);
INSERT INTO "Bookmarks" VALUES (3,'Bookmark2','https://tabs.ultimate-guitar.com/o/one_direction/steal_my_girl_ver3_crd.htm','test2
',1,'202003101340

',0,0,0);
INSERT INTO "Bookmarks" VALUES (4,'Bookmark3','https://tabs.ultimate-guitar.com/e/ed_sheeran/i_will_take_you_home_ver4_crd.htm','test3',5,'202003101339',0,0,0);
INSERT INTO "Bookmarks" VALUES (5,'Bookmark4','https://tabs.ultimate-guitar.com/e/ed_sheeran/everything_you_are_crd.htm','test4',5,'202003111339',0,0,0);
INSERT INTO "Bookmarks" VALUES (6,'Bookmark5','https://tabs.ultimate-guitar.com/p/panic_at_the_disco/cmon_crd.htm','test5',1,'202003101539',0,0,0);
INSERT INTO "Bookmarks" VALUES (7,'Bookmark6','https://tabs.ultimate-guitar.com/tab/759809','test6',4,'202003101400
',0,0,0);
INSERT INTO "Bookmarks" VALUES (8,'Bookmark7','https://tabs.ultimate-guitar.com/v/vance_joy/riptide_ver3_crd.htm','test7',1,'202003101339',0,0,0);
INSERT INTO "Bookmarks" VALUES (9,'Bookmark8','https://tabs.ultimate-guitar.com/r/rihanna/diamonds_ver6_crd.htm','test8',4,'202003101339',0,0,0);
INSERT INTO "Bookmarks" VALUES (10,'Bookmark9','https://tabs.ultimate-guitar.com/h/hozier/take_me_to_church_ver5_crd.htm','test9',1,'202003101339',0,0,0);
INSERT INTO "Bookmarks" VALUES (11,'Bookmark10','https://tabs.ultimate-guitar.com/o/oasis/half_the_world_away_ver5_crd.htm','test10',2,'202003101339',0,0,0);
INSERT INTO "Bookmarks" VALUES (12,'Bookmark11','https://tabs.ultimate-guitar.com/d/demi_lovato/la_la_land_crd.htm','test11',5,'202003101339',0,0,0);
INSERT INTO "Bookmarks" VALUES (13,'Bookmark12','https://tabs.ultimate-guitar.com/d/demi_lovato/here_we_go_again_crd.htm','test12',1,'202003101339',0,0,0);
INSERT INTO "Bookmarks" VALUES (14,'Bookmark13','https://tabs.ultimate-guitar.com/t/the_jackson_5/i_want_you_back_ver2_crd.htm','test13',2,'202003101339',0,0,0);
INSERT INTO "Bookmarks" VALUES (15,'Bookmark14','https://tabs.ultimate-guitar.com/s/sia/elastic_heart_crd.htm','test14',2,'202003101339',0,0,0);
INSERT INTO "Bookmarks" VALUES (16,'Bookmark15','https://tabs.ultimate-guitar.com/t/the_all-american_rejects/dirty_little_secret_crd.htm','test15',1,'202003101339',0,0,0);
INSERT INTO "Bookmarks" VALUES (17,'Bookmark16','https://tabs.ultimate-guitar.com/y/you_me_at_six/stay_with_me_crd.htm','test16',2,'202003101339',0,0,0);
INSERT INTO "Users" VALUES (1,'John','Smith','password123','john.smith12@intranet.com
',1,0);
INSERT INTO "Users" VALUES (2,'Adh','Mynn
','admin1','adh.mynn@intranet.com',1,1);
INSERT INTO "Users" VALUES (3,'Bob','Bob','Bobbington','bob.bob@intranet.com',1,0);
INSERT INTO "Users" VALUES (4,'Worker','McGee','bricks','contractor.worker.mcgee@intranet.com',0,0);
INSERT INTO "Users" VALUES (5,'Dave','Baker','cake','dave.baker@intranet.com',1,0);
INSERT INTO "Users" VALUES (6,'Karen','Green','femoid','karen.green@intranet.com',1,0);
COMMIT;
