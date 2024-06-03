--using the index created on users last_login_date, we query to find usernames who loged in on or after 2024-01-01

SELECT "username" FROM "users" WHERE "last_login_date" >= "2024-01-01";

