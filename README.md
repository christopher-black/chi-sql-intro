# ChiYak SQL Intro
## Why databases?
- Data persistance
- Access from multiple sources
- Scales much better

## Draw picture
Structured Query Language (SQL) is a standard computer language for relational database management and data manipulation. SQL is used to query, insert, update and modify data.

## Intro to Relational Databases
We will be using Postgres for our database and Postico for our client. Keep in mind you can use Postgres with Node.js, SQLite for mobile or MySQL for PHP. SQL is common across all of these different platforms.

Think of relational databases like a spreadsheet full of data.
```
+----+------+------------+---------------+----------+
| id | rank |   artist   |     track     |   date   |
+----+------+------------+---------------+----------+
|  1 |    3 | The Doors  | Light My Fire | 1/1/1967 |
|  2 |    7 | Oasis      | Wonderwall    | 1/1/1996 |
|  3 |   10 | Neil Young | Heart of Gold | 1/1/1972 |
+----+------+------------+---------------+----------+
```
- Designed to be able to efficiently read and write large amounts of data when properly configured

- Provides ACID guarantees:

 - Atomicity - Each transaction is all or nothing.
 - Consistency - Data must be valid. All constraints still hold.
 - Isolation - Concurrent transactions should appear serial to the user, no in progress query should know about data from another in progress query.
 - Durability - withstand crashes and power failures.

## Intro to Postico
- Start your database
`brew services list`
`brew services start postgresql`

- Open Positco
- Create a database named `phi`

```
CREATE DATABASE "phi";
```

- Create your first table

```
CREATE TABLE "songs" (
  "id" serial primary key,
  "rank" integer,
  "artist" varchar(80) not null,
  "track" varchar(120) not null,
  "published" date
);
  
CREATE TABLE name (
  column-name data-type constraints,
  ...
);  
```

- Discuss [data types](https://www.postgresql.org/docs/8.1/static/datatype.html)
- `cmd-r` to refresh, our table exists!
- Manually enter data (GUI)

> 1 - Add Billy Joel - We Didn't Start the Fire - 1/1/1989

- Click on Show SQL
- Edit inline
- Navigate around
- Go back to the SQL Query

### INSERT
Add a new row to the database. Only fields marked as NOT NULL are required. Column names are entered using `""` and values are entered with `''`.

```
INSERT INTO "songs" ("id", "rank", "track", "artist", "published") 
VALUES (1, 357, 'Wonderwall', 'Oasis', '1-1-1996');
```
- What went wrong? **Our id must be unique.**
- Let's try that again without an **id** (it will auto increment)

```
INSERT INTO "songs" ("rank", "track", "artist", "published") 
VALUES (357, 'Wonderwall', 'Oasis', '1-1-1996');
```

- INSERT multiple records

```
INSERT INTO "songs" ("rank", "track", "artist", "published") 
VALUES (357, 'Wonderwall', 'Oasis', '1-1-1996'),
(102, 'Under the Bridge', 'Red Hot Chili Peppers', '1-1-1992');
```

- `cmd-r` to refresh, our song exists!

#### Import Data
This could take a while... lets import songs.sql to get some more interesting data. Load up songs.sql (upload to Slack).

### SELECT
Queries for data in the database.

```
/* Wildcard for select, returns all rows & columns */
SELECT * FROM "songs";

/* Pick specific columns */
SELECT "track", "artist" FROM "songs";

/* LIMIT the number of rows, must be last! */
SELECT * FROM "songs" LIMIT 10; 

/* WHERE selects specific data */
SELECT * FROM "songs" 
WHERE "id" = 1;

/* Results that match... % match all. */
SELECT "track", "artist" FROM "songs" 
WHERE "track" LIKE '%Fire%' LIMIT 10;

/* SELECT all columns
SELECT * FROM "songs" WHERE "track" ILIKE '%fire%';

SELECT "track", "artist", "published" FROM "songs" 
WHERE "published" > '1/1/2016' LIMIT 10;

/* ORDER BY column_name ASC or DESC */
SELECT "track", "artist", "published" FROM "songs" 
WHERE "published" > '1/1/1980'
ORDER BY "published" DESC LIMIT 20;

/* LIKE condition IS case-sensitive */
SELECT COUNT(*) FROM "songs"
WHERE LOWER("track") LIKE '%fire%';

/* 
WHERE conditions can be joined with AND, OR & NOT 
SELECT all columns from songs where the artist has an 'a' in the name AND was published after 1/1/2000 OR track has fire in the name.
*/
SELECT * FROM "songs"
WHERE ("artist" LIKE '%a%' AND "published" > '1/1/2000')
OR "track" ILIKE '%fire%';

/* In summary 
SELECT column
FROM table
[WHERE conditions]
[ORDER BY column [ ASC | DESC ]]
LIMIT number_rows [ OFFSET offset_value ];
*/
```

### UPDATE
Updates an existing record.

`UPDATE "songs" SET "artist"='Chris Black' WHERE id = 1;`

**DON'T FORGET THE WHERE**

Update Wonderwall to rank #1

`UPDATE "songs" SET "rank"=1 WHERE "track" = 'Wonderwall';`


Replace `Fire` with `Phire`

```
/* REPLACE searches the the first string for any occurance of the the second string and replaces it with the third string. You can also do replacements of different sizes */
UPDATE "songs" SET "track" = replace("track", 'Fire', 'Phire');

SELECT "track", "artist" FROM "songs" 
WHERE "track" LIKE '%Phire%' LIMIT 10;

SELECT COUNT(*) FROM "songs"
WHERE "track" LIKE '%Fire%';

SELECT * FROM "songs"
WHERE "track" LIKE '%Phire%';
```
Only use REPLACE when replacing substrings. If replacing the whole value, `SET column = value WHERE condition` is sufficient.


### DELETE
Deletes an existing record.

```
/* Test before DELETE */
SELECT * FROM "songs" WHERE "artist" LIKE 'Kanye West';
/* Actually DELETE */
DELETE FROM "songs" WHERE "artist" LIKE 'Kanye West';

DELETE FROM table
[WHERE conditions];
```