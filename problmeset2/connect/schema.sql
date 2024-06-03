CREATE TABLE
	IF NOT EXISTS "users" (
		"id"         SERIAL PRIMARY KEY,
		"first_name" TEXT NOT NULL,
		"last_name"  TEXT NOT NULL,
		"password"   VARCHAR(255) NOT NULL
	);

CREATE TABLE
	IF NOT EXISTS "schools" (
		"id" SERIAL PRIMARY KEY,
		"school_name" TEXT NOT NULL,
		"type_school" TEXT,
		"location_school" TEXT,
		"founded" DATE
	);

CREATE TABLE
	IF NOT EXISTS "company" (
		"company_id" INTEGER,
		"company_name" TEXT NOT NULL,
		"industry" TEXT,
		"location" TEXT
	);

CREATE TABLE
	IF NOT EXISTS "connects" (
		"user_connected" INTEGER NOT NULL,
		"user_connected_with" INTEGER NOT NULL
	);

CREATE TABLE
	IF NOT EXISTS "school_affiliate" (
		"school_attendee_id" INTEGER,
		"school_id", INTEGER,
		"start_affiliation_date" DATE,
		"graduation_date" DATE,
		"education_type" TEXT,
		"status"     TEXT CHECK ("status" IN ('earned', 'pursued')),
		"type"       TEXT CHECK ("type"   IN ('BA', 'MA', 'PhD', 'etc')),
		FOREIGN KEY ("school_attendee_id")   REFERENCES "users" ("id"),
		FOREIGN KEY ("school_id") REFERENCES "schools" ("id")
	);

CREATE TABLE
	IF NOT EXISTS "company_affiliate" (
		"company_affiliate_id" INTEGER,
		"company_id" INTEGER,
		"start_work_date" DATE,
		"end_work_date" DATE,
		"employee_title" TEXT,
		FOREIGN KEY ("company_affiliate_id")    REFERENCES "users" ("id"),
		FOREIGN KEY ("company_id") REFERENCES "company" ("company_id")
	);

