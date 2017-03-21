CREATE DATABASE "chi";

CREATE TABLE "songs" (
  "id" serial primary key,
  "rank" integer,
  "artist" varchar(80) not null,
  "track" varchar(120) not null,
  "published" date
);

INSERT INTO "songs" ("rank", "track", "artist", "published") 
VALUES (357, 'Wonderwall', 'Oasis', '1-1-1996');

/* Wildcard for select, returns all rows & cols */
SELECT * FROM "songs";

/* Pick specific columns to return */
SELECT "track", "artist" FROM "songs";

/* LIMIT the number of rows */
SELECT * FROM "songs" LIMIT 2;

/* WHERE selects specific data */
SELECT * FROM "songs" WHERE "id" > 105 LIMIT 2;

SELECT * FROM "songs" WHERE "artist" = 'Queen';

SELECT * FROM "songs" WHERE "artist" LIKE '%en';
/*
Multi-line comment
*/
-- Single line comment
SELECT * FROM "songs" WHERE "artist" ILIKE '%EN';

SELECT * FROM "songs" WHERE "published" > '1-1-1980';

SELECT * FROM "songs" 
WHERE "track" ILIKE '%love%' 
AND ("rank" < 400 OR "track" ILIKE '%you');

SELECT * FROM "songs" 
ORDER BY "published" ASC LIMIT 10;--DESC

UPDATE "songs" SET "artist" = 'Chris' 
WHERE "id" = 3; 

UPDATE "songs" SET "artist" = 'Queen' 
WHERE "published" > '1-1-1995';

-- Always SELECT before DELETE
SELECT * FROM "songs" WHERE "id" = 200;

DELETE FROM "songs" WHERE "id" = 200;
