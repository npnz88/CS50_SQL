-- Example: List the titles of episodes released in 2020 and have a topic related to technology.
SELECT title
FROM episodes
WHERE air_date BETWEEN '2020-01-01' AND '2020-12-31' AND topic LIKE '%Technology%';
