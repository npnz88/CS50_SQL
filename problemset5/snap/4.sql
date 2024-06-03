SELECT users.username AS "most_popular_user"
FROM messages
JOIN users on messages.to_user_id = users.id
GROUP BY messages.to_user_id
ORDER BY COUNT(messages.to_user_id) DESC, users.username ASC
LIMIT 1;
