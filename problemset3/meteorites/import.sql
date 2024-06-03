--import the values into a temp table in sqlite3
CREATE TABLE "meteorites_temp" (
    name TEXT,
    id INTEGER,
    nametype TEXT,
    class TEXT,
    mass FLOAT,
    discovery TEXT,
    year INTEGER,
    lat FLOAT,
    long FLOAT
);

.import --csv --skip 1 meteorites.csv meteorites_temp

--update values in temp table
UPDATE "meteorites_temp"
SET "mass" = CASE WHEN "mass" = '' THEN NULL ELSE "mass" END,
    "lat" = CASE WHEN "lat" = '' THEN NULL ELSE "lat" END,
    "long" = CASE WHEN "long" = '' THEN NULL ELSE "long" END,
    "year" = CASE WHEN "year" = '' THEN NULL ELSE "year" END;

UPDATE "meteorites_temp"
SET "mass" = ROUND("mass", 2),
    "lat" = ROUND("lat", 2),
    "long" = ROUND("long", 2);

delete from meteorites_temp WHERE nametype = 'Relict';

--create new table with primary key that auto increments

CREATE TABLE "meteorites" (
    id INTEGER PRIMARY KEY,
    name TEXT,
    class TEXT,
    mass FLOAT,
    discovery TEXT,
    year INTEGER,
    lat FLOAT,
    long FLOAT
);



-- insert values into the new table

INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long" FROM "meteorites_temp"
ORDER BY "year", "name";

DROP TABLE "meteorites_temp";
