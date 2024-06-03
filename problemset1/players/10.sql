-- Example: Find players whose debut was after 2010, rename the column, and sort by debut date.
SELECT "first_name", "last_name", "debut" AS "Debut Year"
FROM players
WHERE "debut" > '2010-01-01'
ORDER BY "debut" DESC;
--check50 cs50/problems/2024/sql/players
