SELECT COUNT(*) AS count_players
FROM players
WHERE ("bats" = 'Right' AND "throws" = 'Left') OR ("bats" = 'Left' AND "throws" = 'Right');
