CREATE TABLE IF NOT EXISTS "passengers" (
		"first_name" TEXT,
		"last_name"  TEXT,
		"age"        INTEGER
);

CREATE TABLE IF NOT EXISTS "check-in" (
        "date" NUMERIC,
        "flight_id" INTEGER,
        FOREIGN KEY ("flight_id") REFERENCES "flights"("id")
);
CREATE TABLE IF NOT EXISTS "airlines" (
		"id"      INTEGER,
		"name"    TEXT,
		"section" TEXT,
		PRIMARY KEY ("id")
	);
CREATE TABLE IF NOT EXISTS
	"flights" (
		"flight_no"      INTEGER,
		"airline_id"     INTEGER,
		"depart_code"      TEXT,
		"arrival_code"        TEXT,
		"date"           NUMERIC,
		"departure_date" NUMERIC,
		"arrival_date"   NUMERIC,
		FOREIGN KEY ("airline_id") REFERENCES "airlines"("id")
	);
