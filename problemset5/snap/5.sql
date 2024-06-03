SELECT friends.friend_id
FROM users
JOIN friends ON users.id = friends.user_id
WHERE users.username = 'lovelytrust487'

INTERSECT

SELECT friends.friend_id
FROM users
JOIN friends ON users.id = friends.user_id
WHERE users.username = 'exceptionalinspiration482';
